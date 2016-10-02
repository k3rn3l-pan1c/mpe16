%% Parte I

clear; clc; close;

%% 1, 3
% Número de atrasos possíveis
N = 1e4;

% Atraso do aluno x e do aluno y
x = rand(1, N);
y = rand(1, N);

% Combinação dos atrasos possíveis
figure(1)
plot(x, y, '.');

% Acontecimento M
M = abs(y - x) < 0.25;

% Graficamente
hold on
plot(x(M), y(M), '.');
hold off

title('Atraso a chegar à praça do peixe');
xlabel('Aluno 1');
ylabel('Aluno 2');
legend('Atrasos possíveis', 'Acontecimento M');

%% 3
% A probabilidade do evento M ocorrer corresponde ao número de ocorrências
% de M (casos favoráveis) a dividir por todos os atrasos simulados 
% (casos possíveis) - Método de Monte Carlo
pM = sum(M) / N;

%% 4
N = 1e6;

% Atraso do aluno x e do aluno y
x = rand(1, N);
y = rand(1, N);
    
% Acontecimento M
M = abs(y - x) < 0.25;

freqCumulativa = cumsum(M);

% A probabilidade do evento M ocorrer corresponde ao número de ocorrências
% de M (casos favoráveis) a dividir por todos os atrasos simulados 
% (casos possíveis) - Método de Monte Carlo
% A soma cumulativa permite obter no elemento i a soma dos elementos 1:i,
% ou seja, permite-nos obter o valor como se tivessemos efetuado uma
% simulação para cada um dos valores de i individualemnte
pM = freqCumulativa ./ (1:N);

figure(2)
plot(log10(1:N), pM);
title('Variação da probabilidade em função do número de pontos');
xlabel('Número de pontos (log)');
ylabel('Probabilidade');

