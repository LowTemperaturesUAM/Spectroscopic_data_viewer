function [Struct] = saveStartingContrast(App, Struct)
% --------------------------------------------------------------------
% Saving preliminar contrast
% --------------------------------------------------------------------
ContrastReal = zeros(2, length(Struct.Energia));
ContrastFFT = zeros(2, length(Struct.Energia));
for i=1:length(Struct.Energia)
    ContrastReal (1,i) = App.RealMinSlider.Value;
    ContrastReal (2,i) = App.RealMaxSlider.Value;
    ContrastFFT (1,i) = App.FFTMinSlider.Value;
    ContrastFFT (2,i) = App.FFTMaxSlider.Value;
end
Struct.ContrastReal = ContrastReal;
Struct.ContrastFFT = ContrastFFT;
end