classdef ComponentClass <  matlab.mixin.Heterogeneous & handle
    % ComponentClass Class that defines the parameters for the EOS of Peng
    % Robison
    
    properties
        % Critical Pressure (bar)
        P_critical
        % Critical Temperature (K)
        T_critical
        % Acentric factor
        W_ac
        % Molecular Weight (g/mol)
        Mw
        %% Parameters for Peng-Robison EOS
        ak
        bk    
        %% constants
        R = 83.1447 % bar cm^3 mol^(-1) K^(-1);
        %T = 90 + 273.15 % Isothermal Condition
        symbol
%         T = [300; 310; 320; 330]
%         P = [100; 150; 200; 250]
        
        T = 300*ones(4, 1)
        P = 100*ones(4, 1)
    end
    properties (Dependent)
        %% 

    end

    methods
        function obj = setup(obj, P_critical, T_critical, W_ac, Mw, ...
                                                    varargin)
            if ~isempty(varargin)
                obj.symbol = varargin{1};
            end
            obj.P_critical = P_critical;
            obj.T_critical = T_critical;
            obj.W_ac = W_ac;
            obj.Mw = Mw;
            [obj.ak,obj.bk] = compute_component_ak_bk(obj);
        end
        
    end
    methods (Access = protected)
        function kk = compute_component_kk(obj)
            kk1 = 0.37464 + 1.54226 * obj.W_ac - 0.26992 * obj.W_ac.^2;
            kk2 = 0.379642 + 1.48503 * obj.W_ac - ...
                        0.164423 * obj.W_ac.^2 + 0.016666 * obj.W_ac.^3;           
            ref = obj.W_ac <= 0.49;
            kk = kk1.*ref + kk2.*(~ref);
        end
        function [ak,bk] = compute_component_ak_bk(obj)
            %% coeficients for pure components    
            kk = obj.compute_component_kk();
            alpha_k = (1 + kk.*(1- (obj.T/obj.T_critical).^.5)).^2;            
            ak = (0.45724 * obj.R^2 * obj.T_critical.^2 .* alpha_k) ...
                                            / obj.P_critical;
            bk = 0.07780 * obj.R * obj.T_critical / obj.P_critical;
        end
    end
end
