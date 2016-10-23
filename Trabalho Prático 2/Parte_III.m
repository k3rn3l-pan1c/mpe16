%% Parte III
% Um amigo seu quer fazer as seguintes apostas:
% Aposta A - Em 4 lançamentos consecutivos de um dado não viciado ocorre
% pelo menos um 6
% Aposta B - Em 24 lançamentos consecutivos de dois dados não vicidados
% ocorre pelo menos um duplo 6
% Qual delas é a mais provável?

clear; clc; close;
%% Exercício 1
% número de repetições da experiência a considerar
N = 1e5;

% Experiencia A
A = ceil( 6 * rand(N, 4));

% Experiencia B - primeiro dado, B1, e segundo dado, B2.
B1 = ceil( 6 * rand(N, 24));
B2 = ceil( 6 * rand(N, 24));

%% Exercício 2 
% Valores de probabilidade esperados (calculados analiticamente)
PA_esperada = 0.51
PB_esperada = 0.49

%% Exercício 3
% Compare o resultado teórico com o resultado que obteve através da
% simulação

% Casos favoraveis no acontecimento A: A == 6 resulta numa matrix logica,
% com o valor '0' se nao existir um 6 nesse indice e '1' se existir um 6.
% Percorrendo as linhas e somando as colunas, sum(A == 6, 2), obtem-se o
% numero de ocorrencias de 6 nos 4 lançamentos consecutivos. Fazendo a
% comparação do resultado anterior > 0, verifica-se se nos 4 lançamentos
% existiu pelo menos um 6. Efetuando a soma pela coluna, linha a linha,
% obtemos o número de vezes que ocorreu pelo menos um 6 nos 4 lançamentos
% consecutivos para as N repetições.
% Os casos favoráveis são o número de repetições
PA = sum(sum(A == 6, 2) > 0) / N

% Casos favoráveis ao acontecimento B. B1 == 6 resulta numa matrix lógica, 
% com o valor '0' se nao existir um 6 nesse indice e '1' se existir um 6.
% O mesmo é válido para B2, A operação ((B1 == 6) & (B2 == 6)) gera uma
% matrix lógica onde '1' corresponde a ter ocorrido um duplo 6 naquele
% lançamento dos dois dados. Percorrendo as linhas e somando as colunas,
% sum( ((B1 == 6) & (B2 == 6)), 2), obtem-se o número de ocorrencias de
% duplos 6 nos 24 lançamentos consecutivos. Fazendo a comparação do
% resultado anterior > 0, verifica-se se nos 24 lançamentos existiu pelo
% menos um duplo 6. Efetuando a soma pela coluna, linha a linha, obtemos o
% número de vezes que ocorreu pelo menos um duplo 6 nos 24 lançamentos 
% consecutivos para as N repetições.
% Os casos favoráveis são o número de repetições
PB = sum( sum( ((B1 == 6) & (B2 == 6)), 2) > 0) / N

% Verificamos que o acontecimento A é cerca de 2% mais provável de ocorrer
