%% Pedro Martins

clear; clc; close;

nmec = 76374;
k = 5 + rem(nmec^3, 4);
l = 4 + rem(nmec^3, 3);

%% 1
% Gerar k * 2 * nmec lançamentos de um dado, numa matriz com k linhas e
% 2*nmec colunas
dado = randi([1,6], k, 2*nmec);

%% 2
% Obter o dígito menos significativo da soma por colunas dos lançamentos do
% dado (ou seja, somar linha a linha) os valores das faces
X = rem( sum(dado, 1), 10)

%% 3 - Histograma de X, usando um nº de bins identico ao número de valores únicos de X
figure(1)
hist(X, length(unique(X)))
title('Histograma de X');
ylabel('Frequencia absoluta');
xlabel('Valores únicos de X');

%% 4
% Obter o dígito mais significativo da soma por colunas dos lançamentos do
% dado (ou seja, somar linha a linha) os valores das faces
Ysum = sum(dado, 1);
Y = floor(Ysum./10.^(floor(log10(Ysum))));

%% 5 - Histograma de Y, usando um nº de bins identico ao número de valores únicos de Y
figure(2)
hist(Y, length(unique(Y)))
title('Histograma de Y');
ylabel('Frequencia absoluta de Y');
xlabel('Valores únicos de Y');

%% 6 - Média e Variância de X e Y
Xmean = mean(X)
Xvar = var(X)

Ymean = mean(Y)
Yvar = var(Y)

%% 7

% Acontecimento A : o último algarismo da soma por colunas ser 1
A = (X == 1);

% Acontecimento B : o primeiro algarismo da soma por colunas ser 1
B = (Y == 1);

% probabilidade de o primeiro e último algarismo da soma por colunas ser 1
PAB = sum(A & B) / length(A)

% probabilidade de A e B para determinar a probabilidade de A e B supondo
% que os acontecimentos são independentes
PA = sum(A) / length(A)
PB = sum(B) / length(B)
PAB_esperada = PA * PB

%% 8
% Probabilidade de A e B usando a regra de Bayes
PA_B = PAB / PB

% Como a probabilidade de A e B, PA_B, usando a regra de Bayes e a
% probabilidade de A e B, PAB_esperada, usando a suposição de que os
% acontecimentos são independentes, podemos concluir que os acontecimentos
% não são independentes
