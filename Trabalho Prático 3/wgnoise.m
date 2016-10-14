function noise = wgnoise(sigIn, linear_SNR)
% Calcula a potencia do sinal e determina a potencia do ruído para a SNR
% desejada

% Potencia do sinal
Ps = sum(abs(sigIn).^2) / length(sigIn);

% Potencia do ruído
Pr = Ps/linear_SNR;

% A potencia do ruído gaussiano branco é 
sigma = sqrt(Pr);

% Ruído Gaussiano Branco aditivo
noise = randn(size(sigIn, 1), size(sigIn, 2)) .* sigma;
