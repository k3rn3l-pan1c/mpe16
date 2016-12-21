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
media = (n * p)

% Variancia esperada
variancia = n*p*(1-p)

% Realização de Xn
Xn = (rand(N, n) < p); 

% Realização de Yn
Yn = cumsum(Xn, 2);

% Média amostral das realizações 
mediaSn = mean(Yn, 1)    

% Variância temporal
varSn = var(Yn,[], 2)

for m = 1: N

    % Plot
    figure(2)
    subplot(5, 2, 2*m - 1)
    stem(Xn(m, :));
    title(['X_' num2str(m)])
    xlabel('Tempo discreto');
    ylabel(['Acontecimento' sprintf('\n') 'de Bernoulli'])
    
    subplot(5, 2, 2*m)
    stem(Yn(m, :))
    hold on
    plot(p * (1:n))
    plot(mediaSn)
    hold off
    title(['Y_' num2str(m)])
    xlabel('Tempo discreto');
    ylabel('Valor da Soma');
    legend(['Y_' num2str(m)], 'Média Teórica', 'Média Experimental');
end;

% Podemos observar que o crescimento dos gráficos apresenta uma forte
% correlação com a média esperada. A média experimental difere bastante da
% teórica porque o número de 

%% Ex3
N = 100;    % número de realizações do processo de Bernoulli
n = 200;    % valor máximo do tempo discreto
p = 1/2;    % Probabilidade do processo de Bernoulli

% N realizações do processo de Bernoulli com p = 1/2 e n = 1, ..., 200.
Xn = (rand(N, n) < p);

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
S100 = hist(Sn(:, 100) - Sn(:, 50), 10);    % Xn, n = [51, 100]
S150 = hist(Sn(:, 150) - Sn(:, 100), 10);   % Xn, n = [101, 150]
S200 = hist(Sn(:, 200) - Sn(:, 150), 10);   % Xn, n = [151, 200]

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
% Gráfico dos valores dos incrementos no intervalo [1, 50] vs os
% incrementos do intervalo [51, 100]
figure(4)
plot(Sn(:, 50) - 0, Sn(:, 100) - Sn(:, 50), '*')
title('S_{[1, 50]} vs S_{[51, 100]}');
xlabel('S_{[1, 50]}');
ylabel('S_{[51, 100]}');


% Novas N Realizações em que foi alterada a probabilidade do acontecimento
% para p = 0.2 n = 1, ..., 200.
An = (rand(N, n) < 0.2); 

% Soma cumulativa do novo processo aleatório
SAn = cumsum(An, 2);         

% Gráfico dos valores dos incrementos no intervalo [1, 50] vs os
% incrementos do intervalo [51, 100] para a nova probabilidade
figure(5)
plot(SAn(:, 50) - 0, Sn(:, 100) - SAn(:, 50), '*')
title(['S_{[1, 50]} vs S_{[51, 100]}' sprintf('\n') 'Outra realização do processo']);
xlabel('S_{[1, 50]}');
ylabel('S_{[51, 100]}');

% A independência pode ser verificada modificando a probabilidade de um
% intervalo, e verificando que um dos eixos foi alterado, enquanto que o
% outro permanece igual. Logo as variáveis são independentes., porque a
% realização de uma não afeta a realização da outra

%% Exercício 4
% vetor de tempos
t = 0:0.001:100;

% Taxa média de chegadas por segundo
lambda = 1;

% probabilidade do elemento 0
% p0 = (lambda .* t).^0 ./ factorial(0) .* exp(-t);
p0 = exp(-t);

% probabilidade do elemento 1
% p1 = (lambda .* t).^1 ./ factorial(1) .* exp(-t);
p1 = (lambda * t).*exp(-t);

% Probabilidade de ocorrerem elementos k > 1. Pela probabilidade do
% complemento
p = 1 - p0 - p1;

% A probabilidade de ocorrerem 2 ou mais chegadas no mesmo intervalo de
% tempo pretende-se que seja 100x inferior à probabilidade de 1 ou 0
% chegadas
idx = sum((p < (p1./100)) & (p < (p0/100)));

% As probabilidades são
p1(idx)
p0(idx)
p(idx)

% O processo de Poisson é definido em t [0, 100].
figure(6)
plot(t, p, t, p0, t, p1)
title('Processo Estocástico de Poisson modelado por um Processo Estocástico Binomial')
legend('p', 'p0', 'p1');

% O número de subintervalos mínimos do processo binomial para garantir que
% a ocorrência de 2 ou mais chegadas é desprezável é:
n = lambda .* t(end) ./ p1(idx)

% E o intervalo de tempo máximo entre cada acontecimento da variável
% binomial é: 
delta = t(end) ./ n


%% Alinea a) 
% 10 realizações do processo de Poisson aproximado pelo processo Binomial
Xn = rand(10, ceil(n)) < p1(idx);
Sn = cumsum(Xn, 2);

% Intervalo de tempo espaçado com o passo temporal máximo
t = (0:n).*delta;

figure(7)
hold on
% plot de todas as realizações
for k = 1 : 10
    plot(t, Sn(k, :))
end
% Plot da média
plot(t, mean(Sn, 1), 'LineWidth', 3)
hold off
xlabel('Tempo (s)');
ylabel('Nº chegadas');
title('Realizações do processo estocástico de Poisson')
legend('1', '2', '3', '4', '5', '6', '7', '8', '9', '10' , 'Média')

% O processo estocástico de Poisson modulado pelo processo estocástico de
% Bernoulli é roubusto, porque atingiu o valor de 100 chegadas médias em
% 100 segundos com uma taxa média de chegadas de 1 chegada/s

%% Exercício 5
% Como o número de chegadas por segundo diminui, vamos considerar que o
% número de subintervalos se mantêm válido 

% Intervalo de tempo
t = 60;

% Número de pedidos por segundo
lambda = 15 / 60;

% Número de realizações do processo
numR = 1000;


% Probabilidade do processo
p=(lambda*t)/n;

% Processo Binomial
Xn = rand(numR, ceil(n)) < p;

% Processo soma
Sn = cumsum(Xn, 2);

% Probabilidade pratica: número de ocorrencias por realização * instante de
% tempo / intervalo de tempo
p10_pratica = sum(Sn(:, ceil(n * 10 / t))==3)/numR

% Sabemos que o processo de poisson possui incrementos estacionários
p15_pratica = sum(Sn(:, ceil(n * 15 / t))==2)/numR 

% Sem considerar que o processo de Poisson possui incrementos estacionários
p60_45_pratica = sum(abs((Sn(:, ceil(n * 60 / t)) - Sn(:, ceil(n * 45 / t)))) ==2)/numR 


% Probabilidades teóricas
p15_teorica = (15*lambda)^2 /factorial(2) * exp(-15*lambda)
p10_teorica = (10*lambda)^3 /factorial(3) * exp(-10*lambda)
