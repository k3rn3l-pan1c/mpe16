%% Parte II
clear; clc; close;

%% Exercício 1
% Escreva um programa que simule 100 lançamentos consecutivos de uma moeda.
% Denote por x o número de caras obtidas

% Número de lançamentos
n = 1e3;

% Lançar 100 vezes consecutivas uma moeda e contar as ocorrencias de cara
% (arbitramos que cara = 1 e coroa = 0). repetir 1000 vezes
x = sum( round(rand(n, 100)), 2);

%% Exercício 2
% Faça um histograma do numero de caras saídas. Varie a largura da barra
% dos histograma entre 1 e 5 e observe o resultado.

% Largura da barra
barwidth = 1:5;

% Figure Holder
fig = zeros(1, length(barwidth));

% Guardar para usar no ex5
maxX_corrected = zeros(size(barwidth));

for k = 1 : length(barwidth)
    % Minimo e máximo do número de caras da experiência
    minX = min(x);
    maxX = max(x);
    
    % No caso de a largura de barra e o número de elementos não forem
    % divisiveis, é necessário corrigir o valor do x max
    maxX_corrected(k) = ceil((maxX - minX)./barwidth(k)) .* barwidth(k) + minX;

    % Intervalo
    % [minX - 0.5 * barwidth(k), maxX_corrected + 0.5 * barwidth(k)] 
    % com passos de barwidth(k) - representa as edges a considerar no
    % histograma - limites entre as barras para considerar a contagem de
    % ocorrencias 
    e = [minX : barwidth(k) : maxX_corrected(k) + barwidth(k)] - 0.5 * barwidth(k);

    % Histograma
    H = histc(x, e);

    % Número de barras - O vetor edges possui um elemento a mais devido ao
    % ultimo elemento ser dado por histc (corresponde ao número de
    % elementos de valor e(end))
    nBins = length(e) - 1;
    
    % Vetor com os centros das barras (eixo xx)
    binCenters = [minX : barwidth(k): maxX_corrected(k)];
    
    % Gráfico de barras
    fig(k) = figure(k);
    bar(binCenters, H(1:nBins));
    
    title('Número de caras obtidas efetuadas 100 lançamentos consecutivos de uma moeda');
    ylabel('Frequência Absoluta');
    xlabel('Numero de Caras');
    legend(['Nº de repetições: ' num2str(n)]);
end;

%% Exercício 3
% Calcule o valor médio, m, de x
m = mean(x);

%% Exercício 4
% Calcule a variância e o desvio padrão de x
variancia = var(x);                 % Variãncia
desvio_padrao = sqrt(variancia);    % Desvio padrão

%% Exercício 5
% Ajuste a função distribuição de probabilidade gaussiana ao histograma,
% onde o fator de ajuste (k) depende de N (número de repetições) e da
% largura das barras


% Fator de correçao (probabilidade do evento * nº de experiências * largura
% da barra). Supondo que a moeda é não viciada, a probabilidade de ocorrer
% cara = 1/2. O fator de ajuste e a barwidth são diretamente proporcionais,
% pois quanto maior a barwidth, maior o número de ocorrências 
k = 0.5 * n * barwidth;

for c = 1 : length(fig)
    % Indices x (já com a correção efetuada para cada uma das barwidth
    x_idx = minX : barwidth(c) : maxX_corrected(c);
    
    % Função Distribuição de Probabilidade Gaussiana
    fdp = k(c) .* 1./sqrt(2.*pi.*desvio_padrao) .* exp(-0.5 .* ((x_idx - m)./desvio_padrao).^2);
    
    figure(fig(c));     % selecionar a figura
    hold on
    
    % legenda anterior
    oldLegend = get(legend(gca),'String');
    
    plot(x_idx, fdp);   % plot FDP
    legend(oldLegend, 'FDP Gaussiana');
    hold off
end;
