classdef ComponentMethane < ComponentClass
    % ComponentClass Class that defines the parameters for the EOS of Peng
    % Robison
     properties(Access = private)
        physical_props = struct("p_c",46.04, ...
                                "t_c",190.58, ...
                                "af",0.011, ...
                                "mw",16.04, ...
                                "symbol", "methane");
     end
    
    methods
        function obj = ComponentMethane()
            obj = obj.setup(obj.physical_props.p_c,  ...
                obj.physical_props.t_c, obj.physical_props.af, ...
                obj.physical_props.mw, obj.physical_props.symbol);
        end   
    end
end


