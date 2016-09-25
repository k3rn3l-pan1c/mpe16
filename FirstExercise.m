%% Simular o lançamento de uma moeda
clear, clc, close

coin = {'Tails' ; 'Head' };

% Número de moedas a lançar
Nmoedas = 1;

% Sequência aleatória de elementos
rnd_1 = rand(1, Nmoedas);

%% A) Com rand e round
% Round to nearest even
idx_a = round(rnd_1);

%% B) Com rand e floor
% Round towards minus infinite -> corrigir somando 0.5
idx_b = floor(rnd_1+0.5);

%% C) Com rand e ceil
% Round towards plus infinite -> corrigir subtraindo 0.5
idx_c = ceil(rnd_1-0.5);

%% Check the methods
correct = idx_a == idx_b && idx_b == idx_c;
if(~correct)
    error('Os métodos round, floor e ceil não produzem os mesmos resultados');
end;

%% Contar o número de caras em N lançamentos
% Número de moedas
Nmoedas = 10;

% New random set
rnd_2 = rand(1, Nmoedas);

% Número de caras -> caras é o número 1 nos dados aleatórios
Nheads = sum(round(rnd_2));

fprintf('O número de caras em %d lançamentos foi: %d\n', Nmoedas, Nheads)
