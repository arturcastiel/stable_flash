classdef ComponentWater < ComponentClass
    % ComponentWater Class that defines the modefied parameters for the
    % EOS Peng Robison. Methods are overloaded including algorithms 
    % specific to compute water/brine.
    properties(Access = private)
        physical_props = struct("p_c",220.64, ...
                                "t_c",647.10, ...
                                "af",0.344, ...
                                "mw",18.02, ...
                                "symbol", "water");
    end

    methods
        function obj = ComponentWater()
            %ComponentWater Constructor of Water Component Class
            obj = obj.setup(obj.physical_props.p_c,  ...
                obj.physical_props.t_c, obj.physical_props.af, ...
                obj.physical_props.mw, obj.physical_props.symbol);
        end
    end
    methods (Access = protected)
        function [ak,bk] = compute_component_ak_bk(obj)
            %% coeficients for pure components according to
            % Li and Yang (2013) parameters for water
            c = [1.00095, 0.39222, 0.07294, 0.00706];
            Tr = (obj.T/obj.T_critical);
            alpha_k = (c(1) + c(2)*(1 - Tr) - c(3)*(1- (Tr.^-1)) + c(4)*...
                (1-(Tr.^-2))).^2;          
            ak = (0.45724 * obj.R^2 * obj.T_critical.^2 .* alpha_k) ...
                                            / obj.P_critical;
            bk = 0.07780 * obj.R * obj.T_critical / obj.P_critical;
        end
    end    
    
end

