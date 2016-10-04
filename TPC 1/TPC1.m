%% TPC 1

% Pedro Martins
% nºmec 76374
clear; clc; close;

%% Alínea a)

% número de repetições
N = 1e4;

% Resultados do espaço amostral para N repetições
Sx = rand(1, N) * 4 - 2;
Sy = rand(1, N) * 4 - 2;

% Parametros da parábola
a = 2;      % expansão segundo xx
b = 1;      % expansão segundo yy

% Acontecimento C: Elementos do espaço amostral que pertencem à
% circunferência centrada em 0 de raio sqrt(sqrt(2))
C = Sx.^2 + Sy.^2 <= sqrt(2);

% Acontecimento E: Elementos do espaço amostral que pertencem à elipse com 
% semieixos a e b
E = (Sx/a).^2 + (Sy/b).^2 <= 1;

% Subespaço do acontecimento C
Cx = Sx(C);
Cy = Sy(C);

% Subespaço do acontecimento E
Ex = Sx(E);
Ey = Sy(E);

% Espaço de amostragem e acontecimentos
figure(1)
plot(Sx, Sy, '.')
hold on
plot(Sx(C), Sy(C), '.')
plot(Sx(E), Sy(E), '.')
hold off

title('Acontecimentos C e E no espaço amostral S');
xlabel('Eixo xx');
ylabel('Eixo yy');
legend('Espaço Amostral S', 'Acontecimento C', 'Acontecimento E');

%% Alínea b)

% Probabilidade do acontecimento C: como C é um vetor lógico, o número de
% 1 representa a frequencia absoluta do acontecimento C. O número de casos
% possíveis é o número de repetições do problema
PC = sum(C) / N

% Probabilidade do acontecimento E: como E é um vetor lógico, o número de
% 1 representa a frequencia absoluta do acontecimento E. O número de casos
% possíveis é o número de repetições do problema
PE = sum(E) / N

%% Alinea c)

% Novo número de repetições
N = 1e6;

% Elementos do espaço amostral para N repetições
Sx = rand(1, N) * 4 - 2;
Sy = rand(1, N) * 4 - 2;

% Acontecimento C: Elementos do espaço amostral que pertencem à
% circunferência centrada em 0 de raio sqrt(sqrt(2))
C = Sx.^2 + Sy.^2 <= sqrt(2);

% Acontecimento E: Elementos do espaço amostral que pertencem à elipse com 
% semieixos a e b
E = (Sx/a).^2 + (Sy/b).^2 <= 1;

% A probabilidade do acontecimento em função do número de repetições pode
% ser obtida pela frequencia absoluta para N repetições dividindo pelo
% número de repetições considerada
PC_N = cumsum(C) ./ (1:N);
PE_N = cumsum(E) ./ (1:N);

% Dependência do acontecimento C em função do número de repetições (N)
figure(2)
plot(1:N, PC_N);
title('Dependência do acontecimento C em função do número de repetições (N)');
xlabel('Número de repetições (N)');
ylabel('Probabilidade (P_C)');

figure(3)
plot(1:N, PE_N);
title('Dependência do acontecimento E em função do número de repetições (N)');
xlabel('Número de repetições (N)');
ylabel('Probabilidade (P_E)');

%% Alinea d)

% Probabilidade esperada para os acontecimentos. 
% Area(Acontecimento) / Area(Espaço Amostral)
PC = pi * sqrt(sqrt(2)).^2 / (4 * 4)
PE = pi * a * b / (4 * 4)

%% Alinea e)

% Subespaço Amostral do acontecimento C sabendo que ocorreu E
C_E = Sx(E).^2 + Sy(E).^2 <= sqrt(2);

% Probabilidade do acontecimento C sabendo que ocorreu o acontecimento E.
% Como tanto C_E e E são vetores lógicos, a sua soma resulta na frequencia
% absoluta dos acontecimentos
PC_E = sum(C_E) / sum(E)

% Probabilidade de o acontecimento C e E ocorrem. Os casos favoráveis são
% dados pela operação AND entre os vetores lógicos C e E, obtendo-se um
% vetor lógico, cujo somatório de todos os elementos resulta na frequencia
% absoluta do acontecimento C e E
PCE = sum(C & E) / N

% Confirmação do resultado obtido usando a regra de Bayes
PC_E_esperada = PCE / PE



