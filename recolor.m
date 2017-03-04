function [ handles ] = recolor( hObject, handles )
%This function does the main job: Color back in the image

% The information about the images is stored in the two handles
% handles.images and handles.grey

%% Recieve the necessary user inputs

% The information about which basis function to use
radB = handles.radB;

% Figure out which solver to use
solver = handles.solver;

% Recieve the greyscale info
G = handles.grey;
S = handles.someColor;

% Get the pixels that do have color information
colorPixels = handles.colorPixels;

% Getting the parameters
delta = str2double(get(handles.delta, 'String'));
p = str2double(get(handles.pedit, 'String'));
sigma1 = str2double(get(handles.sigma1, 'String'));
sigma2 = str2double(get(handles.sigma2, 'String'));

%% User Message

disp('thinking...');

%% Exctract Information about the data

% Get the image size
[m, n, ~] = size(S);

% Get the number of pixels that are given
nPixels = length(colorPixels);

%% Define the Kernel

% Make decision on basis function
if radB == 0 %Gauss
    phi = @(r) exp(-r.^2);
else % Compact support
    phi = @(r) max(1-r, 0).^4.*(4*r+1);
end

% We will need to define a function GetGreyScale that returns the grey
% scale value, given the position of a pixel

% Define the Kernel, x and y are position vectors
%   K = @(x, y) phi(norm(x-y, 2)/sigma1).*phi(abs(double(GetGreyScale(x,G))-double(GetGreyScale(y, G))).^p/sigma2);
%  
  
 % We need a row-wise L2 norm
 myNorm = @(A) sqrt(sum(abs(A).^2, 2));
 
 % Define the Kernel, x and y are position vectors
 K = @(x, y) phi(myNorm(x-y)'/sigma1)'.*...
     phi( (abs(double(GetGreyScale(x,G))-double(GetGreyScale(y, G))).^p/sigma2)' )';

%% Construct the matrix KD

% I need to get my pixel coordinates right. There is a function for that
% called GetPosition.

% Create a position vector that contains the color pixel information
[row, column] = ind2sub([m, n], colorPixels);
x = [row, column];

%Start a timer
tic

% New:
% Create the Matrix KD which will be symmetric
KD = zeros(nPixels, nPixels);
for h = 1:nPixels
   KD(1:h, h) = K(x(1:h, :), x(h, :)); 
end

% % Old:
% % Create the Matrix KD which will be symmetric
% KD = zeros(nPixels, nPixels);
% for i = 1:nPixels
%     for j = i:nPixels
%         KD(i, j) = K(x(i, :), x(j, :)); % Fairly sparse
%     end
% end

% Fill ine the other half of the elements
KD = KD + KD' - eye(nPixels, nPixels);
 
% Stop the timer, save the time
time1 = toc;

%% Construct the linear algebra problem

% Construct the LHS
A = KD + delta*nPixels*eye(nPixels);

% Create a matrix to store the coefficients:
a = zeros(nPixels, 3);

tic
% Loop over all three colors:
for s = 1:3
    
    %Retrieve color information
    b = double(GetColorInfo(x, s, S));
    
    %Solve the matrix problem
    if solver == 0 % backslash
        y = A\b;
    else % GMRES
        x0 = zeros(nPixels, 1);
        [iter, resvec, y] = GMRES (A, b, x0);
    end
    
    % Store coefficients for that color
    a(:, s) = y;
end
time2 = toc;

%% Produce the actual picture

% We need to construct now a very big matrix KOmega
KOmega = zeros(m*n, nPixels);

% Create a position vector for all pixels:
u = (1:m*n)';
[row1, column1] = ind2sub([m, n], u);
allPixels = [row1, column1];

% Fill the matrix KOmega
tic
for h = 1:nPixels
   KOmega(:, h) = K(allPixels, x(h, :)); 
end
time3 = toc;

% Create a long vector to store the color information
F = zeros(m*n, 3);

% Fill the vector. Columns represent red, green and blue
for s = 1:3
    F(:, s) = KOmega*a(:, s);
end

% Create three layers of color
L1 = reshape(F(:, 1), [m, n]);
L2 = reshape(F(:, 2), [m, n]);
L3 = reshape(F(:, 3), [m, n]);

% Put together the recolored image
R = L1;
R(:, :, 2) = L2;
R(:, :, 3) = L3;

% Make sure to use the right data type:
R = uint8(R);

%% Display the image

% Save the new image in a handle
handles.recolored = R;

% Chose axes for plotting
axes(handles.axes4); 

% Plot image
imshow(R);

%% Give out some Information about this run

% In case of GMRES, give some information about the convergence
if solver == 1
    figure;
    semilogy(resvec), xlabel('k'), ylabel('log(r_k)'), title('Convergence of GMRES');
end

message = sprintf('It took me %1.2f s to construct the matrix KD, %1.2f s to solve the linear system and %1.2f s to construct the matric KOmega. Total Computation time needed: %1.2f s \n',...
    time1, time2, time3,time1 + time2 + time3);

set(handles.results, 'String', message);









    




    




end

