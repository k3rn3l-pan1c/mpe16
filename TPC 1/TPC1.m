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
plot(Sx(E), Sy(E), '.')
plot(Sx(C), Sy(C), '.')
hold off

title('Acontecimentos C e E no espaço amostral S');
xlabel('Eixo xx');
ylabel('Eixo yy');
legend('Espaço Amostral S', 'Acontecimento C', 'Acontecimento E');

%% Alínea b)

% Probabilidade do acontecimento C: como C é um vetor lógico, o número de
% 1 representa a frequencia absoluta do acontecimento C. O número de casos
% possíveis são o número de repetições da experiência
PC = sum(C) / N

% Probabilidade do acontecimento E: como E é um vetor lógico, o número de
% 1 representa a frequencia absoluta do acontecimento E. O número de casos
% possíveis são o número de repetições da experiência
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
% número de repetições consideradas.
% cumsum calcula as somas cumulativas, ou seja, o valor do indice k
% corresponde ao somatório dos primeiros k elementos
PC_N = cumsum(C) ./ (1:N);
PE_N = cumsum(E) ./ (1:N);

% Dependência do acontecimento C em função do número de repetições (N)
figure(2)
plot(1:N, PC_N);
title('Dependência do acontecimento C em função do número de repetições (N)');
xlabel('Número de repetições (N)');
ylabel('Probabilidade (P_C)');

% Dependência do acontecimento E em função do número de repetições (N)
figure(3)
plot(1:N, PE_N);
title('Dependência do acontecimento E em função do número de repetições (N)');
xlabel('Número de repetições (N)');
ylabel('Probabilidade (P_E)');

%% Alinea d)

% Probabilidade esperada para os acontecimentos C e E 
% Area(Acontecimento) / Area(Espaço Amostral)
PC_analitica = pi * sqrt(sqrt(2)).^2 / 4^2
PE_analitica = pi * a * b / 4^2

% Simulando para um número de repetições N=1e6, tanto para o acontecimento
% C como para o aconteciemento E os valores de probabilidade simulados
% aproximam-se dos valores analíticos. À medida que o número de repetições
% aumenta, espera-se que os resultados obtidos convirgam para o valor
% esperado

%% Alinea e)

% Subespaço Amostral do acontecimento C sabendo que ocorreu E. A condição
% que define o acontecimento C é obtida para o subconjunto do espaço
% amostral que resulta da condição E
C_E = Sx(E).^2 + Sy(E).^2 <= sqrt(2);

% Probabilidade do acontecimento C sabendo que ocorreu o acontecimento E.
% Como tanto C_E e E são vetores lógicos, a sua soma resulta na frequencia
% absoluta das suas condições
PC_E = sum(C_E) / sum(E)

% Probabilidade de o acontecimento C e E ocorrem. Os casos favoráveis são
% dados pela operação AND entre os vetores lógicos C e E, obtendo-se um
% vetor lógico, cujo somatório de todos os elementos resulta na frequencia
% absoluta do acontecimento (C e E)
PCE = sum(C & E) / N

% Confirmação do resultado obtido usando a regra de Bayes
PC_E_esperada = PCE / PE_N(end)

% Aplicando a regra de Bayes verificamos que os resultados estão de acordo


