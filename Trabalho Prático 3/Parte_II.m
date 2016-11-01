%% Parte II
clear; clc; close;

load trab03.mat;    % é criada a variável y

%% Ex1
% Quantizar para 7 bits (remover o 1 bit menos significativo).
% Dividir por 2^K equivale a fazer um shift de k bits à direita,
% removendo k bits ao número
yq = floor(y / 2);

% Diferenças consecutivas (é necessário concatenar um elemento no
% início para obter o valor do 1º elemento -> condição inicial do
% filtro das diferenças consecutivas é o elemento 0 (garantir
% causalidade))
ydifq = diff([0 ; yq]);

% Valores unicos de ydifq e yq
yq_unique = unique(yq);
ydifq_unique = unique(ydifq);

% Alocar memória
pmf_yq = zeros(size(yq_unique));
pmf_ydifq = zeros(size(ydifq_unique));

% Calcular as probability mass fuction. A função diff duplica o número de
% elementos, sendo o vetor com mais dados usado no ciclo for
for k = 1 : length(ydifq_unique)
    
    % proteger de index out of bonds
    if(k < length(yq_unique))
        % contar as ocorrencias dos valores unicos de yq
        pmf_yq(k) = sum(yq == yq_unique(k));
    end;
    
    % contar as ocorrencias dos valores unicos de ydifq
    pmf_ydifq(k) = sum(ydifq == ydifq_unique(k));
  
end;

% Dividir pelo número total de ocorrencias para obter a probabilidade
pmf_yq = pmf_yq / sum(pmf_yq);
pmf_ydifq = pmf_ydifq / sum(pmf_ydifq);

%% Ex 2
figure(1)
hist(yq, yq_unique);
title('Histograma da variável yq');
xlabel('Valores únicos de yq');
ylabel('Número de ocorrências');

figure(2)
bar(pmf_yq)
title('Funcao densidade de probabilidade de yq');
xlabel('Valores únicos de yq');
ylabel('Probabilidade');

figure(3)
hist(ydifq, ydifq_unique)
title('Histograma da variável ydifq');
xlabel('Valores únicos de ydifq');
ylabel('Número de ocorrências');

figure(4)
bar(pmf_ydifq)
title('Funcao densidade de probabilidade de ydfiq');
xlabel('Valores únicos de ydifq');
ylabel('Probabilidade');

% As funções densidade de probabilidade estão relacionadas com os
% histogramas, visto as funções densidade de probabilidade serem o
% resultado dos histogramas a dividir pelo número total de ocorrências

%% Ex 3

% Ordenar de forma decrescente os índices da probability mass function
[yqSorted, yqIdx] = sort(pmf_yq, 'descend');

% Probabilidade dos símbolos mais prováveis
symProb = yqSorted(1:8);

% Condiserando que só vão ser guardados os 8 simbolos mais prováveis e os
% restantes, se ocorrerem, são descartados, não é preciso normalizar a
% função densidade de probabilidade. O número de bits é dado pelo
% somatório da probabilidade de ocorrer cada sequencia de bits multiplicado
% pelo número de símbolos total
NbitsA = sum(3 * symProb) * length(yq)
NbitsB = sum( (1:8) * symProb) * length(yq)
NbitsC = sum( (8:-1:1) * symProb) * length(yq)


% Número de bits médio- Número de bits totais com o código escolhido a
% dividir pelo número de simbolos que vão ser codificados (não pode ser só
% length(yq) porque existem símbolos que vão ser descartados)
NbitsMeanA = NbitsA / sum(length(yq) * symProb)
NbitsMeanB = NbitsB / sum(length(yq) * symProb)
NbitsMeanC = NbitsC / sum(length(yq) * symProb)

% O código mais eficiente para transmitir yq é o código A, pois é o que
% permite usar menos bits por símbolo a transmitir

%% Ex 4

% Ordenar de forma decrescente os índices da probability mass function
[ydifqSorted, ydifqIdx] = sort(pmf_ydifq, 'descend');

% Probabilidade dos símbolos mais prováveis
symProb = ydifqSorted(1:8);

% Condiserando que só vão ser guardados os 8 simbolos mais prováveis e os
% restantes, se ocorrerem, são descartados, não é preciso normalizar a
% função densidade de probabilidade. O número de bits é dado pelo
% somatório da probabilidade de ocorrer cada sequencia de bits multiplicado
% pelo número de símbolos total
NbitsA = sum(3 * symProb) * length(ydifq)
NbitsB = sum( (1:8) * symProb) * length(ydifq)
NbitsC = sum( (8:-1:1) * symProb) * length(ydifq)


% Número de bits médio- Número de bits totais com o código escolhido a
% dividir pelo número de simbolos que vão ser codificados (não pode ser só
% length(yq) porque existem símbolos que vão ser descartados)
NbitsMeanA = NbitsA / sum(length(ydifq) * symProb)
NbitsMeanB = NbitsB / sum(length(ydifq) * symProb)
NbitsMeanC = NbitsC / sum(length(ydifq) * symProb)

% O código mais eficiente para transmitir ydifq é o código B, pois é o que
% permite usar menos bits por símbolo a transmitir

% Reparamos portanto que o código mais eficiente depende da informação a
% transmitir. Além disso, ydifq pode ser enviada usando menos bits em média
% que yq
