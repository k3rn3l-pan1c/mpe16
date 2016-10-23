%% Parte I
% Dois alunos do MIEET combinam-se encontrar na praça do peixe ás 23h.
% Ambos podem chegar com um atraso máximo de 1h. Logo o espaço de
% amostragem para os tempos de atraso de ambos é
% S = {(x, y) : 0 <= x, y <= 1}

clear; clc; close;

%% Exercício 1
% Considere o acontecimento M = {(x, y) : |y - x| < 0.25}. Explique o seu
% significado

% Número de atrasos possíveis a simular
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

% O aconctecimento M consiste no tempo máximo de espera entre a chegada do
% primeiro aluno e do segundo aluno ser inferior a 15 minutos (1/4 de hora)

%% Exercício 3
% Estime a probabilidade de M

% A probabilidade do evento M ocorrer corresponde ao número de ocorrências
% de M (casos favoráveis) a dividir por todos os atrasos simulados 
% (casos possíveis) - Método de Monte Carlo
pM = sum(M) / N

%% Exercício 4
% Mostre a dependência da estimativa da probabilidade de M com o número de
% pontos usados na simulação
N = 1e6;

% Atraso do aluno x e do aluno y
x = rand(1, N);
y = rand(1, N);
    
% Acontecimento M
M = abs(y - x) < 0.25;

% A probabilidade do evento M ocorrer corresponde ao número de ocorrências
% de M (casos favoráveis) a dividir por todos os atrasos simulados 
% (casos possíveis) - Método de Monte Carlo
% A soma cumulativa permite obter no elemento i a soma dos elementos 1:i,
% ou seja, permite-nos obter o valor como se tivessemos efetuado uma
% simulação para cada um dos valores de i individualemnte
freqAbs = cumsum(M);
pM = freqAbs ./ (1:N);

figure(2)
plot(log10(1:N), pM);
title('Variação da probabilidade em função do número de pontos');
xlabel('Número de pontos (log)');
ylabel('Probabilidade');

