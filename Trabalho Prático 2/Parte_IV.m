%% Parte IV
clear; clc; close;

% Acontecimentos
%   B = { O número é divisível por 2 }
%   C = { O número é divisível por 3 }
%   D = { O número é divisível por 5 }
% 

%% Exercicio 1
% número de ensaios a considerar na experiencia
L = 1e5;

% Obter os resulatdos da experiência
[~, B, C, D] = numeros(L);

% Probabilidade dos acontecimentos 
PB = length(B) / L
PC = length(C) / L
PD = length(D) / L

% Probabilidade de B sabendo que ocorreu C
B_C = B( rem(C, 2) == 0);
PB_C = length(B_C) / length(C)

% Probabilidade de B sabendo que ocorreu D
B_D = B( rem(D, 2) == 0);
PB_D = length(B_D) / length(D)

% Probabilidade de B e C
PBC = PB_C * PC

% Probabilidade de B e D
PBD = PB_D * PD

%% Exercíco 2
% Usando a Lei de Laplace, obtem-se 
PB_esperada = 50 / 100
PC_esperada = 33 / 100
PD_esperada = 20 / 100

PB_C_esperada = 16 / 33
PB_D_esperada = 10 / 20

PBC = PB_C_esperada * PC
PBD = PB_D_esperada * PD

%% Exercicio 3
% Os resultados esperados estão de acordo com os resultados simulados
