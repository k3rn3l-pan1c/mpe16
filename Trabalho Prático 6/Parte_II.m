%% Parte II
clear; clc; close all;


%% Exercício 1
% Processo estocástico de soma de n de sinusoides de fase aleatória

% Número de sinusoides
N = 32;

%teta_k são variáveis aleatórias independentes no intervalo [0, 2pi]
teta = rand(N, 1) * 2*pi;

% Frequencia central das sinusoides
f0 = 50;

% Passos na frequência
fd = 10;

% Frequências das sinusoides
Fk = f0 + (1:N)*fd;

%%  Alinea a
% Vetor tempo com 10001 amostras espaçadas de Ts = 0.1 ms
Ts = 0.1e-3;
t = (0:1e4) * Ts;

% Realizações do processo -  usando cálculo matricial
X = sum( cos(2*pi*Fk' * t + teta * ones(1, length(t))) );

%% Alinea b)
% Assumindo que o processo é estacionário e ergódico na média, a média
% temporal de 1 realização é a média temporal do processo
ux = mean(X)

% A função densidade de probabilidade

% Número de bins a usar
Nbins = 100;

fx = hist(X, Nbins) ./ numel(X);

figure(1)
plot(1:Nbins,  fx)
title('Função densidade de probabilidade de X(t)')
ylabel('Probabilidade');
xlabel('Nbins');

% Tende para uma gaussiana a função densidade de probabilidade

%% Alinea c) 
% O processo é ergódico na média se a média temporal para todas as
% realizações coincidir com a média num instante de tempo das numR
% realizações

% Número de realizações do processo
numR = 1000;

% Gerar numR realizações do processo
X = zeros(numR, length(t));
for k = 1 : numR
    % Variável aleatória teta para cada realização do processo X
    teta = rand(N, 1) * 2*pi;
    X(k, :) = sum( cos(2*pi*Fk' * t + teta * ones(1, length(t))) );
end;


% Média amostral
% Selecionar um instante temporal e realizar a média dos valores das
% realizações
% Devido às realizações do processo terem erros, calculamos a média
% amostral em todos os instantes de tempo e de seguida a média dessa
% média amostral
meanAmostral = mean(mean(X(:, 1), 1))

% Média temporal
% Selecionar uma realização e fazer a média de todos os valores temporais
% Devido à média temporal ter erros, calculamos as médias temporais para
% cada realização do processo em seguida para todas as realizações
meanTemporal = mean(mean(X(1, :), 1))

%% Exercício 2
clear;

%% Alínea a)
% Número de realizações
N = 1000;

% Duração máxima do sinal
tmax = 100;

% Sequência de variáveis aleatórias gaussianas independentes e
% identicamente distribuídas com média nula e variância unitária
Wn = randn(N, tmax);

% Condições Iniciais
X(:, 1) = Wn(:, tmax);
X(:, 2) = 1/2 * X(:, 1) + Wn(:, 2);
X(:, 3) = 1/2 * X(:, 2) -1/4 * X(:, 1) + Wn(:, 3);

% Gerar o processo X(n)
for n = 4 : tmax
    X(:, n) = 1/2 * X(:, n-1) - 1/4 * X(:, n-2) - 1/4 * X(:, n-3) + Wn(:, n);
end;

%% Alínea b)
% Usando as realizações da alínea anterior
% A média amostral é obtida fixando um instante de tempo e calculando a
% média em função das várias realizações nesse instante
% Devido às realizações do processo terem erros, calculamos a média
% amostral em todos os instantes de tempo e de seguida a média dessa
% média amostral
meanAmostral = mean(X(:, 1), 1)

%% Alínea c)
% A média temporal é obtida fixando uma realização do processo e calculando
% a média em função dos vários instantes de tempo dessa realização
% Devido à média temporal ter erros, calculamos as médias temporais para
% cada realização do processo em seguida para todas as realizações
meanTemporal = mean(X(1, :))

% Os resultados são diferentes. 
