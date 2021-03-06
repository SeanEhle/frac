% frac.m
% produces a mandelbrot fractal
% requires the file MAP.txt to provide a colormap for output

clear;clc

Cmin = -2 - 1.5*1i;  % The lowest value of C (default -2 - 1.5*1i)
Cmax =  1 + 1.5*1i;  % The highest value of C (default 1 + 1.5*1i)
Hpxl = 400;          % The number of steps in the x-dir
iter = 48;           % The max number of iterations

Vpxl = round(Hpxl*abs(imag(Cmax - Cmin)/real(Cmax - Cmin))); % find implicit y-dir steps
Z = zeros(Vpxl,Hpxl); % Initialize the Z-values
REline = linspace(real(Cmin),real(Cmax),Hpxl); % create the real number line
IMline = linspace(imag(Cmin),imag(Cmax),Vpxl); % create the imaginary number line
[Cre,Cim] = meshgrid(REline,IMline); % create the meshgrid for the pixel plane
C = Cre + Cim*1i; % Combine the previous line's outputs to create the complex plane
N = zeros(Vpxl,Hpxl); % Initialize the matrix that counts interations
for k = 1:iter
  mask = abs(Z)<2; % Ignore values that have already proved divergent
  N(mask)= N(mask) + 1; % count the iteration
  Z(mask) = Z(mask).^2 + C(mask); % perform the Mandlebrot iteration
%   Z(mask) = (abs(real(Z(mask))) + abs(imag(Z(mask)))*1i).^2 + C(mask); % perform the Burning Ship iteration
end
colormap(load('MAP.txt'));
M = mod(N-1,48); % cycle through a limited number of color values
%M(mask) = 0; % reset the non-divergent values to the base color
imagesc(REline,IMline,M) % create the image