addpath(genpath(pwd));
%% Previous on how we are going to create the new Stability and Flash
Components_list = [ComponentMethane, ComponentCarbonDioxide, ComponentWater];

% X_frac = [ 0.4 0.4 0.2; ...
%            0.3 0.3 0.4; ...
%            0.2 0.2 0.6; ...
%            0.1 0.1 0.8];

X_frac = [ 0.5 0.5 0.0; ...
           0.4 0.6 0.0; ...
           0.3 0.7 0.0; ...
           0.2 0.8 0.0];
       
Phase1 = PhaseClass(Components_list, X_frac);
