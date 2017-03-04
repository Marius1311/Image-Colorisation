function [ color ] = GetColorInfo( x, s, S )
% This function returns fraction of color s at positions x in image S
B = S(:, :, s);
idx = sub2ind(size(B), x(:, 1), x(:, 2));
color = B(idx);
end

