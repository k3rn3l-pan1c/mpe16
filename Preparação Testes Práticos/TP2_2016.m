%% Exercício 1
clear; clc; close all;

%% Alíena a)
p = 0.4;
n = 250;
Xn = rand(1, n) < p;

Yn(1, 1) = 0.5 * Xn(:, 1);

for k = 2 : n
    Yn(1, k) = 0.5 * ((Xn(1, k) - Xn(1, k-1)));
end;
 
Yn_temporal = mean(Yn)

%% Alíena b)
clear Yn
numR = 1000;

Xn = rand(numR, n) < p;
Yn(:, 1) = 0.5 * Xn(:, 1);

for k = 2 : n
    Yn(:, k) = 0.5 * ((Xn(:, k) - Xn(:, k-1)));
end;
 
% Para o instante n = 0
Xn_amostral = mean(mean(Yn(:, 1:10), 1))

% A diferença entre o valor teórico e o valor da média amostral não é
% desprezável

%% Alíena c)
% usando o periodograma
numR = 500;
Yf = fft(Yn(1:numR, :), [], 2);

periodograma = sum(abs(Yf).^2) / numR;

% Vetor de frequências
f = (0 : (n-1)) ./ n - 1/2;

plot(f, fftshift(periodograma) / max(periodograma) )
hold on
plot(f,  0.5*p + p^2 + 2*cos(2*pi*f) *(0.5*p^2 -p))
hold off

%% 2
clear;
%% A)

img = imread('airplane.png');
img2 = im2double(img);
R = img2(:, :, 1);
G = img2(:, :, 2);
B = img2(:, :, 3);

varR = var(R(:))
varG = var(G(:))
varB = var(B(:))


%% B)
r = ceil(99 * R) + 1;
b = ceil(99 * B) + 1;

PRB = zeros(100);
for l = 1 : 100
    for c = 1 : 100
        PRB(l, c) = sum(sum( (r == l) & (b == c)));
    end;
end;

figure(1)
surf(PRB)

%% C)
PR = sum(PRB, 2);

PB = sum(PRB, 1);

PRB_independentes = PR * PB;

figure(2)
surf(PRB_independentes)

% Não são independentes
