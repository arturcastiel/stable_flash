

%% Previous on how we are going to create the new Stability and Flash

% CO2
comp_z1 = ComponentClass(73.773, 304.1282, 0.22394, 44.010);
% CH4
comp_z2 = ComponentClass(45.992, 190.564, 0.01142, 16.043);
% H2O
comp_z3 = ComponentClass(220.640, 647.096, 0.3443, 18.0152);


Components_list = [comp_z1, comp_z2, comp_z3];

X_frac = [ 1 0 0; ...
           0 1 0; ...
           0 0 1; ...
           0.2 0.4 0.4];
       
Phase1 = PhaseClass(Components_list, X_frac);
