function [row, column] = GetPosition( z, m)
% Given an m by n image and a number z (integer), this calculates the x and
% y coordinates in that image. Only m, the number of rows, is needed for
% this calculation

% column:
if floor(z/m) == z/m % Basically, this prevents problems at the bottom end of the matrix due to rounding
    column = floor(z/m);
else
    column = floor(z/m) + 1;
end

% row:
row = z - (column - 1) * m;
end

