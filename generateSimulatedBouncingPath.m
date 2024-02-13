function z = generateSimulatedBouncingPath(iterationNum, roundTimes)
% Esta función genera la ruta de la coordenada Z para el centro del corazón.
if nargin < 2
    roundTimes = 3;
end

if nargin < 1
    iterationNum = 40;
end

radius = 1;
deltaH = 1.5; 
deltaL = -0.3;

rangeY = [-2, 1];

% Gravedad aceleracion

g = 3;

% define el acelerador para z < 0
% k es similar al coeficiente de resorte, pero es más complicado que eso.
% k solo necesita satisfacer una condición aquí, es decir, se detendrá en la ubicación definida por
% deltaL*radio
k = g * deltaH/(-deltaL);

% start point
startZ = deltaH*radius;

% velocidad en z =0
V0 = sqrt(2*startZ*g);

%
% tiempo for z > 0
plusZtime = sqrt(2*deltaH*radius/g);
% time for z < 0
minusZtime = sqrt(-2*deltaL*radius/k);

% periodo
qPeriod = plusZtime + minusZtime;

%  totalTime
qPeriodTime = linspace(0, qPeriod, iterationNum);

% z  cuando z > 0
zPlus = startZ - 0.5 * g * qPeriodTime(qPeriodTime<plusZtime).^2;

% z cuandoz < 0
zMinus = -V0 * (qPeriodTime(qPeriodTime >=plusZtime)-plusZtime) + 0.5 * k* (qPeriodTime(qPeriodTime >=plusZtime)-plusZtime).^2;

z = [zPlus, zMinus, fliplr(zMinus), fliplr(zPlus)];
% 
z = [repmat(z, 1, roundTimes), zPlus];
y = linspace(rangeY(1), rangeY(2), numel(z));
