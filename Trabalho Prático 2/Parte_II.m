%% Parte II
% Considere o espaço de amostragem S = {(x, y): -2 <= x, y <= 2}

clear; clc; close;

%% Exercício 2
% Considere o acontecimento M = {(x, y) são pontos no interior da
% circunferência com centro (0, 0) e raio 2}

% Número de pontos a considerar
N = 1e4;

% Eixo xx e yy do espaço amostral: [-2, 2]x[-2, 2]
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

%% Exercício 3
% Estimar a probabilidade de M

% obter as frequencias absolutas dos i-ésimos elementos soma usando a soma cumulativa
freqM = cumsum(M);

% Probabilidade do acontecimento M em função de N (número de pontos
% simulados)
pM = freqM ./ (1:N);

% Relação entre a probabilidade do acontecimento M e N
figure(2)
plot(1:N, pM);
title('Relação entre a probabilidade do acontecimento M e o número de pontos');
xlabel('Número de pontos');
ylabel('Probabilidade de M');

%% Exercício 4
% Utilize a probabilidade de M para estimar o valor de pi. Mostre a
% dependência da estimativa com o número de pontos usados na simulação

% Raio experimental do acontecimento M. Usar o valor do ponto mais afastado
r = max( max(x(M)), max(y(M)));

% Formula da probabilidade em função de pi com dependência da área de M 
% (área do círculo - pi*r^2)
pi_exp = 16 * pM ./ r.^2;

% Variação do valor de pi em função do número de pontos
figure(3)
plot(1:N, pi_exp)
title('Relação entre o número de pontos e o valor experimental de pi');
xlabel('Número de pontos');
ylabel('Valor experimental de pi');
