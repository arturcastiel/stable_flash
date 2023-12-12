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
