%% Trabalho Prático 6
clear; clc; close all;

%% Ex1
% Nº de elementos da realização do processo para um dado instante de tempo
n = 100;   

p = 0.1;    % probabilidade de P[Xn = 1] = p
            % probabilidade de P[Xn = 0] = (1 - p)

% Realização do processo
Xn = (rand(1, n) < p); 

figure(1)
stem(Xn)
title('Processo de Bernouli Xn');
xlabel('Tempo discreto');
ylabel('Valores de um acontecimento de Bernoulli');

%% Ex2
% número de realizações do processo
N = 5;  

% Alocar a matriz
Yn = zeros(5, n);

% Média esperada
media = (n * p);

% Variancia esperada
variancia = n*p*(1-p);

for m = 1: N
    % Realização de Xn
    Xn = (rand(n, 1) < p); 
    
    % Realização de Yn
    Yn(m, :) = cumsum(Xn, 1);
    
    % Plot
    figure(2)
    subplot(5, 2, 2*m - 1)
    stem(Xn);
    title(['X_' num2str(m)])
    xlabel('Tempo discreto');
    ylabel(['Acontecimento' sprintf('\n') 'de Bernoulli'])
    
    subplot(5, 2, 2*m)
    stem(Yn(m, :))
    hold on
    plot(p * (1:n))
    hold off
    title(['Y_' num2str(m)])
    xlabel('Tempo discreto');
    ylabel('Valor da Soma');
    legend(['Y_' num2str(m)], 'Média');
end;

% Podemos observar que o crescimento dos gráficos apresenta uma forte
% correlação com a média

%% Ex3
N = 100;    % número de realizações do processo de Bernoulli
n = 200;    % valor máximo do tempo discreto
p = 1/2;    % Probabilidade do processo de Bernoulli

% N realizações do processo de Bernoulli com p = 1/2 e n = 1, ..., 200.
Xn = round(rand(N, n));

% Processo estocástico de soma de Xn. A soma tem de ser efetuada em função
% das linhas
Sn = cumsum(Xn, 2);


%% Alínea a)
% Média esperada
media = (n * p);

% Variancia esperada
variancia = n*p*(1-p);

% Função densidade de probabilidade gaussiana com 25 valores centrada na
% média. Lembrar que o histograma tem 50 valores
fdp = 1/sqrt(2*pi*variancia) * exp(-((75:125) - media).^2/(2 * variancia));


% Gerar os histogramas com 10 bins de Xn nos intervalos desejados
S50 = hist(Sn(:, 50) - 0, 10);          % Xn, n = [1, 50]
S100 = hist(Sn(:, 100) - Sn(:, 50));    % Xn, n = [51, 100]
S150 = hist(Sn(:, 150) - Sn(:, 100));   % Xn, n = [101, 150]
S200 = hist(Sn(:, 200) - Sn(:, 150));   % Xn, n = [151, 200]

% Vetor do eixos dos xx. 10 elementos igualmente espaçados entre 0 e 50
xS = linspace(0, 50, 10);

% Fator de escala da fdp: número total de incrementos
scalingFactor = sum(S50 + S100 + S150 + S200);

% Histogramas
figure(3)
subplot(221)
bar(xS, S50/scalingFactor)
hold on
plot(fdp)
hold off
title('Histograma de S_{[1, 50]}');
xlabel('[1, 50]');
ylabel('Frequência Relativa dos incrementos');
legend('Histograma dos incrementos', 'FDP dos incrementos');

subplot(222)
bar(xS, S100/scalingFactor)
hold on
plot(fdp)
hold off
title('Histograma de S_{[51, 100]}');
xlabel('[51, 100]');
ylabel('Frequência Relativa dos incrementos');
legend('Histograma dos incrementos', 'FDP dos incrementos');

subplot(223)
bar(xS, S150/scalingFactor)
hold on
plot(fdp)
hold off
title('Histograma de S_{[101, 150]}');
xlabel('[101, 150]');
ylabel('Frequência Relativa dos incrementos');
legend('Histograma dos incrementos', 'FDP dos incrementos');

subplot(224)
bar(xS, S200/scalingFactor);
hold on
plot(fdp)
hold off
title('Histograma de S_{[151, 200]}');
xlabel('[151, 200]');
ylabel('Frequência Relativa dos incrementos');
legend('Histograma dos incrementos', 'FDP dos incrementos');

% O processo Sn possui incrementos independentes e é um proceso estocástico
% estacionário, porque Xn é um processo estocástico independente e
% identicamente distribuído. O valor da soma, Sn, só depende do incremento
% e não da posição inicial ou final

%% Alínea b)
figure(4)
plot(S50/scalingFactor, S100/scalingFactor)
title('S_{[1, 50]} vs S_{[51, 100]}');
xlabel('S_{[1, 50]}');
ylabel('S_{[51, 100]}');

% A independência dos acontecimentos pode ser verificada pelo declive da
% reta produzida. Se os acontecimentos forem independentes, a sua
% correlação é nula., logo a reta entre estes possui um declive nulo, o que
% obviamente não é o que se observa
