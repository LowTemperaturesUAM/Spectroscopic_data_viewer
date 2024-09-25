function out = customCurvesWindow(InfoStruct)
arguments
    InfoStruct (1,1) struct = struct();
end
% Create window for parameters to create maps from IV curves.
% Similar to what's found in customCurvesv5.m
% Can be executed without inputs to generate a window with default values.
%
%OUTPUT-------------------
% Struct containing parameters in Fields:
% NDeriv
% LowCut
% UpCut
% Emin
% Emax
% Method
% PasoMapa
% deltaE


fig = uifigure("WindowStyle",'modal','Name','Input Parameters');
fig.Position(3:4) = [350,500];
movegui(fig,'onscreen');

rpos = fig.Position(3);
hrow = 50;
toprow = fig.Position(4)-hrow;
fieldSize = [80 20];
txtSize = [140 20];

% Initialize output
out = struct();

editNDeriv = uispinner(fig,'Position',[rpos-130 toprow fieldSize], ...
    'HorizontalAlignment','center','Step',1,'Limits',[1 2048],Tag='DerivPts');
uilabel(fig,'Position',[40 toprow txtSize],'Text',"Derivative Points");

editCorteInferior = uieditfield(fig,'numeric','Position',[rpos-130 toprow-hrow fieldSize],...
    HorizontalAlignment='center',Tag='CorteInferior');
uilabel(fig,'Position',[40 toprow-hrow txtSize],...
    'Text', 'Lower limit cut:');

editCorteSuperior = uieditfield(fig,'numeric','Position',[rpos-130 toprow-2*hrow fieldSize],...
    HorizontalAlignment='center',Tag='CorteSuperior');
uilabel(fig,'Position',[40 toprow-2*hrow txtSize],...
    'Text', 'Upper limit cut:');

editEnergiaMin = uieditfield(fig,'numeric','Position',[rpos-130 toprow-4*hrow fieldSize],...
    HorizontalAlignment='center',ValueDisplayFormat='%11.4g mV',Tag='Emin');
uilabel(fig,'Position',[40 toprow-4*hrow txtSize],'Text', 'Maps from:');

editEnergiaMax = uieditfield(fig,'numeric','Position',[rpos-130 toprow-5*hrow fieldSize],...
    HorizontalAlignment='center',ValueDisplayFormat='%11.4g mV',Tag='Emax');
uilabel(fig,'Position',[40 toprow-5*hrow txtSize],...
    'Text', 'to:');

editPasoMapas = uieditfield(fig,'numeric','Position',[rpos-130 toprow-6*hrow fieldSize],...
    HorizontalAlignment='center',ValueDisplayFormat='%11.4g mV',Tag='PasoMapas');
uilabel(fig,'Position',[40 toprow-6*hrow txtSize],...
    'Text', 'Map spacing:');

editDeltaEnergia = uieditfield(fig,'numeric','Position',[rpos-130 toprow-7*hrow fieldSize],...
    HorizontalAlignment='center',ValueDisplayFormat='%11.4g mV',Tag='DeltaE');
uilabel(fig,'Position',[40 toprow-7*hrow txtSize],...
    'Text', 'ΔE:');

% Interpolation Method
methodsel = uidropdown(fig,"Items",{'Mean Window','Nearest','Linear','Makima','No Interpolation'},...
    "ItemsData",{'mean','nearest','linear','makima','none'},...
    Position = [rpos-150 toprow-3*hrow 110 20],...
    ValueChangedFcn=@(methodsel,event) changeMethod(methodsel,editDeltaEnergia,editPasoMapas));
uilabel(fig,Position =[40 toprow-3*hrow 120 20],...
    Text = 'Interpolation Method:');

uibutton(fig,'Position',[120 25 100 30],'Text','Continue',...
    'ButtonPushedFcn','uiresume(gcbf)',BackgroundColor=[0.78,0.96,0.55],...
    FontWeight='bold',FontSize=14);

% Use InfoStruct values if provided
if isfield(InfoStruct,'PuntosDerivada')
    editNDeriv.Value = InfoStruct.PuntosDerivada;
    editCorteSuperior.Value = round(max( ...
        InfoStruct.MatrizNormalizada,[],'all'),2);
    editEnergiaMin.Value = min(InfoStruct.Energia(:));
    editEnergiaMax.Value = max(InfoStruct.Energia(:));
    editPasoMapas.Value = diff(InfoStruct.Energia(1:2));
    editDeltaEnergia.Value = diff(InfoStruct.Energia(1:2));
end
% make figure wait until pushing Confirm
uiwait(fig);

% Assign values to structure output-----------------------------------
out.NDeriv = editNDeriv.Value;
out.LowCut = editCorteInferior.Value;
out.UpCut = editCorteSuperior.Value;
out.Emin = editEnergiaMin.Value;
out.Emax = editEnergiaMax.Value;
out.Method = methodsel.Value;
out.PasoMapa = editPasoMapas.Value;
out.deltaE = editDeltaEnergia.Value;


close(fig);

% Enable/Disables fields depending on interpolation selected
function  changeMethod(methodsel,editDeltaEnergia,editPasoMapas)
    method = methodsel.Value;
    switch method
        case 'mean'
            editDeltaEnergia.Enable = true;
            editPasoMapas.Enable = true;
        case 'none'
            editDeltaEnergia.Enable = false;
            editPasoMapas.Enable = false;
        otherwise
            editDeltaEnergia.Enable = false;
            editPasoMapas.Enable = true;
    end
end

end