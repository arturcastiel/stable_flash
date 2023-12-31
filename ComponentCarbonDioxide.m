classdef ComponentCarbonDioxide < ComponentClass
    % ComponentClass Class that defines the parameters for the EOS of Peng
    % Robison specialized for CO2
     properties(Access = private)
        physical_props = struct("p_c",73.82, ...
                                "t_c",304.19, ...
                                "af",0.228, ...
                                "mw",44.01, ...
                                "symbol", "carbon_dioxide");
     end
    
    methods
        function obj = ComponentCarbonDioxide
            obj = obj.setup(obj.physical_props.p_c,  ...
                obj.physical_props.t_c, obj.physical_props.af, ...
                obj.physical_props.mw, obj.physical_props.symbol);
        end
        function delta = AqueousBinaryCoefficient(obj, isAqCells)
           T = obj.T(isAqCells);
           Tr = T./obj.T_critical;
           delta = -1.104324 + (2.040527*Tr) -(1.417707*Tr.^2) + ...
                                                    0.379003*Tr.^3;
        end        
    end
end


