function generateInfo(App, Struct)

App.CallingApp.InfoStruct.Transformadas                = Struct.Transformadas;
App.CallingApp.InfoStruct.MapasConductancia            = Struct.MapasConductancia;
App.CallingApp.InfoStruct.DistanciaFourierColumnas     = Struct.DistanciaFourierColumnas;
App.CallingApp.InfoStruct.DistanciaFourierFilas        = Struct.DistanciaFourierFilas;
App.CallingApp.InfoStruct.DistanciaColumnas            = Struct.DistanciaColumnas;
App.CallingApp.InfoStruct.DistanciaFilas               = Struct.DistanciaFilas;
App.CallingApp.InfoStruct.Energia                      = Struct.Energia;
App.CallingApp.InfoStruct.TamanhoRealColumnas          = Struct.TamanhoRealColumnas;
App.CallingApp.InfoStruct.TamanhoRealFilas             = Struct.TamanhoRealFilas;
App.CallingApp.InfoStruct.ParametroRedColumnas         = Struct.ParametroRedColumnas;
App.CallingApp.InfoStruct.ParametroRedFilas            = Struct.ParametroRedFilas;
App.CallingApp.InfoStruct.MatrizCorriente              = Struct.MatrizCorriente;
App.CallingApp.InfoStruct.MatrizNormalizada            = Struct.MatrizNormalizada;
App.CallingApp.InfoStruct.PuntosDerivada               = Struct.PuntosDerivada;
App.CallingApp.InfoStruct.Voltaje                      = Struct.Voltaje;
App.CallingApp.InfoStruct.Bias                         = App.CallingApp.InfoStruct.Voltaje(1);
App.CallingApp.InfoStruct.Colormap                     = eval(App.FFTColormapDropDown.Value);
App.CallingApp.InfoStruct.ColormapName                 = app.RealColormapDropDown.Value;

App.CallingApp.InfoStruct.XLimReal                     = [Struct.DistanciaColumnas(1) Struct.DistanciaColumnas(end)];
App.CallingApp.InfoStruct.YLimReal                     = [Struct.DistanciaFilas(1) Struct.DistanciaFilas(end)];
App.CallingApp.InfoStruct.XLimFFT                      = [Struct.DistanciaFourierColumnas(1) Struct.DistanciaFourierColumnas(end)];
App.CallingApp.InfoStruct.YLimFFT                      = [Struct.DistanciaFourierFilas(1) Struct.DistanciaFourierFilas(end)];


ContrastReal = zeros(2, length(Struct.Energia));
ContrastFFT = zeros(2, length(Struct.Energia));
for i=1:length(Struct.Energia)
    ContrastReal (1,i) = App.RealMinSlider.Value;
    ContrastReal (2,i) = App.RealMaxSlider.Value;
    ContrastFFT (1,i) = App.FFTMinSlider.Value;
    ContrastFFT (2,i) = App.FFTMaxSlider.Value;
end

App.CallingApp.InfoStruct.ContrastReal                  = ContrastReal;
App.CallingApp.InfoStruct.ContrastFFT                   = ContrastFFT;


App.CallingApp.MagneticFieldLabel.Visible = true;
App.CallingApp.MagneticFieldValue.Visible = true;
App.CallingApp.MagneticFieldValue.Text = [num2str(Struct.Campo), ' T'];
App.CallingApp.TemperatureLabel.Visible = true;
App.CallingApp.TemperatureValue.Visible = true;
App.CallingApp.TemperatureValue.Text = [num2str(Struct.Temperatura), ' K'];
App.CallingApp.CurrentblqLabel.Visible = true;
App.CallingApp.CurrentblqName.Visible = true;
App.CallingApp.CurrentblqName.Text = Struct.FileName;

msgbox('InfoStruct succesfully generated.','Well done','help')
end