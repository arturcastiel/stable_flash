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
        delta_ki= [0.1, 0, 0]';
        %% aki - Component Compoent Iteration Coeficient
        aki
        %% Phase aj bj Parameters (Peng Robison Equation)
        aj
        bj
    end
    properties (Access = private)
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
            obj.delta_ind = nchoosek(1:obj.num_components,2);
            obj.x_ij = x_ij;
            obj.num_cells = length(x_ij);
            obj.initalize_eos();
           % obj.delta_ki = delta_ki;
        end
        
    end
        
    methods (Access = private)    
        function initalize_eos(obj)
            % Prepare the Constants for Peng Robisonb EOS
            ak = horzcat(obj.Components(:).ak);
            bk = [obj.Components(:).bk]';  
            % Computing aki - Component Compoent Iteration Coeficient
            obj.aki = obj.compute_aki(ak);
            % Compute Mixture Parameters
            obj.aj = obj.compute_mixture_aj();
            %bj = obj.compute_mixture_bj(bk);
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
                    delta = obj.delta_ki(ref);
                else
                    delta = 0;
                end
                  %delta = (obj.delta_ki(index);
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
        function bj = compute_mixture_bj(obj)
            bj = zeros(length(obj.x_ij),1);
               

        end
    end
end
