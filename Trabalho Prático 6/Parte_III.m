%% Parte III
clear; clc; close all;

%% Exercício 1

% Número de amostras de ruído
n = 20;

% Período de amostragem
ts = 1e-6;

% Frequências dos tons
f1 = 0.1/ts;
f2 = 0.4/ts;

% Ruído gaussiano iid com média nula e variância unitária
N = randn(1, n);

% Sinal com ruído
X = cos(2*pi*f1*(0:n-1)*ts) + cos(2*pi*f2*(0:n-1) * ts) + N;

%% Alínea a) 
% Número de amostras de ruído
n = 20;

% Número de realizações do processo
numR = 1000;

X = zeros(numR, n);
for k = 1:numR
    % Ruído gaussiano iid com média nula e variância unitária
    N = randn(1, n);
    
    % Sinal com Ruído
    X(k, :) = cos(2*pi*f1*(0:n-1)*ts) + cos(2*pi*f2*(0:n-1) * ts) + N;
end;

% Transformada de fourier do sinal
Xf = fft(X, [], 2);

% Estimativa da DEP com base no periodograma
periodograma = sum(abs(Xf).^2)./ numR;

% Vetor de frequências
f = (0 : (n-1)) ./ n - 1/2;

figure(1)
plot(f, fftshift(periodograma), '*-')
title('Periodograma de X(t)')
xlabel('frequências');
ylabel('|Xf(f)|');

%% Alínea b) 
% Número de amostras de ruído
n = 100;

% Número de realizações do processo
numR = 1000;

X = zeros(numR, n);
for k = 1:numR
    % Ruído gaussiano iid com média nula e variância unitária
    N = randn(1, n);
    
    % Sinal com Ruído
    X(k, :) = cos(2*pi*f1*(0:n-1)*ts) + cos(2*pi*f2*(0:n-1) * ts) + N;
end;

% Transformada de fourier do sinal
Xf = fft(X, [], 2);

% Estimativa da DEP com base no periodograma
periodograma = sum(abs(Xf).^2) / numR;

% Vetor de frequências
f = (0 : (n-1)) ./ n - 1/2;

figure(2)
plot(f, fftshift(periodograma), '*-')
title('Periodograma de X(t)')
xlabel('frequências');
ylabel('|Xf(f)|');

%%
% Para a DEP teorica:
% dividir fft pelo número de realizações
% dividir por sqrt(A) dividir fft por sqrt do número de amostras

%% Exercício 2
clear; clc; close all;

% Número de realizações
numR = 1000;

% Número de amostras
n = 64;

% Processo Xn (+- 1 com igual probabilidade)
Xn = 2 * rand(numR, n) - 1;

% Condições iniciais do processo Yn
Yn(:, 1) = Xn(:, 1) - 0;

% processo Yn
for k = 2 : n
    Yn(:, k) = Xn(:, k) - Xn(:, k-1);
end;

%% Alínea a)
% Transformada de fourier do sinal
Yf = fft(Yn, [], 2);

% Estimativa da DEP com base no periodograma
periodograma = sum(abs(Yf).^2) / numR;

% Vetor de frequências
f = (0 : (n-1)) ./ n - 1/2;

figure(3)
plot(f, fftshift(periodograma), '*-')
title('Periodograma de Y(t)')
xlabel('Frequência (f/f_a)');
ylabel('|Yf(f)|');

% O periodograma representa um passa alto

%% Alínea b)
clear;

% Número de realizações/periodogramas
numR = [10 100 1000];

% Número de amostras
n = 64;

% Alocar memória para o periodograma
periodograma = zeros(length(numR), n);

for m = 1 : length(numR)
    
    % Processo Xn (+- 1 com igual probabilidade)
    Xn = 2 * rand(numR(m), n) - 1;

    Yn = zeros(numR(m), n);
    Yn(:, 1) = Xn(:, 1) - 0;

    for k = 2 : n
        Yn(:, k) = Xn(:, k) - Xn(:, k-1);
    end;


    % Transformada de fourier do sinal
    Yf = fft(Yn, [], 2);

    % Estimativa da DEP com base no periodograma
    periodograma(m, :) = sum(abs(Yf).^2) ./ numR(m);

    % Vetor de frequências
    f = (0 : (n-1)) ./ n - 1/2;
    figure(3 + m)
    plot(f, fftshift(periodograma(m, :)), '*-')
    title(['Periodograma de Y(t)' sprintf('\n') num2str(numR(m)) ' Realizações'])
    xlabel('frequências');
    ylabel('|Yf(f)|');

    % O periodograma representa um passa alto
end;


% à medida que o número de realizaçãoes aumenta, o periodograma tende para
% a DEP do processo, como seria de esperar

%% Alínea c - i)
% Número de realizações
numR = 1000;

% Número de amostras
n = 64;

% Número de realizações
numR = [10 100 1000];

% Número de amostras
n = 64;

% Vetor de frequências
f = (0 : (n-1)) ./ n - 1/2;

% Alocar memória para o periodograma
periodograma = zeros(length(numR), n);

for m = 1 : length(numR)
    % Processo Xn (variáveis aleatórias independentes uniformemente
    % distribuídas no intervalo
    Xn = rand(numR(m), n);

    Yn = zeros(numR(m), n);
    Yn(:, 1) = Xn(:, 1) - 0;

    for k = 2 : n
        Yn(:, k) = Xn(:, k) - Xn(:, k-1);
    end;


    % Transformada de fourier do sinal
    Yf = fft(Yn, [], 2);

    % Estimativa da DEP com base no periodograma
    periodograma(m, :) = sum(abs(Yf).^2) ./ numR(m);

    % Vetor de frequências
    f = (0 : (n-1)) ./ n - 1/2;
    figure(7 + m)
    plot(f, fftshift(periodograma(m, :)), '*-')
    title(['Periodograma de Y(t)' sprintf('\n') num2str(numR(m)) ' Realizações'])
    xlabel('frequências');
    ylabel('|Yf(f)|');

    % O periodograma representa um passa alto
end;


% à medida que o número de realizaçãoes aumenta, o periodograma tende para
% a DEP do processo, como seria de esperar

%% Alíena c -ii)
% Número de realizações
numR = 1000;

% Número de amostras
n = 64;

% Número de realizações
numR = [10 100 1000];

% Número de amostras
n = 64;

% Vetor de frequências
f = (0 : (n-1)) ./ n - 1/2;

% Alocar memória para o periodograma
periodograma = zeros(length(numR), n);

for m = 1 : length(numR)
    % Processo Xn (gaussiana de média nula e variância unitária
    Xn = randn(numR(m), n);

    Yn = zeros(numR(m), n);
    Yn(:, 1) = Xn(:, 1) - 0;

    for k = 2 : n
        Yn(:, k) = Xn(:, k) - Xn(:, k-1);
    end;


    % Transformada de fourier do sinal
    Yf = fft(Yn, [], 2);

    % Estimativa da DEP com base no periodograma
    periodograma(m, :) = sum(abs(Yf).^2) ./ numR(m);

    % Vetor de frequências
    f = (0 : (n-1)) ./ n - 1/2;
    figure(11 + m)
    plot(f, fftshift(periodograma(m, :)), '*-')
    title(['Periodograma de Y(t)' sprintf('\n') num2str(numR(m)) ' Realizações'])
    xlabel('frequências');
    ylabel('|Yf(f)|');

    % O periodograma representa um passa alto
end;


% à medida que o número de realizaçãoes aumenta, o periodograma tende para
% a DEP do processo, como seria de esperar

%% Exercício 3
clear; clc; close all;

% Número de realizações
numR = 1000;

% Número de amostras
n = 64;

% Processo Xn
Xn = 2 * rand(numR, n) - 1;

Yn(:, 1) = Xn(:, 1) - 0;
Yn(:, 2) = 0.5 * Yn(:, 1) + Xn(:, 2);
Yn(:, 3) = 0.5 * Yn(:, 1) -0.25 * Yn(:, 2) + Xn(:, 3);
for k = 3 : n
    Yn(:, k) = 0.5 * Yn(:, k-1) -0.25 * Yn(:, k-2) + Xn(:, k);
end;

%% Alínea a)
% Transformada de fourier do sinal
Yf = fft(Yn, [], 2);

% Estimativa da DEP com base no periodograma
periodograma = sum(abs(Yf).^2) / numR;

% Vetor de frequências
f = (0 : (n-1)) ./ n - 1/2;

figure(3)
plot(f, fftshift(periodograma), '*-')
title('Periodograma de Y(t)')
xlabel('frequências');
ylabel('|Yf(f)|');

% O periodograma representa um passa alto

%% Alínea b)
clear;

% Número de realizações
numR = [10 100 1000];

% Número de amostras
n = 64;

% Alocar memória para o periodograma
periodograma = zeros(length(numR), n);

for m = 1 : length(numR)
    % Processo Xn
    Xn = 2 * rand(numR(m), n) - 1;
    
    Yn = zeros(numR(m), n);
    
    Yn(:, 1) = Xn(:, 1) - 0;
    Yn(:, 2) = 0.5 * Yn(:, 1) + Xn(:, 2);
    Yn(:, 3) = 0.5 * Yn(:, 1) -0.25 * Yn(:, 2) + Xn(:, 3);
    for k = 3 : n
        Yn(:, k) = 0.5 * Yn(:, k-1) -0.25 * Yn(:, k-2) + Xn(:, k);
    end;
    


    % Transformada de fourier do sinal
    Yf = fft(Yn, [], 2);

    % Estimativa da DEP com base no periodograma
    periodograma(m, :) = sum(abs(Yf).^2) ./ numR(m);

    % Vetor de frequências
    f = (0 : (n-1)) ./ n - 1/2;
    figure(3 + m)
    plot(f, fftshift(periodograma(m, :)), '*-')
    title(['Periodograma de Y(t)' sprintf('\n') num2str(numR(m)) ' Realizações'])
    xlabel('frequências');
    ylabel('|Yf(f)|');

    % O periodograma representa um passa alto
end;


% à medida que o número de realizaçãoes aumenta, o periodograma tende para
% a DEP do processo, como seria de esperar

%% Alínea c - i)
% Número de realizações
numR = 1000;

% Número de amostras
n = 64;

% Número de realizações
numR = [10 100 1000];

% Número de amostras
n = 64;

% Vetor de frequências
f = (0 : (n-1)) ./ n - 1/2;

% Alocar memória para o periodograma
periodograma = zeros(length(numR), n);

for m = 1 : length(numR)
    % Processo Xn
    Xn = rand(numR(m), n);
    
    Yn = zeros(numR(m), n);
    
    Yn(:, 1) = Xn(:, 1) - 0;
    Yn(:, 2) = 0.5 * Yn(:, 1) + Xn(:, 2);
    Yn(:, 3) = 0.5 * Yn(:, 1) -0.25 * Yn(:, 2) + Xn(:, 3);
    for k = 3 : n
        Yn(:, k) = 0.5 * Yn(:, k-1) -0.25 * Yn(:, k-2) + Xn(:, k);
    end;
    

    % Transformada de fourier do sinal
    Yf = fft(Yn, [], 2);

    % Estimativa da DEP com base no periodograma
    periodograma(m, :) = sum(abs(Yf).^2) ./ numR(m);

    % Vetor de frequências
    f = (0 : (n-1)) ./ n - 1/2;
    figure(7 + m)
    plot(f, fftshift(periodograma(m, :)), '*-')
    title(['Periodograma de Y(t)' sprintf('\n') num2str(numR(m)) ' Realizações'])
    xlabel('frequências');
    ylabel('|Yf(f)|');

    % O periodograma representa um passa alto
end;


% à medida que o número de realizaçãoes aumenta, o periodograma tende para
% a DEP do processo, como seria de esperar

%% Alíena c -ii)
% Número de realizações
numR = 1000;

% Número de amostras
n = 64;

% Número de realizações
numR = [10 100 1000];

% Número de amostras
n = 64;

% Vetor de frequências
f = (0 : (n-1)) ./ n - 1/2;

% Alocar memória para o periodograma
periodograma = zeros(length(numR), n);

for m = 1 : length(numR)
    % Processo Xn
    Xn = randn(numR(m), n);
    
    Yn = zeros(numR(m), n);
    
    Yn(:, 1) = Xn(:, 1) - 0;
    Yn(:, 2) = 0.5 * Yn(:, 1) + Xn(:, 2);
    Yn(:, 3) = 0.5 * Yn(:, 1) -0.25 * Yn(:, 2) + Xn(:, 3);
    for k = 3 : n
        Yn(:, k) = 0.5 * Yn(:, k-1) -0.25 * Yn(:, k-2) + Xn(:, k);
    end;
    

    % Transformada de fourier do sinal
    Yf = fft(Yn, [], 2);

    % Estimativa da DEP com base no periodograma
    periodograma(m, :) = sum(abs(Yf).^2) ./ numR(m);

    % Vetor de frequências
    f = (0 : (n-1)) ./ n - 1/2;
    figure(11 + m)
    plot(f, fftshift(periodograma(m, :)), '*-')
    title(['Periodograma de Y(t)' sprintf('\n') num2str(numR(m)) ' Realizações'])
    xlabel('frequências');
    ylabel('|Yf(f)|');

    % O periodograma representa um passa alto
end;


% à medida que o número de realizaçãoes aumenta, o periodograma tende para
% a DEP do processo, como seria de esperar
