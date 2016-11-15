%% Trabalho Prático 4
clc; clear; close;

lower = 'abcdefghijklmnopqrstuvwxyz';
upper = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
punct = ['!,;.:"?-() '  sprintf('\n')];


%% Ex 1
% Abrir o ficheiro
fileID = fopen('The Adventures of Sherlock Holmes.txt');

% No caso de ocorrer um erro. O assert confirma que a condiçao e verdadeira
assert(fileID > 0, 'Erro ao abrir o ficheiro de texto!')

% Vetor que contabiliza a ocorrencia de cada letra (maiscula ou minuscula)
letters = zeros(1, length(lower));

% Ler a 1ª linha do ficheiro. Precisamos de usar fgets e nao fgetl porque
% pretendemos contar as ocorrencias do caracter '\n'
nextLine = fgets(fileID);

% enquanto existerem frases para ler
while(nextLine ~= -1)
    % contar a ocorrencia das letras
    for k = 1 : length(lower)
        letters(k) = letters(k) + sum((nextLine == lower(k)) | (nextLine == upper(k)));
    end;
    
    % Ler proxima linha
    nextLine = fgets(fileID);
end;

% fechar o ficheiro
fclose(fileID);

% função densidade de probabilidade. letters contem a ocorrencia de cada
% ketra, logo sum(letters) contem o numero total de ocorrencias
pmf = letters ./ sum(letters);

% gráfico de barras
figure(1)
bar(pmf)
title(['Letras minúsculas' sprintf('\n') 'The Adventures of Sherlock Holmes']);
xlabel('Letras');
ylabel('Probabilidade');

% Get current axes settings
h = gca;

% Definir espaçamento entre labels
h.XTick = 1:length(lower);

% Adicionar label com os caracteres
h.XTickLabel = {lower'};

%% Ex 2
% Abrir o ficheiro
fileID = fopen('The Adventures of Sherlock Holmes.txt');

% No caso de ocorrer um erro. O assert confirma que a condiçao e verdadeira
assert(fileID > 0, 'Erro ao abrir o ficheiro de texto!')

% Vetores para contabilizar a ocorrencia de minusculas, maisculas e
% simbolos
minusculas = zeros(1, length(lower));
maisculas = zeros(1, length(upper));
simbolos = zeros(1, length(punct));

% Ler a 1ª linha do ficheiro. Precisamos de usar fgets e nao fgetl porque
% pretendemos contar as ocorrencias do caracter '\n'
nextLine = fgets(fileID);

% enquanto existerem frases para ler
while(nextLine ~= -1)
    % Contar a ocorrencia de minusculas, maisculas e simbolos
    for k = 1 : length(lower)
        minusculas(k) = minusculas(k) + sum(nextLine == lower(k));
        maisculas(k) = maisculas(k) + sum(nextLine == upper(k));
        
        % Como existem menos simbolos que letras, é necessário proteger
        if(k <= length(punct))
            simbolos(k) = simbolos(k) + sum(nextLine == punct(k));
        end;
    end;
    
    % Ler proxima linha
    nextLine = fgets(fileID);
end;

% fechar o ficheiro
fclose(fileID);

% função densidade de probabilidade. minusculas contem a ocorrencia de cada
% letra minuscula, logo sum(minusculas) contem o numero total de letras
% minusculas. O mesmo e valido para os outros vetores
pmfMinusculas = minusculas ./ sum(minusculas);
pmfMaisculas = maisculas ./ sum(maisculas);
pmfSimbolos = simbolos ./ sum(simbolos);

% gráfico de barras
figure(2)
subplot(311);
bar(pmfMinusculas)
title('The Adventures of Sherlock Holmes');
xlabel('Letras Minúsculas');
ylabel('Probabilidade');
h = gca;                    % Get current axes settings
h.XTick = 1:length(lower);  % Definir espaçamento entre labels
h.XTickLabel = {lower'};    % Adicionar label com os caracteres

subplot(312)
bar(pmfMaisculas)
title('The Adventures of Sherlock Holmes');
xlabel('Letras Maisculas');
ylabel('Probabilidade');
h = gca;                    % Get current axes settings
h.XTick = 1:length(upper);  % Definir espaçamento entre labels
h.XTickLabel = {upper'};    % Adicionar label com os caracteres

subplot(313)
bar(pmfSimbolos)
title('The Adventures of Sherlock Holmes');
xlabel('Simbolos de pontuacao');
ylabel('Probabilidade');
h = gca;                   % Get current axes settings
h.XTick = 1:length(punct); % Definir espaçamento entre labels
h.XTickLabel = {punct'};   % Adicionar label com os caracteres

% Número de caracteres do texto (soma de todos os tipos de caracteres
Ncharacters = sum(minusculas) + sum(maisculas) + sum(simbolos)

% Probability mass function dos caracteres
pmfChar = [minusculas maisculas simbolos] ./ Ncharacters;


%% Ex3
% Como o somatorio é uma operação linear, pode ser decomposto na soma dos
% somatórios para cada uma das funções de probabilidade
entropia = - sum(pmfChar .* log2(pmfChar))

% A entropia representa o número mínimo de bits necessário para
% armazenar/codificar cada símbolo pretendido

%% Ex4
% Uma forma para armazenar o ficheiro em menos bytes consiste em usar
% compressao por codificaçao (sem perda de dados)
% consultar trabalho pratico 3, parte II

% Ordenar a pmf de forma decrescente
ordered_pmfChar = sort(pmfChar, 'descend');

% Código teste 1: O símbolo mais provável possui 1 bit, o segundo mais
% provável 2, o terceiro mais provável 3, ..., o enésimo símbolo mais
% provável n bits
% 1º símbolo mais provável -> '0'
% 2º símbolo mais provável -> '10'
% 3º símbolo mais provável -> '110'
% 4º símbolo mais provável -> '1110'
% ...
% Multiplicando cada probabilidade pelo número de bits e somando, obtem-se
% o número de bits médio do código, que foi feito através do produto
% interno
nbitsCod1 = ordered_pmfChar * (1:length(ordered_pmfChar))'

% Código teste 2: Símbolo mais provável com 1 bit e todos os outros
% símbolos com 7 bits
% Símbolo mais provável -> '0'
% Outros símbolos       -> '1' + 6 bits
% 
% O número de bits médio do código obtem-se multiplicando o número de bits
% com a probabilidade de o símbolo ser codificado com esse número de bits
nbitsCod2 = 1 * ordered_pmfChar(1) + 7 * sum(ordered_pmfChar(2:end))

% Código teste 3: O 1º, 2º e 3º símbolos mais provável são codificados com
% 2 bits e os restantes símbolos são codificados com 8 bits
% 1º símbolo mais provável -> '00'
% 2º símbolo mais provável -> '01'
% 3º símbolo mais provável -> '10'
% outros                   -> '11' + 6 bits
% 
% O número de bits médio do código obtem-se multiplicando o número de bits
% com a probabilidade de o símbolo ser codificado com esse número de bits
nbitsCod3 = 2 * sum(ordered_pmfChar(1:3)) + 8 * sum(ordered_pmfChar(4:end))

% O códgio mais eficiente é o segundo, pois permite um número de bits médio
% inferior. O pior código é o 1º

% Obter o ficheiro
fileTxt = dir('The Adventures of Sherlock Holmes.txt');

% Calcular o numero de bytes esperado para o ficheiro usando a entropia
expectedFileSize = Ncharacters * entropia / 8;

% Factor de compressao: tamanho real / tamanho esperado
compressFactorTxt = fileTxt.bytes / expectedFileSize

%% Ex5
% Obter o ficheiro
fileRar = dir('The Adventures of Sherlock Holmes.txt.rar');

% Factor de compressao: tamanho real / tamanho esperado
compressFactorRar = fileRar.bytes / expectedFileSize 

% Obter o ficheiro
fileZip = dir('The Adventures of Sherlock Holmes.txt.zip');

% Factor de compressao: tamanho real / tamanho esperado
compressFactorZip = fileZip.bytes / expectedFileSize 

% A compressao obtida permite usar menos bits do que a entropia,
% obtendo-se taxas de compressao de 0.4063 para RAR e 0.4394 para ZIP.
% Podemos concluir que o formato de compressao RAR e mais eficiente que ZIP

%% Ex 6
% Abrir o ficheiro
fileID = fopen('Meditations - Marcus Aurelius.txt');

% No caso de ocorrer um erro. O assert confirma que a condiçao e verdadeira
assert(fileID > 0, 'Erro ao abrir o ficheiro de texto!')

% Vetores para contabilizar a ocorrencia de minusculas, maisculas e
% simbolos
minusculas2 = zeros(1, length(lower));
maisculas2 = zeros(1, length(upper));
simbolos2 = zeros(1, length(punct));

% Ler a 1ª linha do ficheiro. Precisamos de usar fgets e nao fgetl porque
% pretendemos contar as ocorrencias do caracter '\n'
nextLine = fgets(fileID);

% enquanto existerem frases para ler
while(nextLine ~= -1)
    % Contar a ocorrencia de minusculas, maisculas e simbolos
    for k = 1 : length(lower)
        minusculas2(k) = minusculas2(k) + sum(nextLine == lower(k));
        maisculas2(k) = maisculas2(k) + sum(nextLine == upper(k));
        
        % Como existem menos simbolos que letras, é necessário proteger
        if(k <= length(punct))
            simbolos2(k) = simbolos2(k) + sum(nextLine == punct(k));
        end;
    end;
    
    % Ler proxima linha
    nextLine = fgets(fileID);
end;

% fechar o ficheiro
fclose(fileID);

% função densidade de probabilidade. minusculas contem a ocorrencia de cada
% letra minuscula, logo sum(minusculas) contem o numero total de letras
% minusculas. O mesmo e valido para os outros vetores
pmfMinusculas2 = minusculas2 ./ sum(minusculas2);
pmfMaisculas2 = maisculas2 ./ sum(maisculas2);
pmfSimbolos2 = simbolos2 ./ sum(simbolos2);

% gráfico de barras
figure(3)
subplot(311);
bar(pmfMinusculas2)
title('Meditations - Marcus Aurelius');
xlabel('Letras Minúsculas');
ylabel('Probabilidade');
h = gca;                    % Get current axes settings
h.XTick = 1:length(lower);  % Definir espaçamento entre labels
h.XTickLabel = {lower'};    % Adicionar label com os caracteres

subplot(312)
bar(pmfMaisculas2)
title('Meditations - Marcus Aurelius');
xlabel('Letras Maisculas');
ylabel('Probabilidade');
h = gca;                    % Get current axes settings
h.XTick = 1:length(upper);  % Definir espaçamento entre labels
h.XTickLabel = {upper'};    % Adicionar label com os caracteres

subplot(313)
bar(pmfSimbolos2)
title('Meditations - Marcus Aurelius');
xlabel('Simbolos de pontuacao');
ylabel('Probabilidade');
h = gca;                   % Get current axes settings
h.XTick = 1:length(punct); % Definir espaçamento entre labels
h.XTickLabel = {punct'};   % Adicionar label com os caracteres

% Número de caracteres do texto (soma de todos os tipos de caracteres
Ncharacters2 = sum(minusculas2) + sum(maisculas2) + sum(simbolos2)

% A função de distribuição de probabilidade é bastante semelhante,
% evidenciando que aumentando o número de livros/tamanho dos mesmos, se
% tenderia para uma função de probabilidade geral

%% Ex 7 - Usando o 1º Livro
% Esta implementação calcula o número de caracteres necessários para obter
% a probabilidade pretendida e grava a sequencia de caracteres num vetor.
% Para introduzir a aleatoriedade, efetua um shuffle no fim

% Número de caracteres a gerar
Nchar = 1e6;

% Look Up Table com os characteres pretendidos (letras e whitespace)
charLUT = [lower upper ' '];

% Pmf conjunta das letras minusculas, maisculas e do caracter espaço
characters = [minusculas maisculas simbolos(punct == ' ')];
pmfRnd = characters ./ sum(characters);

% O número de caracteres a gerar de cada tipo, arredondados às unidades
NcharPerType = round(pmfRnd * Nchar);

% Vetor para guardar o texto aleatório
rndTxt = zeros(1, sum(NcharPerType));

% Variáveis de controlo dos indices
startIdx = 1;
endIdx = 0;

% Para cada caracter
for k = 1 : length(characters)
    % O indice onde termina é o índice seguinte onde terminou no ciclo
    % anterior somado ao número de ocorrências do caracter que se pretende
    % colocar a seguir
    endIdx = endIdx  + 1 + NcharPerType(k);
    
    % entre os indices pretendidos, adicionar o caracter desejado
    rndTxt(startIdx : endIdx) = charLUT(k);
    
    % O indice onde começa é o índice seguinte onde terminou
    startIdx = endIdx + 1;
end;

% Abrir o ficheiro com permissões de escrita
fileID = fopen('Random Text.txt', 'w');

% No caso de ocorrer um erro. O assert confirma que a condiçao e verdadeira
assert(fileID > 0, 'Erro ao abrir/criar o ficheiro de texto!')

% Shuffle ao texto
rndTxt = rndTxt(randi(length(rndTxt), 1, length(rndTxt)));

% Impimir caracter a caracter para o ficheiro de texto
fprintf(fileID, '%c%c%c%c%c%c%c%c%c%c%c%c', rndTxt);

% Fechar o ficheiro
fclose(fileID);

%% Ex 7 - Alternativa (melhor que a primeira) - Usando o 1º livro
% Usando os calculos da pmf do algoritmo anterior, esta função calcula a
% função densidade acumulada e mapeia a distribuição uniforme entre [0, 1[
% para os caracteres contidos na LUT

% Função densidade acumulada
pafRnd = cumsum(pmfRnd);

% Gerar números aleatórios 
randomNum = rand(1, Ncharacters);

% Alocar espaço para o texto
randomTxt = zeros(1, Ncharacters);

% Para cada número aleatório, verificar onde fica mapeado e atribuir o
% caracter correspondnete
for k = 1 : Ncharacters
    % indice que identifica o caracter. O indice corresponde ao primeiro
    % valor onde a probabilidade acumulada é menor que a próxima, e usa
    % esse indice para indexar a LUT de caracteres, obtendo o caracter
    % correspondente ao número aleatório
    randomTxt(k) = charLUT( find(randomNum(k) < pafRnd, 1, 'first') );
end;

% Abrir o ficheiro com permissões de escrita
fileID = fopen('Random Text 2.txt', 'w');

% No caso de ocorrer um erro. O assert confirma que a condiçao e verdadeira
assert(fileID > 0, 'Erro ao abrir/criar o ficheiro de texto!')

% Impimir caracter a caracter para o ficheiro de texto
fprintf(fileID, '%c%c%c%c%c%c%c%c%c%c%c%c', randomTxt);

% Fechar o ficheiro
fclose(fileID);

%% Usando o algoritmo dos exercícios anteriores para verificar

% Ficheiro para verificar
txtFile = 'Random Text 2.txt';

% Abrir o ficheiro
fileID = fopen(txtFile);

% No caso de ocorrer um erro. O assert confirma que a condiçao e verdadeira
assert(fileID > 0, 'Erro ao abrir o ficheiro de texto!')

% Vetores para contabilizar a ocorrencia de minusculas, maisculas e
% simbolos
minusculasRnd = zeros(1, length(lower));
maisculasRnd = zeros(1, length(upper));
simbolosRnd = zeros(1, length(punct));

% Ler a 1ª linha do ficheiro. Precisamos de usar fgets e nao fgetl porque
% pretendemos contar as ocorrencias do caracter '\n'
nextLine = fgets(fileID);

% enquanto existerem frases para ler
while(nextLine ~= -1)
    % Contar a ocorrencia de minusculas, maisculas e simbolos
    for k = 1 : length(lower)
        minusculasRnd(k) = minusculasRnd(k) + sum(nextLine == lower(k));
        maisculasRnd(k) = maisculasRnd(k) + sum(nextLine == upper(k));
        
        % Como existem menos simbolos que letras, é necessário proteger
        if(k <= length(punct))
            simbolosRnd(k) = simbolosRnd(k) + sum(nextLine == punct(k));
        end;
    end;
    
    % Ler proxima linha
    nextLine = fgets(fileID);
end;

% fechar o ficheiro
fclose(fileID);

% função densidade de probabilidade. minusculas contem a ocorrencia de cada
% letra minuscula, logo sum(minusculas) contem o numero total de letras
% minusculas. O mesmo e valido para os outros vetores
pmfMinusculasRnd = minusculasRnd ./ sum(minusculasRnd);
pmfMaisculasRnd = maisculasRnd ./ sum(maisculasRnd);
pmfSimbolosRnd = simbolosRnd ./ sum(simbolosRnd);

% gráfico de barras
figure(4)
subplot(311);
bar(pmfMinusculasRnd)
title('Random text');
xlabel('Letras Minúsculas');
ylabel('Probabilidade');
h = gca;                    % Get current axes settings
h.XTick = 1:length(lower);  % Definir espaçamento entre labels
h.XTickLabel = {lower'};    % Adicionar label com os caracteres

subplot(312)
bar(pmfMaisculasRnd)
title('Random text');
xlabel('Letras Maisculas');
ylabel('Probabilidade');
h = gca;                    % Get current axes settings
h.XTick = 1:length(upper);  % Definir espaçamento entre labels
h.XTickLabel = {upper'};    % Adicionar label com os caracteres

subplot(313)
bar(pmfSimbolosRnd)
title('Random text');
xlabel('Simbolos de pontuacao');
ylabel('Probabilidade');
h = gca;                   % Get current axes settings
h.XTick = 1:length(punct); % Definir espaçamento entre labels
h.XTickLabel = {punct'};   % Adicionar label com os caracteres

% Número de caracteres do texto (soma de todos os tipos de caracteres
NcharactersRnd = sum(minusculasRnd) + sum(maisculasRnd) + sum(simbolosRnd);

% A função de distribuição de probabilidade do texto aleatório é muito
% parecida com a função distribuição de probabilidade obtida para o livro
% de The Adventures of Sherlock Holmes, onde foi baseada
