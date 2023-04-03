function generateInfo(app, Struct)

app.CallingApp.InfoStruct.Transformadas                = Struct.Transformadas;
app.CallingApp.InfoStruct.Fase                         = Struct.Fase;
app.CallingApp.InfoStruct.MapasConductancia            = Struct.MapasConductancia;
app.CallingApp.InfoStruct.DistanciaFourierColumnas     = Struct.DistanciaFourierColumnas;
app.CallingApp.InfoStruct.DistanciaFourierFilas        = Struct.DistanciaFourierFilas;
app.CallingApp.InfoStruct.DistanciaColumnas            = Struct.DistanciaColumnas;
app.CallingApp.InfoStruct.DistanciaFilas               = Struct.DistanciaFilas;
app.CallingApp.InfoStruct.Energia                      = Struct.Energia;
app.CallingApp.InfoStruct.TamanhoRealColumnas          = Struct.TamanhoRealColumnas;
app.CallingApp.InfoStruct.TamanhoRealFilas             = Struct.TamanhoRealFilas;
app.CallingApp.InfoStruct.ParametroRedColumnas         = Struct.ParametroRedColumnas;
app.CallingApp.InfoStruct.ParametroRedFilas            = Struct.ParametroRedFilas;
app.CallingApp.InfoStruct.MatrizCorriente              = Struct.MatrizCorriente;
app.CallingApp.InfoStruct.MatrizNormalizada            = Struct.MatrizNormalizada;
app.CallingApp.InfoStruct.PuntosDerivada               = Struct.PuntosDerivada;
app.CallingApp.InfoStruct.Voltaje                      = Struct.Voltaje;
app.CallingApp.InfoStruct.Bias                         = app.CallingApp.InfoStruct.Voltaje(1);
app.CallingApp.InfoStruct.Colormap                     = eval(app.FFTColormapDropDown.Value);
app.CallingApp.InfoStruct.ColormapName                 = (app.FFTColormapDropDown.Value);

app.CallingApp.InfoStruct.XLimReal                     = [Struct.DistanciaColumnas(1) Struct.DistanciaColumnas(end)];
app.CallingApp.InfoStruct.YLimReal                     = [Struct.DistanciaFilas(1) Struct.DistanciaFilas(end)];
app.CallingApp.InfoStruct.XLimFFT                      = [Struct.DistanciaFourierColumnas(1) Struct.DistanciaFourierColumnas(end)];
app.CallingApp.InfoStruct.YLimFFT                      = [Struct.DistanciaFourierFilas(1) Struct.DistanciaFourierFilas(end)];
app.CallingApp.InfoStruct.Type                         = Struct.Type;
app.CallingApp.InfoStruct.Direction                    = Struct.Direction;
if isfield(Struct,'Topo')
    app.CallingApp.InfoStruct.Topo                     = Struct.Topo;
end

ContrastReal = zeros(2, length(Struct.Energia));
ContrastFFT = zeros(2, length(Struct.Energia));

ContrastReal (1,:) = app.RealMaxSlider.Limits(1);
ContrastReal (2,:) = app.RealMaxSlider.Limits(2);
ContrastFFT (1,:) = app.FFTMinSlider.Limits(1);
ContrastFFT (2,:) = app.FFTMaxSlider.Limits(2);
disp(ContrastReal(:,1))
disp(ContrastFFT(:,1))


app.CallingApp.InfoStruct.ContrastReal                  = ContrastReal;
app.CallingApp.InfoStruct.ContrastFFT                   = ContrastFFT;


app.CallingApp.MagneticFieldLabel.Visible = true;
app.CallingApp.MagneticFieldValue.Visible = true;
app.CallingApp.MagneticFieldValue.Text = [num2str(Struct.Campo), ' T'];
app.CallingApp.TemperatureLabel.Visible = true;
app.CallingApp.TemperatureValue.Visible = true;
app.CallingApp.TemperatureValue.Text = [num2str(Struct.Temperatura), ' K'];
app.CallingApp.CurrentblqLabel.Visible = true;
app.CallingApp.CurrentblqName.Visible = true;
app.CallingApp.CurrentblqName.Text = Struct.FileName;

msgbox('InfoStruct succesfully generated.','Well done','help')
end