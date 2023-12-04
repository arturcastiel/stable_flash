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
        delta_ki= [0, 0, 0.1, 0, 0, 0 0]';
    end
    properties (Access = private)
        R = 83.1447; % bar cm^3 mol^(-1) K^(-1);
        T = 90 + 273.15 % Isothermal Condition
        delta_ind = logical([ 0 0 1; ...
                              0 1 0; ...
                              0 1 1; ...
                              1 0 0; ...
                              1 0 1; ...
                              1 1 0]); 
        num_cells
    end
    
    methods
        function obj = PhaseClass(Components, x_ij)
            %PhaseClass Constructors;
            obj.Components = Components;
            obj.num_components = length(Components);
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
            % Computing aki
            aki = obj.compute_aki(ak);
            % Compute Mixture Parameters
            aj = obj.compute_mixture_aj(ak);
            bj = obj.compute_mixture_bj(bk);
        end

            
        
    end
end
