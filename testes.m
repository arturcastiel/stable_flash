
%% Previous on how we are going to create the new Stability and Flash

Components_list = [ComponentMethane, ComponentCarbonDioxide, ComponentWater];

X_frac = [ 1 0 0; ...
           0 1 0; ...
           0 0 1; ...
           0.2 0.4 0.4];
       
Phase1 = PhaseClass(Components_list, X_frac);
