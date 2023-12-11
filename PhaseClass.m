classdef PhaseClass < handle
    %UNTITLED5 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        %% List with object that represent each component in this phase
        Components
        %% Number of Components in this Phase
        num_components
        %% Matrix that contains the fraction of component i in phase j
        x_ij
        %% Matrix that contains the binary interaction coeficient between
        %% component k_i
        delta_ki
        %% aki - Component Compoent Iteration Coeficient
        aki
        %% Phase aj bj Parameters (Peng Robison Equation)
        aj
        bj
        %% Boolean that states if Phase is Aqueos
        isAq = false;
        %% Component's Symbols
        symbols
    end
    properties (Access = private)
        compWater
        %% binary interaction coefficient for constant parameters
        tabled_delta_ki_ind
        tabled_delta_ki
        R = 83.1447; % bar cm^3 mol^(-1) K^(-1);
        T = 90 + 273.15 % Isothermal Condition
        delta_ind
        num_cells
    end
    
    methods
        function obj = PhaseClass(Components, x_ij)
            %PhaseClass Constructors;
            obj.Components = Components;
            obj.num_components = length(Components);
            obj.symbols = [Components(:).symbol];
            [obj.tabled_delta_ki_ind, obj.tabled_delta_ki] =  ...
                                    read_delta_table(obj.symbols);
            obj.compWater = (ismember(obj.symbols,"water"));
            obj.delta_ind = obj.tabled_delta_ki_ind;
            obj.x_ij = x_ij;
            obj.num_cells = length(x_ij);
            obj.initalize_eos();
           % obj.delta_ki = delta_ki;
        end
        
    end
        
    methods (Access = private)    
        function initalize_eos(obj)
            obj.isAq = obj.checkIfAqueous();      
            %obj.delta_ki = obj.define_binary_coef;
            
            % Prepare the Constants for Peng Robisonb EOS
            ak = horzcat(obj.Components(:).ak);
            bk = [obj.Components(:).bk]';  
            % Computing aki - Component Compoent Iteration Coeficient
            obj.aki = obj.compute_aki(ak);
            % Compute Mixture Parameters
            obj.aj = obj.compute_mixture_aj();
            obj.bj = obj.compute_mixture_bj(bk);
        end
        function [aki] = compute_aki(obj, ak)
            ind_list = generate_arrange_2(obj.num_components);
            aki = zeros(length(ak), length(ind_list));
            for index = 1:length(ind_list)
                k_ind = ind_list(index,1);
                i_ind = ind_list(index,2);
                ref = ((obj.delta_ind(:,1) == k_ind) & ...
                    (obj.delta_ind(:,2) == i_ind)) |  ...
                    ((obj.delta_ind(:,1) == i_ind) & ...
                    (obj.delta_ind(:,2) == k_ind));
                if any(ref)
                    delta = obj.tabled_delta_ki(ref)*ones(obj.num_cells,1);
                    water_ref = ([k_ind i_ind] == find(obj.compWater));
                    if any(obj.isAq) && any(water_ref)
                        no_water_ind =  [k_ind i_ind];
                        no_water_ind = no_water_ind(~water_ref);
                        delta(obj.isAq) = obj.Components(no_water_ind). ...
                                        AqueousBinaryCoefficient(obj.isAq);                    
                    end
                else
                    delta = 0;
                end
                aki(:,index) = (1 - delta) .* ...
                    (ak(:,k_ind).* ak(:,i_ind)).^.5;
            end
        end
        function aj = compute_mixture_aj(obj)
            aj = zeros(length(obj.x_ij),1);
            ind_list = generate_arrange_2(obj.num_components);
            for index = 1:length(ind_list)
                k_ind = ind_list(index,1);
                i_ind = ind_list(index,2);
                aki_local = obj.aki(:,index);
                aj = aj + (obj.x_ij(:,k_ind) .* obj.x_ij(:,i_ind).* ...
                                                            aki_local);
            end
        end
        function bj = compute_mixture_bj(obj, bk)
            bj = zeros(length(obj.x_ij),1);
            bks = 1
               
        end
        function isAq = checkIfAqueous(obj)
            if ~any(obj.compWater,2)
                isAq = false;
            else
                water_fraction = obj.x_ij(:,obj.compWater);
                isAq = water_fraction > 0.8;
            end
        end    
    end
end


function [delta_ind_sorted, delta_sorted] = read_delta_table(comp_symbols)
filepath = fullfile(pwd,"physical_parameter/bip_data.csv");
all_table = readtable(filepath);
comp12 = [all_table.symbols1 all_table.symbols2];
ref =  all(ismember(comp12,comp_symbols),2);
symbols = [all_table.symbols1(ref) all_table.symbols2(ref)];
delta = all_table.delta(ref);
delta_ind = zeros(size(symbols));
for index = 1:length(comp_symbols)
    local_symbol = comp_symbols(index);
    symbol_ref = ismember(symbols, local_symbol);
    delta_ind(symbol_ref) = index;
end
%% ensuring that column1 < column2 and sortingrows
ref = delta_ind(:,1) > delta_ind(:,2);
auxvar = delta_ind(ref,1);
delta_ind(ref,1) = delta_ind(ref,2);
delta_ind(ref,2) = auxvar;
[delta_ind_sorted, ref] = sortrows(delta_ind);
delta_sorted = delta(ref);
end
