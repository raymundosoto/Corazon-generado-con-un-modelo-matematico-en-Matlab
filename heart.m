function [cordX, cordY, cordZ] = heart(sizeTheta, sizeFai)

% La función HEART genera las coordenadas x, y, z para la forma del corazón.
% Su uso es bastante similar a la función ESFERA en Matlab, pero no dibuja nada.
% el tamaño predeterminado de las coordenadas x,y,z es [30, 160]
% el parámetro de sizeFai es en realidad una cuarta parte del rango total de Fai.
% la ecuación matemática utilizada aquí se encuentra en la página web
% http://mathworld.wolfram.com/HeartSurface.html


if nargin ==0
    sizeTheta = 30;
    sizeFai = 40;
elseif nargin < 2
    error('heart:NotEnoughArugments', 'Please give at least two input arugments');
end;

theta = linspace(0, pi, sizeTheta)';
nudge = 0.0001; % used to avoid the operlapping
fai = linspace(0 + nudge, pi/2 - nudge, round(sizeFai/4));

a = 9/4;
b = 9/80;
A = 1+(a-1)*(sin(theta).^2) * (sin(fai).^2);
B = (sin(theta).^2.*cos(theta).^3) * (1 + (b-1)*(sin(fai).^2));
rou = zeros(size(A));

for iLoop = 1:numel(A);
    curA = A(iLoop);
    curB = B(iLoop);
    % this is the polar coordinates version of the sextic equation found on
    % http://mathworld.wolfram.com/HeartSurface.html
    polyFactors = [curA^3, -curB, -3*curA^2, 0, 3*curA, 0, -1];
    solutions = roots(polyFactors);    
    realRou = real(solutions(abs(imag(solutions))< 1e-9));
    rou(iLoop) = realRou(realRou>0);    
end

% x,y,z for the quater of whole heart
x = rou .* (sin(theta) * cos(fai));
y = rou .* (sin(theta) * sin(fai));
z = rou .* (cos(theta) * ones(size(fai)));

% x,y,z for the whole heart
cordX = [x, -fliplr(x) , -x, fliplr(x)];
cordY = [y, fliplr(y) , -y, -fliplr(y)];
cordZ = [z, fliplr(z), z, fliplr(z)];