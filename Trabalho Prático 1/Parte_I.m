%% Trabalho Prático 1 - parte I
clear; close; clc;

%% Exercício 1
% Execute o programa e interprete os resultados. Cada face do dado saiu
% quantas vezes? Esperava obter esses resultados? Porquẽ?

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

% Número de barras - O vetor edges possui mais um elemento devido ao ultimo
% elemento do vetor retornado por histc corresponder ao número de elementos
% de valor e(end), pelo que deve ser descartado
nBins = length(e) - 1;

% Vetor com os centros das barras (eixo xx). valores inteiros entre 1 e 6
binCenters = [minX : maxX];

% Gráfico de barras
% H é indexado para se obter todos os valores excepto o último
figure(1)
bar(binCenters, H(1:nBins));

title('Lançamento de um dado não viciado');
xlabel('Face do dado');
ylabel('Número de Ocorrências');


% Visto ser uma experiẽncia aleatória, a frequência absoluta de cada face
% varia de repetição da experiência para repetição, não se obtendo os
% valores das probabilidades esperados: valores iguais para cada face. Isto
% deve-se ao número de lançamentos ser bastante reduzido, sendo a
% frequência relativa uma boa aproximação somente quando o número de
% repetições é elevado

%% Exercício 2
% Execute o programa para n = 1000, n = 10000, n = 100000. Comente os
% resultados

% Número de lançamentos
n = [1e2, 1e3, 1e4, 1e5];

for k = 1 : length(n)
    % converter os numeros aleatorios gerados por rand no intervalo [0 1]
    % para o intervalo [1 6] usando arredondamento para cima
    X = ceil(6*rand(1, n(k)));

    % Minimo e maximos do vetor de lançamentos
    minX = min(X);
    maxX = max(X);

    % Intervalo de [0.5 6.5] com passos de 1 - representa as edges a
    % considerar no histograma - limites entre as barras para considerar a
    % contagem de ocorrencias
    e = [minX : maxX + 1] - 0.5;

    % Histograma
    H = histc(X, e);

    % Número de barras - O vetor edges possui mais um elemento devido ao
    % ultimo elemento do vetor retornado por histc corresponder ao número
    % de elementos de valor e(end), pelo que deve ser descartado
    nBins = length(e) - 1;

    % Vetor com os centros das barras (eixo xx)
    binCenters = [minX : maxX];

    % Gráfico de barras
    % H é indexado para se obter todos os valores excepto o último
    figure(k + 1);
    bar(binCenters, H(1:nBins)./n(k));
    
    title('Lançamento de um dado não viciado');
    xlabel('Face do dado');
    ylabel('Frequência relativa');
    legend(['Nº de lançamentos: ' num2str(n(k))]);
end;

% À medida que o número de lançamentos aumenta, a frequência absoluta de
% cada um dos eventos possíveis tende a ser aproximadamente igual, estando
% de acordo com a teoria dos grandes números. Logo, a frequência relativa
% tenderá a aproximar-se do valor da probabilidade do acontecimento


%% Exercício 3
% Modifique o programa para simular o resultado da soma obtida com o
% lançamento de dois dados. Execute o programa e comente os resultados

% Número de lançamentos
n = [1e2, 1e3, 1e4, 1e5];

for k = 1 : length(n)
    % converter os numeros aleatorios gerados por rand no intervalo [0 1]
    % para o intervalo [1 6] usando arredondamento para cima. 
    % Matriz 2xn(k) -> cada linha representa o lançamento de 1 dado
    X = ceil(6*rand(2, n(k)));

    % Obter a soma do lançamento dos dois dados. (soma linha a linha dos
    % elementos da matriz)
    sumX = sum(X, 1)
    
    % Minimo e maximos do vetor da soma dos lançamentos
    minX = min(sumX);
    maxX = max(sumX);

    % Intervalo de [0.5 6.5] com passos de 1 - representa as edges a
    % considerar no histograma - limites entre as barras para considerar a
    % contagem de ocorrencias
    e = [minX : maxX + 1] - 0.5;

    % Histograma
    H = histc(sumX, e);

    % Número de barras - O vetor edges possui mais um elemento devido ao
    % ultimo elemento do vetor retornado por histc corresponder ao número
    % de elementos de valor e(end), pelo que deve ser descartado
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
% meio.
