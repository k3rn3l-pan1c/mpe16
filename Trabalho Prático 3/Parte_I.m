%% Parte I
clear; clc; close all;

N = 512;            % Número de elementos da matrix a ser criada
load trab03.mat;    % é criada a variável y

% Após dividir o vetor y numa matriz de NxN elementos, converter os dados
% obtidos de modo a usar todo o colormap disponível e em seguida mostrar a
% imagem
figure(1)
imagesc(reshape(y, N, N));
colormap(gray);     % Definir o colormap como tons de cinza
colorbar            % Ativar a colorbar


%% Exercício 1 - Alínea a)
% Quantos valores diferentes (símbolos) tem a variável y?

% valores únicos de y
y_unique = length(unique(y));
fprintf('Método 1 - Existem %d valores diferentes(símbolos) na variável y\n', y_unique);

% Histograma de y centrado nos valores unicos existentes em y
figure(1)
hist(y, unique(y));
title('Histograma de y');
xlabel('Valores únicos contidos no vetor y');
ylabel('Frequência absoluta');

%% Alternativamente:

% Ordenar o vetor y
y_ord = sort(y);     

% Diferenças consecutivas entres os elementos (serão 0 sempre que elementos
% adjacentes sejam iguais)
yd = diff(y_ord);

% Somar todos os valores de yd diferentes de 0
n_vals = sum(yd ~= 0) + 1;

fprintf('Método 2 - Existem %d valores diferentes(símbolos) na variável y\n', n_vals);

%% Alínea b)
% De quantos bits necessita para representar os dados contidos em y?
N_bits = log2(y_unique)

%% Exercício 2 
% A imagem representada pela variável y deve ser transmitida por um canal
% ruidoso que introduz ruído aditivo Gaussiano de média nula e desvio
% padrão sigma, ou seja, as amostras do sinal y_rx_n, para n = 1, 2, ...,
% vem dadas por:
%       y_rx_n = y_tx_n + w_n, n = 1, 2, ...
% Onde y_tx_n, n = 1, 2, ..., são as amostras à saída do emissor e w_n as
% amostras do ruído que se somam ao sinal transmitido
%
% (a) Esboce um programa que:
%   1 -> Retire a componente DC, ou seja, que centre a variável em 0 (numa
%   transmissão não se deve perder potencia a enviando sinais DC);
%   2 -> Some ruído Gaussiano com média nula e desvio padrão sigma, o que
%   pode ser feito usando a função randn
%   3 -> Regenere os símbolos transmitidos, i.e., com base ma observação do
%   símbolo corrompido por ruído escolha o símbolo mais próximo (pode usar
%   a função round)
%   4 -> Calcule a relação entre a potência do sinal transmitido e a potência
%   do ruído (SNR)
%   5 -> Reconstrua a imagem e mostre que pode usar o comando:
%   imagesc(reshape(sinal_regenerado, N, N))
%
% (b) Corra o programa para uns 4-5 valores de SNR entre 100 e 1 (20 a 0
%     dB) e relacione a qualidade de imagem reconstruída com SNR
%

% 1. Remoção da componente DC do sinal
y_dc = mean(y);
y_ac = y - y_dc;

% Potencia do sinal
Ps = sum(abs(y_ac).^2) / length(y_ac);

% Valores de SNR lineares
SNR_linear = [1 5 10 15 20 30 40 70 100];

% Alocar memória
SNR_dB_esperada = zeros(1, length(SNR_linear));
SNR_dB_experimental = zeros(1, length(SNR_linear));

for k = 1 : length(SNR_linear)
    
    % 2. Ruído Gaussiano Branco
    noise = wgnoise(y_ac, SNR_linear(k));
    
    % Trasmissão por canal ruidoso
    y_tx = y_ac + noise;
    
    % 3. Filtragem no recetor
    y_filter = round(y_tx);
    
    % 4. Valor de SNR
    % Esperada -> conversão da SNR linear para dB
    % Experimental -> usa a potencia do sinal e a variancia do ruido
    SNR_dB_esperada(k) = 10*log10(SNR_linear(k));
    SNR_dB_experimental(k) = 10*log10(Ps / var(noise));
    
    % 5. Reconstrução da imagem
    % Imagem original
    figure(1+k)
    subplot(121)
    imagesc(reshape(y, N, N));
    colormap(gray);
    colorbar
    title('Imagem Original');
    
    % Imagem com ruído
    subplot(122)
    imagesc(reshape(y_filter, N, N))
    colormap(gray);
    colorbar
    title(['TX - DEC : Imagem com SNR_{linear}= ' num2str(SNR_linear(k))]);
end;

% Tabela de SNR's
T = table(SNR_linear' ,SNR_dB_esperada', SNR_dB_experimental', 'VariableNames', ...
    {'SNR_linear', 'SNR_dB_esperada', 'SNR_dB_experimental'})

%% Exercício 3
% Converta para binário a variável y (e no recetor tem de converter
% novamente para decimal) e repita o exercício 2
% Neste caso, os dados binários deverão ser polares (-1 e 1) o que dá uma
% potência de 1 e consequentemente os valores de ruído têm de ser ajustados
% 
% Para converter uma sequência decimal para binária pode usar o seguinte
% código:
% % n -> nº de bits usado na representação dos elementos de y
% % dec2bin converte cada elemento de y numa string de 0 e 1
% binary_string = dec2bin(y, 8)
% % converte string em nºs
% binary_data = rem(double(binary_string), 2);
% % conversão para polar
% balanced_binary_data = 2*binary_data - 1;
%

% Converter os valores em decimal para binário com 8 bits
y_bin = de2bi(y, 8, 'left-msb');

% Converter os valores decimais unipolares para bipolares
y_bin = 2 * y_bin - 1;

% Alternativamente
% dec2bin converte cada elemento de y num string de 0 e 1
binary_string = dec2bin(y, 8);
% Converter a string em nºs
binary_data = rem(double(binary_string), 2);
% conversão para polar
balanced_binary = 2 * binary_data - 1;

% Potencia do sinal binário a transmitir
Py_bin = sum(sum(abs(y_bin).^2)) / numel(y_bin)

% Não é necessário remover a componente DC porque o sinal já se encontra
% centrado em 0 (é polar)
for k = 1 : length(SNR_linear)
    
    % 2. Ruído Gaussiano Branco
    noise = wgnoise(y_bin, SNR_linear(k));
    
    % Trasmissão por canal ruidoso
    y_tx = y_bin + noise;
    
    % 3. Filtragem no recetor (Remoçao de ruído e conversão de polar para
    % binário)
    y_bin_filter = y_tx > 0;
    
    % Conversão para decimal
    y_dec_rx = y_bin_filter * [128 64 32 16 8 4 2 1]';
    
    % 4. Valor de SNR
    % Esperada -> conversão da SNR linear para dB
    % Experimental -> usa a potencia do sinal e a variancia do ruido
    SNR_dB_esperada(k) = 10*log10(SNR_linear(k)); 
    Pnoise = var(noise);    % Potencia do ruído
    SNR_dB_experimental(k) = 10*log10(Py_bin / Pnoise(1));
    
    % 5. Reconstrução da imagem
    % Imagem original
    figure(1 + length(SNR_linear) + k)
    subplot(121)
    imagesc(reshape(y, N, N));
    colormap(gray);
    colorbar
    title('Imagem Original');
    
    % Imagem com ruído
    subplot(122)
    imagesc(reshape(y_dec_rx, N, N))
    colormap(gray);
    colorbar
    title(['TX- BIN : Imagem com SNR_{linear}= ' num2str(SNR_linear(k))]);
end;

% Tabela de SNR's
T = table(SNR_linear' ,SNR_dB_esperada', SNR_dB_experimental', 'VariableNames', ...
    {'SNR_linear', 'SNR_dB_esperada', 'SNR_dB_experimental'})

%% Exercício 4 - Alinea a)
% Considere uma nova variável ydiff = diff(y)
% (a) Faça o histograma de ydif e compare com o histograma de y. Explique,
% qualitativamente as diferenças

% A função diff calcula as diferenças consecutivas entre os elementos
% adjacentes do vetor y. Assim, o resultado será sempre um vetor com menos
% 1 elemento, porque a 1ª diferenças consecutiva é o 2º elemento - 1º
% elemento. Concatenando um zero no início do vetor resolve o problema,
% tendo o vetor a diferenciar n+1 elementos e no fim da operação, n, tal
% como o vetor original
ydiff = diff([0; y]);

% Histograma 
figure(2 * length(SNR_linear) + 2);
histogram(ydiff, unique(ydiff))
title('Histograma das diferenças consecutivas do sinal y');
ylabel('Frequencia absoluta');
xlabel('Valores das diferenças consecutivas');

% Os valores estão bastante concentrados em torno de 0, ao contrário do
% histograma de y, que estavam distribuídos de forma aleatória
%% Alínea b)
% Com base nos histogramas indique se poderia ganhar alguma coisa em termos
% da quantidade de bits transmitidos usando ydif em vez de y?

% Existem mais valores únicos para serem transmitidos, mas a frequencia
% absoluta é muito mais concentrada numa gama restrita de símbolos, ao
% contrário do sinal y. A transmissão é de elementos mais proximos de 0,
% sendo os símbolos não uniformemente distribuidos, podendo com esta
% característica ser efetuada compressão do sinal a transmitir. A
% desvantagem é que se existir um erro num valor, todos os outros elementos
% a jusante do símbolo errado terão erros.

%% Exercício 5
% (a) Quantifiqe as amostra de y em 7 bits (7<n) criando uma nova variável yq.
%     Retire simplesmente os n-7 bits menos significativos
% (b) Crie a variável ydifq = diff(yq)
% (c) Codifique ydifq para binário e transmita a sequência (seguindo os
%     mesmos procedimentos de 3)
% (d) Mostre que para reconstruir a sequencia pode usar um filtro IIR 
%     H(z) = 1/(1 - z^-1)
% (e) Reconstrua a sequência yq usando a função filter e observe a imagem
%     resultante na ausência de ruído e com ruído igual aos valores usados
%     em 3 
% (f) Repita os pontos (a)...(e) para valores quantificados em 6, 5 e 4
%     bits
% (g) Deverá observar que a distorção na imagem apresenta um aspecto que ao
%     invés do caso 3 parece ser mais estruturada. Como explica isso?
%

% (f) Número de bits a considerar na filtragem
n = 7 : -1 : 4;

% Parametros do filtro IIR
a = [1 -1];
b = 1;

for k = n
    % (a) Quantizar para k bits (remover os n bits menos significativos).
    % Dividir por 2^K equivale a fazer um shift de k bits à direita,
    % removendo k bits ao número
    yq = floor(y / 2^(8 - k));
    
    % (b) Diferenças consecutivas (é necessário concatenar um elemento no
    % início para obter o valor do 1º elemento -> condição inicial do
    % filtro das diferenças consecutivas é o elemento 0 (garantir
    % causalidade))
    ydifq = diff([0 ; yq]);
    
    % Offset ás diferenças consecutivas para codificar os valores das
    % diferenças consecutivas só com número positivos, para de seguida
    % cpnverter para binário
    offset = abs(min(ydifq));
    ydifq_offset = ydifq + offset;
    
    % (c) Codificação para binário - converter os valores em decimal para
    % binário com k bits. O sinal resultante das diferenças consecutivas
    % necessita de mais 1 bit do que o sinal original, logo k+1.
    % ydifq precisa de mais um bit porque a sua amplitude é o dobro de yq
    % (possui números positivos e negativos). O offset duplica a amplitude
    % positiva e elimina a negativa
    ydifq_bin = de2bi(ydifq_offset, k+1, 'left-msb');
    
    % Converter de ook para bpsk (binário -> polar)
    ydifq_bpsk = 2 * ydifq_bin - 1;
    
    % (d) Filtragem do sinal sem ruído (Teste do filtro IIR)
    yclean = filter(b, a, ydifq);
    
    % Potencia do sinal a transmitir
    Ps = sum(sum(abs(ydifq_bpsk).^2)) / numel(ydifq_bpsk);
    
    % Adicionar ruído analógico para o sinal quantizado, para várias SNR's
    for kk = 1 : length(SNR_linear)
        
        % Ruído Gaussiano branco para a SNR desejada
        noise = wgnoise(ydifq_bpsk, SNR_linear(kk));
        
        % Sinal a transmitir - Diferenças consecutivas do sinal decimal 
        % codificado em bpsk com ruído analógico 
        ydifq_tx = ydifq_bpsk + noise;
        
        % Recetor - remoção do ruído analógico
        ydifq_rx = round(ydifq_tx);
        
        % (e) Recetor - Conversão para binário
        ydifq_bin_rx = ydifq_rx > 0;
        
        % Conversão para decimal
        ydec_rx = ydifq_bin_rx * (2.^(k:-1:0))';
        
        % Corrigir o offset efetuado às diferenças consecutivas
        ydec_rx = ydec_rx - offset;
        
        % Matched filter do transmissor (diferenças consecutivas)
        % Reconstrução o sinal yq 
        ydec_rx = filter(b, a, ydec_rx);
            
        % Imagem filtrada sem ruído
        figure
        subplot(121)
        imagesc(reshape(yclean, N, N));
        colormap(gray);
        colorbar
        title(['Imagem Quantizada sem ruído. Nº bits = ' num2str(k)]);

        % Imagem filtrada com ruído
        subplot(122)
        imagesc(reshape(ydec_rx, N, N))
        colormap(gray);
        colorbar
        title(['Imagem Quantizada com ruído.Nº bits = ' num2str(k) ', SNR = ' num2str(SNR_linear(kk))]);;
        
        % Valor de SNR
        SNR_dB_esperada(kk) = 10*log10(SNR_linear(kk)); 
        Pnoise = var(noise);    % Potencia do ruído
        SNR_dB_experimental(kk) = 10*log10(Ps / Pnoise(1));

    end;
            
    % Tabela de SNR's
    fprintf('\nTabela de SNR''s para %d bits de quantização', k);
    T = table(SNR_linear' ,SNR_dB_esperada', SNR_dB_experimental', 'VariableNames', ...
        {'SNR_linear', 'SNR_dB_esperada', 'SNR_dB_experimental'})
end;

% (g) A técnica de codificação apresentada só funciona para SNR muito
% elevadas porque basta um erro num bit para a descodificação dos restantes
% ficar severamente afetada. Um erro num bit implica um erro em todos os
% bits seguintes, pois no processo de filtragem (que desfaz a operação do
% cálculo das diferenças sucessivas) irá obter um valor no bit erróneo
% diferente do transmitido, e em seguida propaga esse erro para os
% restantes através da realimentação do filtro. Deste modo, um erro afeta
% todos os bits recebidos seguintes, pelo que a distorção na imagem
% apresenta um aspeto estruturado, ao invés do exercício 3, em que um erro
% num bit afeta só esse bit, logo a distorção é aleatória
