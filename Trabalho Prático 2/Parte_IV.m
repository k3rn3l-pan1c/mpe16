%% Parte IV
clear; clc; close;

% Acontecimentos
%   B = { O número é divisível por 2 }
%   C = { O número é divisível por 3 }
%   D = { O número é divisível por 5 }
% 

%% Exercicio 1
% Determinar a probabilidade de B, C e D
% Determinar as probabilidade condicionais P(B|C) e P(B|D)
% Utilizando os resultados anteriores, estime P(B^C) e P(B^D)


% número de ensaios a considerar na experiencia
L = 1e5;

% Obter os resultados da experiência
[~, B, C, D] = numeros(L);

% Probabilidade dos acontecimentos 
PB = length(B) / L
PC = length(C) / L
PD = length(D) / L

% Probabilidade de B sabendo que ocorreu C. O acontecimento B após C
% consiste em verificar a condição de B no subespaço amostral C. De
% seguida obtem-se os elementos de B que verificam esta condição
B_C = B( rem(C, 2) == 0);
PB_C = length(B_C) / length(C)

% Probabilidade de B sabendo que ocorreu D. O acontecimento B após D
% consiste em verificar a condição de B no subespaço amostral D. De seguida
% obtem-se os elementos de B que verificam esta condição
B_D = B( rem(D, 2) == 0);
PB_D = length(B_D) / length(D)

% Probabilidade de B e C, dada pela fórmula de Bayes
PBC = PB_C * PC

% Probabilidade de B e D, dada pela formula de Bayes
PBD = PB_D * PD

% Formula de Bayes = P(B|C) = P(B^C)/P(C)

%% Exercíco 2
% Resolução Analítica

% Usando a Lei de Laplace, obtem-se 
PB_esperada = 50 / 100
PC_esperada = 33 / 100
PD_esperada = 20 / 100

PB_C_esperada = 16 / 33
PB_D_esperada = 10 / 20

PBC_esperada = PB_C_esperada * PC_esperada
PBD_esperada = PB_D_esperada * PD_esperada

%% Exercicio 3
% Os resultados esperados estão de acordo com os resultados simulados
