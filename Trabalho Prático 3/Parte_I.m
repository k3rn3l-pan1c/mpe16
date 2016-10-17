%% Parte I
clear; clc; close all;

N = 512;
load trab03.mat;    % é criada a variável y
figure(1)

% Imagesc -> Scale data and display as image
% reshape(X, M, N) -> Returns the M-by-N matrix whose elemwnts are taken
% columnwise form X
imagesc(reshape(y, N, N));

colormap(gray);     % Set colormap as gray
colorbar            % Enable colorbar

% Set colormap as default
colormap('default')
%% Exercício 1 - Alínea a)

% valores únicos de y
y_unique = length(unique(y));
fprintf('Existem %d valores diferentes(símbolos) na variável y\n', y_unique);

% % Alternativamente
% y_ord = sort(y);
% yd = diff(y - y_ord);
% n_vals = sum(yd ~= 0);

% Histograma de y centrado nos valores unicos do vetor de dados
figure(1)
hist(y, unique(y));
title('Histograma de y');
xlabel('Valores únicos contidos no vetor y');
ylabel('Frequência absoluta');

%% Alínea b)

% Número de bits necessários
N_bits = log2(y_unique)

%% Exercício 2 - Alínea a) e b)
% Remoção da componente DC do sinal
y_dc = mean(y);
y_ac = y - y_dc;

% Potencia do sinal
Ps = sum(abs(y_ac).^2) / length(y_ac);

% Valores de SNR lineares
SNR_linear = [1 5 10 15 20 30 40 70 100];

% Alocar
SNR_dB_esperada = zeros(1, length(SNR_linear));
SNR_dB_experimental = zeros(1, length(SNR_linear));
 
for k = 1 : length(SNR_linear)
    
    % Ruído Gaussiano Branco
    noise = wgnoise(y_ac, SNR_linear(k));
    
    % Trasmissão por canal ruidoso
    y_tx = y_ac + noise;
    
    % Filtragem no recetor
    y_filter = round(y_tx);
    
    % Valor de SNR
    SNR_dB_esperada(k) = 10*log10(SNR_linear(k));
    SNR_dB_experimental(k) = 10*log10(Ps / var(noise));
    
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

% Converter os valores em decimal para binário com 8 bits
y_bin = de2bi(y, 8, 'left-msb');

% Converter os valores decimais unipolares para bipolares
y_bin = 2 * y_bin - 1;

% % Alternativamente
% % dec2bin converte cada elemento de y num string de 0 e 1
% binary_string = dec2bin(y, 8);
% % Converter a string em nºs
% binary_data = rem(double(binary_string), 2);
% % conversão para polar
% balanced_binary = 2 * binary_data - 1;

% Potencia do sinal binário a transmitir
Py_bin = sum(sum(abs(y_bin).^2)) / numel(y_bin)


for k = 1 : length(SNR_linear)
    
    % Ruído Gaussiano Branco
    noise = wgnoise(y_bin, SNR_linear(k));
    
    % Trasmissão por canal ruidoso
    y_tx = y_bin + noise;
    
    % Filtragem no recetor
    y_bin_filter = y_tx > 0;
    
    % Conversão para decimal
    y_dec_rx = y_bin_filter * [128 64 32 16 8 4 2 1]';
    
    % Valor de SNR
    SNR_dB_esperada(k) = 10*log10(SNR_linear(k)); 
    Pnoise = var(noise);    % Potencia do ruído
    SNR_dB_experimental(k) = 10*log10(Py_bin / Pnoise(1));

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
% Diferenças consecutivas entre os elementos adjacentes do vetor y
% O diff produz uma matriz com n-1 elementos, onde n é a length(y), por
% isso deve-se concatenar para adicionar mas um elemento e obter ydiff com
% n elementos
ydiff = diff([0; y]);

% Histograma 
figure(2 * length(SNR_linear) + 2);
histogram(ydiff, unique(ydiff))
title('Histograma das diferenças consecutivas do sinal y');
ylabel('Frequencia absoluta');
xlabel('Valores das diferenças consecutivas');

%% Alínea b)
% Existem mais valores únicos para serem transmitidos, mas a frequencia
% absoluta é muito mais concentrada do que a do sinal y. A transmissão é
% de elementos mais proximos de 0, sendo os símbolos não uniformemente
% distribuidos. A desvantagem é que se existir um erro num valor, todos os
% outros elementos a jusante terão erros

%% Exercício 5 - Alínea a)

% Número de bits a considerar na filtragem
n = 7 : -1 : 4;

% Parametros do filtro IIR
a = [1 -1];
b = 1;

for k = n
    % Quantizar para k bits (remover os n bits menos significativos)    
    yq = floor(y / 2^(8 - k));
    
    % Diferenças consecutivas (é necessário concatenar um elemento no
    % início para obter o valor do 1º elemento -> condição inicial do
    % filtro das diferenças consecutivas é o elemento 0 (garantir
    % causalidade))
    ydifq = diff([0 ; yq]);
    
    % Offset ás diferenças consecutivas para obter só valores positivos
    % para converter para binário
    offset = abs(min(ydifq));
    ydifq_offset = ydifq + offset;
    
    % Codificação para binário - converter os valores em decimal para
    % binário com k bits. O sinal resultante das diferenças consecutivas
    % necessita de mais 1 bit do que o sinal original, logo k+1
    ydifq_bin = de2bi(ydifq_offset, k+1, 'left-msb');
    
    % Converter de ook para bpsk
    ydifq_bpsk = 2 * ydifq_bin - 1;
    
    % Filtragem do sinal com sem ruído
    yclean = filter(b, a, ydifq);
    
    % Potencia do sinal 
    Ps = sum(sum(abs(ydifq_bpsk).^2)) / numel(ydifq_bpsk);
    
    % Adicionar ruído analógico para o sinal quantizado
    for kk = 1 : length(SNR_linear)
        
        % Ruído Gaussiano branco para a SNR desejada
        noise = wgnoise(ydifq_bpsk, SNR_linear(kk));
        
        % Sinal a transmitir - Diferenças consecutivas do sinal decimal 
        % codificado em bpsk com ruído analógico 
        ydifq_tx = ydifq_bpsk + noise;
        
        % Recetor - remoção do ruído analógico
        ydifq_rx = round(ydifq_tx);
        
        % Recetor - Conversão para binário
        ydifq_bin_rx = ydifq_rx > 0;
        
        % Conversão para decimal
        ydec_rx = ydifq_bin_rx * (2.^(k:-1:0))';
        
        % Remover o offset
        ydec_rx = ydec_rx - offset;
        
        % Matched filter do transmissor -> Reconstruir o sinal yq
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

% A técnica de codificação apresentada só funciona para SNR muito elevedas,
% porque basta um erro num bit para a descodificação dos restantes ficar
% severamente afetada. Um erro num bit implica um erro em todos os bits a
% jusante, pois no processo de filtragem (que desfaz a operação do
% cálculo das diferenças sucessivas) irá obter um valor no bit erróneo
% diferente do esperado, e em seguida propaga esse erro para os
% restantes através da realimentação do filtro
