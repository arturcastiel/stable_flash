
a = [1; 2 ; 3; 4; [1:200]'];
b = a + 1;
c = a - 2;
d = a.*a;


n = length(a);

% Define a function that takes four arguments 
% (the coefficients of a cubic polynomial)
% and returns the roots of the polynomial
rootfun = @(a, b, c, d) roots([a, b, c, d]);

% Use arrayfun to apply rootfun to each set of coefficients
x = arrayfun(rootfun, a, b, c, d, 'UniformOutput', false);

% Convert cell array to matrix
x = cell2mat(x);
y = transpose(reshape(x,3,n));

