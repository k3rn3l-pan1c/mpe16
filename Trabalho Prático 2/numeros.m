function [A, B, C, D] = numeros(L)
% Simula L ensaios de uma experiencia que consiste em escolher
% aleatoriamente um numero em S = {1, 2, 3, ..., 100}
%
% As variáveis B, C e D contém os valores dos acontecimentos:
%   B = { O número é divisível por 2 }
%   C = { O número é divisível por 3 }
%   D = { O número é divisível por 5 }
% 
%
% USAGE:
%   [A, B, C, D] = numeros(L)
%

% gera L números no intervalo [1, 100]
A = ceil(100 * rand(1, L));

% B -> valores pares da matriz A
B = A( rem(A, 2) == 0);

% C -> valores da matriz A múltiplos de 3
C = A( rem(A, 3) == 0);

% D -> valores da matriz A múltiplos de 5
D = A( rem(A, 5) == 0);
