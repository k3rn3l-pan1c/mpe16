%% 10 de Novembro de 2014
clear; close; clc;

nmec = 76374;
k = 3 + rem(nmec, 3);
I = 3 + rem(nmec, 5);

%% 1
% Em matlab crie uma matriz com k linhas e 100000 colunas em que cada
% elemento da matriz é um dígito da base 10 (0 a 9) uniformente
% distribuídos
% Sugestão: Use a função randint

% % randint é uma função do matlab obsoleta
% rnd_obsolte = randint(k, 1e5, [0, 9]);

% usar randi
rnd = randi([0, 9], k, 1e5);

%% 2
% Obtenha o vetor X em que cada elemento é o último dígito da multiplicação
% elemento a elemento das primeiras k-1 linhas, ou seja, o último dígito de
% uma operação que envolve k-1 multiplicações decimais
% Sugestão: Determinação do último dígito é simplesmente uma operação resto
% módulo 10

% Vetor X em que cada indice é o último dígito da multiplicação elemento
% a elemento das k-1 linhas da matriz de valores aleatórios (ou seja,
% multiplicação dos elementos em cada coluna)
% Como só queremos as k-1 linhas, indexamos a matriz de dados aleatórios e
% calculamos o seu produto coluna a coluna precorrendo as k-1 linhas
% O seu último dígito, como estamos em base decimal, é dado pelo resto da
% divisão por 10
X = rem( prod(rnd(1:k-1, :), 1), 10);

%% 3
% Esboce na sua folha de teste os histogramas de X usando tantos bins
% quantos valores diferentes existentes nessa variável

figure(1)
H_X = hist(X, unique(X));
bar(unique(X), H_X);
title('Histograma de X');
ylabel('Frequência absoluta');
xlabel('Elementos de X');

%% 4
% Obtenha o vetor Y em que cada elemento é o último digito da multiplicação
% elemento a elemento das k linhas, ou seja, o último dígito que envolve k
% multiplicações decimais

% Vetor Y em que cada indice é o último dígito da multiplicação elemento
% a elemento das k linhas da matriz de valores aleatórios (ou seja,
% multiplicação dos elementos em cada coluna)
% O seu último dígito, como estamos em base decimal, é dado pelo resto da
% divisão por 10
Y = rem( prod(rnd, 1), 10);

%% 5
% Esboce na sua folha de teste os histogramas de Y usando tantos bins
% quantos valores diferentes existentes nessa variável

figure(2)
H_Y = hist(Y, unique(Y));
bar(unique(Y), H_Y);
title('Histograma de Y');
ylabel('Frequência absoluta');
xlabel('Elementos de Y');

%% 6
% Determine a entropia de X e de Y
X_entropy = entropy(X)
Y_entropy = entropy(Y)

%% 7
% Considere os acontecimentos A = {X = I} e B = {Y = I}. Determine usando
% os resultados anteriores a probabilidade de A^B. Os acontecimentos A e B
% são independentes?
A = (X == I);
B = (Y == I);

% Probabilidade usando os resultados dos histograma. Lembrar que no indice
% i do histograma encontra-se a frequencia absoluta de i-1 (neste caso)
PA = H_X(I+1) / length(X)
PB = H_Y(I+1) / length(Y)

% Probabilidade de ocorrer A e B. A & B é um vetor lógico que resulta do
% AND elemento a elemento dos vetores lógicos dos acontecimentos A e B
PAB = sum(A & B) / length(X)

% Se os acontecimentos forem independentes, a sua probabilidade deve ser
% dada pela soma das probabilidades individuais
PAB_ind = PA + PB

% Não são independentes, poise PAB_ind ~= PAB
% A independência podia ser verificada pela entropia...

%% 8
% Com base nos resultados anteriores determine a probabilidade condicional
% P(B|A)
PB_A = PAB / PA
