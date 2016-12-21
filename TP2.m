%% TP2
clear; clc; close all;

nmec = 76374;

a = 1 + rem (nmec, 3);

%% Ex1

n = 100000;

p = 1/2;

In = rand(1, n) < p;

Xn = a * (2 * In - 1);

stem(Xn(1:100))

%% Ex2 
numRX = 1000;


In = rand(numRX, n) < p;

Xn = a * (2 * In - 1);
 
Yn = sum(Xn, 1);

stem(Yn(1:100))

%% Ex3
In = rand(1, n) < p;

Xn = a * (2 * In - 1);

%% Alinea a)
mean(Xn)
var(Xn)

%% Alinea b)
clc
numRX = 1000;


In = rand(numRX, n) < p;

Xn = a * (2 * In - 1);

idxEnd = [1 5 10];
for k = 1: length(idxEnd)
    meanT = mean(mean(Xn(1:idxEnd(k), :)));

    meanR = mean(mean(Xn(:, 1:idxEnd(k))));
    
    deltaMean = abs(meanT - meanR);
    
    fprintf('%f %f %f\n', meanT, meanR, deltaMean)
end;

%% Ex4

mean(Yn)

var(Yn)

%% Ex5

%%a
In = rand(1, n) < p;

Xn = a * (2 * In - 1);

N = randn(size(Xn)) * sqrt(a);

R = Xn + N;

%% b
XRn = a*(2 * (R >= 0) - 1 );

ser = sum( Xn ~= XRn) / numel(XRn)
    

%% Ex6
N = 3
In3 = rand(1, n) < p;

Xn3 = a * (2 * In3 - 1);

N3 = randn(3, n) .* sqrt(a);

R3 = mean(repmat(Xn3, 3, 1) + N3, 1);

XRn3 = a*(2 * (R3 >= 0) - 1 );

ser3 = sum( Xn3 ~= XRn3) / numel(XRn3)
  
