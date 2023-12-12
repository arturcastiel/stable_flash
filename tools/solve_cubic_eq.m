function [y] = solve_cubic_eq(c1,c2,c3,c4)
%solve_cubic_eq Specialized function that solves using vectorized code:
%   c1x^3 + c2x^2 + c3x + c4 = 0
% where a, b, c and d are column vectors with n entries.
% outputs: r1, r2 and r3 , roots of the equation above.

% Define a function that takes four arguments
% (the coefficients of a cubic polynomial)
% and returns the roots of the polynomial
rootfun = @(a, b, c, d) roots([a, b, c, d]);
% Use arrayfun to apply rootfun to each set of coefficients
x = arrayfun(rootfun, c1, c2, c3, c4, 'UniformOutput', false);
% Convert cell array to matrix
x = cell2mat(x);
y = transpose(reshape(x,3,[]));
% r1 = y(:,1);
% r2 = y(:,2);
% r3 = y(:,3);
end

