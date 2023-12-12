function [ref] = iscomplexVEC(vec)
%iscomplexVEC Check element wise the vector vec to test if it contains
%   a complex number.
ref = imag(vec) ~= 0;
end

