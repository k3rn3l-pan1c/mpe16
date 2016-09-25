%% Trabalho Prático 1 - parte I
clear; close; clc;

%% Exercício 1

% numero de lançamentos
n = 100;      

% converter os numeros aleatorios gerados por rand no intervalo [0 1] para
% o intervalo [1 6] usando arredondamento para cima
X = ceil(6*rand(1, n));

% Minimo e maximos do vetor de lançamentos
minX = min(X);
maxX = max(X);

% Intervalo de [0.5 6.5] com passos de 1 - representa as edges a considerar
% no histograma - limites entre as barras para considerar a contagem de
% ocorrencias
e = [minX : maxX + 1] - 0.5;

% Histograma
H = histc(X, e);

% Número de barras - O vetor edges possui um elemento a mais devido ao
% ultimo elemento ser dado por histc (corresponde ao número de elementos de
% valor e(end))
nBins = length(e) - 1;

% Vetor com os centros das barras (eixo xx)
binCenters = [minX : maxX];

% Gráfico de barras
figure(1)
bar(binCenters, H(1:nBins));

title('Lançamento de um dado não viciado');
xlabel('Face do dado');
ylabel('Número de Ocorrências');

%% Exercício 2

% Número de lançamentos
n = [1e2, 1e3, 1e4, 1e5];

for k = 1 : length(n)
    % converter os numeros aleatorios gerados por rand no intervalo [0 1] para
    % o intervalo [1 6] usando arredondamento para cima
    X = ceil(6*rand(1, n(k)));

    % Minimo e maximos do vetor de lançamentos
    minX = min(X);
    maxX = max(X);

    % Intervalo de [0.5 6.5] com passos de 1 - representa as edges a considerar
    % no histograma - limites entre as barras para considerar a contagem de
    % ocorrencias
    e = [minX : maxX + 1] - 0.5;

    % Histograma
    H = histc(X, e);

    % Número de barras - O vetor edges possui um elemento a mais devido ao
    % ultimo elemento ser dado por histc (corresponde ao número de elementos de
    % valor e(end))
    nBins = length(e) - 1;

    % Vetor com os centros das barras (eixo xx)
    binCenters = [minX : maxX];

    % Gráfico de barras
    figure(k + 1);
    bar(binCenters, H(1:nBins));
    
    title('Lançamento de um dado não viciado');
    xlabel('Face do dado');
    ylabel('Número de Ocorrências');
    legend(['Nº de lançamentos: ' num2str(n(k))]);
end;

% À medida que o número de lançamentos aumenta, a frequência absoluta de
% cada um dos eventos possíveis tende a ser aproximadamente igual, estando
% de acordo com a teoria dos grandes números


%% Exercício 3
% Número de lançamentos
n = [1e2, 1e3, 1e4, 1e5];

for k = 1 : length(n)
    % converter os numeros aleatorios gerados por rand no intervalo [0 1] para
    % o intervalo [1 6] usando arredondamento para cima. 
    % Matrix 2xn(k) -> cada linha representa o lançamento de 1 dado
    X = ceil(6*rand(2, n(k)));

    % Obter a soma do lançamento dos dois dados
    sum = X(1, :) + X(2, :);
    
    % Minimo e maximos do vetor da soma dos lançamentos
    minX = min(sum);
    maxX = max(sum);

    % Intervalo de [0.5 6.5] com passos de 1 - representa as edges a considerar
    % no histograma - limites entre as barras para considerar a contagem de
    % ocorrencias
    e = [minX : maxX + 1] - 0.5;

    % Histograma
    H = histc(sum, e);

    % Número de barras - O vetor edges possui um elemento a mais devido ao
    % ultimo elemento ser dado por histc (corresponde ao número de elementos de
    % valor e(end))
    nBins = length(e) - 1;

    % Vetor com os centros das barras (eixo xx)
    binCenters = [minX : maxX];

    % Gŕafico de barras
    figure(2*k + 1)
    bar(binCenters, H(1:nBins)./n(k));
    
    title('Soma do lançamento de dois dado não viciados');
    xlabel('Número do dado');
    ylabel('Frequência relativa das ocorrências');
    legend(['Nº de lançamentos: ' num2str(n(k))]);
end;

% Os lançamentos estão de acordo com o previsto. A distribuição apresenta
% uma forma triangular, sendo o evento com maior probabilidade o evento do
% meio
