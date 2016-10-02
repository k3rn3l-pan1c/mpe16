%% Parte II
clear; clc; close;

%%  2
% Número de pontos a considerar
N = 1e4;

% Eixo xx e yy do espaço amostral
x = rand(1, N) * 4 - 2;
y = rand(1, N) * 4 - 2;

% Acontecimento M
M = (y.^2 + x.^2 <= 2.^2);

% Mostrar no espaço amostral o acontecimento M
figure(1)
plot(x, y, '.')
hold on
plot(x(M), y(M), '.');
hold off
title('Espaço Amostral e Acontecimento M');
xlabel('Eixo X');
ylabel('Eixo Y');
legend('Espaço Amostral', 'Acontecimento M');

%% 3
% obter as frequencias usando a soma cumulativa
freqM = cumsum(M);

% Probabilidade em função de N
pM = freqM ./ (1:N);

% Relação entre a probabilidade do acontecimento M e N
figure(2)
plot(1:N, pM);
title('Relação entre a probabilidade do acontecimento M e o número de pontos');
xlabel('Número de pontos');
ylabel('Probabilidade de M');

%% 4
% Raio experimental do acontecimento M
r = max( max(x(M)), max(y(M)));

% Formula da probabilidade em função da área de M e pi
pi_exp = 16 * pM ./ r.^2;

% Variação do valor de pi em função do número de pontos
figure(3)
plot(1:N, pi_exp)
title('Relação entre o número de pontos e o valor experimental de pi');
xlabel('Número de pontos');
ylabel('Valor experimental de pi');
