function [ g ] = GetGreyScale( x, G )
% Given a position matrix x that has always two columns and n rows, this
% function returns a column vector of the greyscale information at those
% specified points
G = G(:, :, 1);
idx = sub2ind(size(G), x(:, 1)', x(:, 2)');
g = G(idx)';
end

