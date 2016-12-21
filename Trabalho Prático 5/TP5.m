%% Trabalho Prático 5
clear; clc; close;

% Ler imagem
img = imread('skin.jpg');

figure(1)
imshow(img)
title('Imagem a ser utilizada')

% Conversão de RGB para HSV
hsv = rgb2hsv(img);
h = hsv(:, :, 1);
s = hsv(:, :, 2);

%% Exercício 1

% Converter os vetores h (Hue) e S (Saturation) para inteiros
H = ceil(99 * h) + 1;
S = ceil(99 * s) + 1;


%% Exercício 2

% Alocar matriz para a probability mass function conjunta
pmfHS = zeros(100);

% Função densidade de probabilidade conjunta
for l = 1 : 100
    for c = 1 : 100
        pmfHS(l, c) = sum(sum( (H == l) & (S == c)));
    end;
end;

% Normalizar a probabilidade
pmfHS = pmfHS ./ sum(sum(pmfHS));

figure(2)
surf(pmfHS)
title('Função densidade de probabilidade')
xlabel('H (hue)');
ylabel('S (Saturation)');
zlabel('Probabilidade');

%% Exercício 3
% Função densidade de probabilidade marginal de h (hue )
pmfH = sum(pmfHS, 2);

% Função densidade de probabilidade marginal de s (saturation)
pmfS = sum(pmfHS, 1);

figure(3);
bar(pmfH);
title('Função densidade de probabilidade de H (Hue)')
xlabel('H (hue)');
ylabel('Probabilidade');

figure(4)
bar(pmfS);
title('Função densidade de probabilidade de S (Saturation)')
xlabel('S (Saturation)');
ylabel('Probabilidade');

%% Exercício 4
% Se as funções de densidade de probabilidade forem independentes, a pmf
% conjunta é a multiplicação das pmf individuais
pmfIndependente = pmfH * pmfS;

figure(5)
surf(pmfIndependente)
title('Função densidade de probabilidade conjunta')
xlabel('S (Saturation)');
ylabel('H (hue)');
zlabel('Probabilidade');

% Como se pode observar pelos gráficos 5 e 2, as pmf conjuntas são
% ligeiramente diferentes, logo H e S não duas variáveis aleatórias
% independentes

%% Exercício 5
% Função densidade acumulada da hue
fdaH = cumsum(pmfH);

% Função densidade acumulada da saturation
fdaS = cumsum(pmfS);

% Gama de valores de H que possuem 70% dos pixeis. Indíces da função
% distribuição de probabilidade acumulada que correspondem a 70% dos pixeis.
gamaH = find( (fdaH >= 0.1) & (fdaH <= 0.8)  );

% Obter os indices finais e iniciais
gamaH = [gamaH(1)-1 gamaH(end)+1];

% Gama de valores de S que possuem 70% dos pixeis. Indíces da função
% distribuição de probabilidade acumulada que correspondem a 70% dos pixeis.
gamaS = find( (fdaS >= 0.1) & (fdaS <= 0.8) );

% Obter os indices finais e iniciais
gamaS = [gamaS(1)-1 gamaS(end)+1];

figure(6)
plot(fdaH)
title('Função densidade de probabilidade acumulada de H (hue)')
xlabel('S (Saturation)');
ylabel('Probabilidade');

figure(7)
plot(fdaS)
title('Função densidade de probabilidade acumulada de S (Saturation)')
xlabel('S (Saturation)');
ylabel('Probabilidade');


%% Exercício 6
% Ler nova imagem a ser usada para detetar a cara
img2 = imread('cara.jpg');

figure(8)
imshow(img2)
title('Nova Imagem a ser utilizada')

% Conversão de RGB para HSV dos componentes cromáticos da nova imagem
hsv2 = rgb2hsv(img2);
h2 = hsv2(:, :, 1);
s2 = hsv2(:, :, 2);

% usar a função detetor, que dadas as componentes cromáticas da imagem (hue
% e saturation, para HSV), obtém a cara da imagem
detector(h2, s2, gamaH/100, gamaS/100)
