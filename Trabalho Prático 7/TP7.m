%% Exercício 1
clear; clc; close all;

% Load data
load('digitos.mat');

% Dimensões da imagem 
l=100;
c=64;

% Célula para guardar os números
D = cell(size(X, 1), 1);

% Para cada linha, obter o dígito
for k = 1 : size(X, 1)
    D{k} = X(k, :);
    
    figure(k)
    imagesc(reshape(D{k}, l, c));
    colormap(gray)
end;
    
%% Exercício 2
% O dígito escolhido é o 6
idx = 6 + 1;

%% Alínea a)
m = mean(D{idx})

%% Alínea b)
v = var(D{idx})

%% Alínea c)
N = randn(size(D{idx})) * sqrt(8*v);

%% Alíena d)
Y = D{idx} + N;

my = mean(Y)

vy = var(Y)

figure(11)
imagesc(reshape(Y, l, c))
colormap(gray)
title('Dígito com ruído');

%% Alíena e)
% Covariância entre Y e o dígito selecionado
C_YD = cov(Y, D{idx});

% Coeficiente de correlação entre Y e o dígito selecionado
CC_YD = C_YD(1, 2) / sqrt(C_YD(1, 1) * C_YD(2, 2))


% Covariância entre Y e o ruído N
C_YN = cov(Y, N);

% Coeficiente de correlação entre Y e o dígito selecionado
CC_YN = C_YN(1, 2) / sqrt(C_YN(1, 1) * C_YN(2, 2))


% Covariância entre o dígito selecionado e o ruído N
C_DN = cov(D{idx}, N);

% Coeficiente de correlação entre Y e o dígito selecionado
CC_DN = C_DN(1, 2) / sqrt(C_DN(1, 1) * C_DN(2, 2))


%% Alíena f)



%% Exercício 3

%% Alínea a)

% número de realizações do ruído 
n = 10;

% n realizações de ruído branco gaussiano
N = randn(10, length(D{idx})) * sqrt(8*v);

% repetir o dígito 10 vezes
digit = repmat(D{idx}, 10, 1);

% Transmitir 10 vezes o sinal
Y = digit + N;

% Filtragem por média na receção
Z = mean(Y, 1);


%% Alínea b)
my = mean(Y, 2)

for k = 1: 10
    figure(11 + k)
    imagesc(reshape(Y(k, :), l, c))
    colormap(gray)
    title(['Dígito com ruído' sprintf('\n') num2str(k) 'º Realização do processo Y' ])
end;

figure(22)
imagesc(reshape(Z, l, c))
colormap(gray)
title('Média dos sinais de ruído');

mz = mean(Z)

%% Alínea c)
vy = var(Y, [], 2)

vz = var(Z)

%% Alínea d)


%% Alínea e)

% número de realizações do ruído
n = [1 2 5 10 20 50 100];

% Dígito recebido filtrado
Z = zeros(length(n), length(D{idx}));

% SNR's
SNR_withNoise = zeros(1, length(n));
SNR_withoutNoise = zeros(1, length(n));

for k = 1 : length(n)
    % n realizações de ruído branco gaussiano
    N = randn(n(k), length(D{idx})) * sqrt(8*v);

    % repetir o dígito n vezes
    digit = repmat(D{idx}, n(k), 1);

    % Transmitir n vezes o sinal
    Y = digit + N;

    % Filtragem por média na receção
    Z(k, :) = mean(Y, 1);    

       
    figure(22 + k)
    imagesc(reshape(Z(k, :), l, c))
    colormap(gray)
    title(['Dígito com ruído' sprintf('\n') 'Enviado ' num2str(n(k)) ' vezes' ])

    
    % SNR
    SNR_withNoise(k) = 10*log10(sum(sum(abs(digit)).^2)./sum(sum(abs(N).^2)));
    SNR_withoutNoise(k) = 10*log10(sum(sum(abs(Z(k, :))).^2)./sum(sum(abs(D{idx} - Z(k, :)).^2)));
end;

T = table(SNR_withNoise')
T = table(SNR_withoutNoise')



%% Exercício 4

%% Alínea a)
% Se considerarmos só os valores dos pixeis, sim pode, porque os valores
% dos dígitos apenas tomam o valor 0 ou 1. No entanto, o valor dos pixeis
% é fortemente correlacionado, mas uma variável de Bernoulli não

%% Alínea b)
% Considerando o branco como o sucesso do modelo de Bernoulli
p = sum(D{idx}) / numel(D{idx})

%% Alínea c)
% P valor esperado de p é 
Ep = mean(D{idx})

% Variância
Varp = p * (1 - p)

%% Alíena d)
% Função densidade de probabilidade
fdp = hist(D{idx}, unique(D{idx})) / numel(D{idx})

% Entropia
entropia = -sum(fdp .* log2(fdp))

%% Alíena e)
% Número de bits mínimos para enviar os 10 dígitos
numbits = 10 * entropia

%% Alínea f)
d = D{idx};

whos d


%% Exercício 5

%% Alíena a
% É necessário concatenar um zero para manter a dimensão correta do vetor
% (o diff diminui a dimensão em 1 unidade)
digitDiff = diff([0 D{idx}]); 

figure
imagesc(reshape(digitDiff, l, c))
colormap(gray)
title('Dígito com codificação diferencial');

%% Alínea b)
% Sim é. Usando um filtro IIR com parametros:
a = [1 -1];
b = 1;

% Filtrar o dígito com o filtro IIR
digitFilter = filter(b, a, digitDiff);

% Imagem
figure
imagesc(reshape(digitFilter, l, c))
colormap(gray)
title('Dígito recuperado');

%% Alínea C
fdpDiff = hist(digitDiff, unique(digitDiff)) ./ numel(digitDiff)
entropiaDiff = - sum(fdpDiff .* log2(fdpDiff))

%% Alíena d)
% Taxa de compressão: número de valores que ocupa a matriz da imagem *
% número de bits necessários / entropia
numel(D{idx}) * 1 / entropiaDiff

%% Alíena e)
% Usando uma codificação diferencial da imagem podemos reduzir imenso o
% espaço ocupado pelos dígitos
