function detector(c1, c2, g1, g2)
% c1 e c2 são as componentes cromáticas (0 a 1) da imagem. Por exemplo, c1
% = h e c2 = s para hsv.
% g1 e g2 são as gamas de valor de pele

% Obter os índices onde a cara está contida
skin = ( (c1 > g1(1)) & (c1 < g1(2)) & (c2 > g2(1)) & (c2 < g2(2)) );

figure;         % criar uma nova figura
imagesc(skin);  % apresentar a imagem após o filtro cromático (só a cara)
colormap(gray); % Definir o mapa de cores como tons de cinza  
title('Imagem com filtragem cromática');
