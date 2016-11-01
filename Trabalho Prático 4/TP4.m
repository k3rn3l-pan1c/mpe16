%% Trabalho Prático 4
clc; clear; close;

lower = ['abcdefghijklmnopqrstuvwxyz'];
upper = ['ABCDEFGHIJKLMNOPQRSTUVWXYZ'];
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

%% Ex3
% Como o somatorio é uma operação linear, pode ser decomposto na soma dos
% somatórios para cada uma das funções de probabilidade
entropia = -sum(pmfMaisculas .* log2(pmfMaisculas)) ...
           - sum(pmfMinusculas .* log2(pmfMinusculas)) ...
           - sum(pmfSimbolos .* log2(pmfSimbolos))

% A entropia representa o número mínimo de bits necessário para
% armazenar/codificar cada símbolo pretendido

%% Ex4
% Uma forma para armazenar o ficheiro em menos bytes consiste em usar
% compressao por codificaçao (sem perda de dados)
% consultar trabalho pratico 3, parte II

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
figure(3)
subplot(311);
bar(pmfMinusculas)
title('Meditations - Marcus Aurelius');
xlabel('Letras Minúsculas');
ylabel('Probabilidade');
h = gca;                    % Get current axes settings
h.XTick = 1:length(lower);  % Definir espaçamento entre labels
h.XTickLabel = {lower'};    % Adicionar label com os caracteres

subplot(312)
bar(pmfMaisculas)
title('Meditations - Marcus Aurelius');
xlabel('Letras Maisculas');
ylabel('Probabilidade');
h = gca;                    % Get current axes settings
h.XTick = 1:length(upper);  % Definir espaçamento entre labels
h.XTickLabel = {upper'};    % Adicionar label com os caracteres

subplot(313)
bar(pmfSimbolos)
title('Meditations - Marcus Aurelius');
xlabel('Simbolos de pontuacao');
ylabel('Probabilidade');
h = gca;                   % Get current axes settings
h.XTick = 1:length(punct); % Definir espaçamento entre labels
h.XTickLabel = {punct'};   % Adicionar label com os caracteres

% Número de caracteres do texto (soma de todos os tipos de caracteres
Ncharacters = sum(minusculas) + sum(maisculas) + sum(simbolos)

% A função de distribuição de probabilidade é bastante semelhante,
% evidenciando que aumentando o número de livros/tamanho dos mesmos, se
% tenderia para uma função de probabilidade geral

%% Ex 7

% Número de caracteres a gerar
Nchar = 1e6;

% Vetor com os characteres pretendidos - considerar só letras e espaços
charLUT = [lower upper ' '];

% Pmf conjunta das letras minusculas, maisculas e do caracter espaço
characters = [minusculas maisculas simbolos(punct == ' ')];
pmf = characters ./ sum(characters);

% O número de caracteres a gerar de cada tipo, arredondados às unidades
NcharPerType = round(pmf * Nchar);

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



%% Usando o algoritmo dos exercícios anteriores

% Abrir o ficheiro
fileID = fopen('Random Text.txt');

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
characters = sum(minusculasRnd) + sum(maisculasRnd) + sum(simbolosRnd);

% A função de distribuição de probabilidade do texto aleatório é muito
% parecida com a função distribuição de probabilidade obtida para o livro
% de Marcus Aurelius, onde foi baseada
