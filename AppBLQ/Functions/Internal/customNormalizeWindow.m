function out = customNormalizeWindow
% Create a window to input limits for Normalization of curves, as well as
% number of sides considered.
%
%OUTPUT-------------------
% Struct containing parameters in Fields:
%
%

fig = uifigure("WindowStyle",'modal','Name','Normalization Parameters');
fig.Position(3:4) = [350,150];
movegui(fig,'onscreen');

rpos = fig.Position(3);
hrow = 50;
toprow = fig.Position(4)-hrow;
fieldSize = [80 20];
txtSize = [80 20];

% Consrtuct figure
bg = uibuttongroup(fig,'Position',[30 toprow-1*hrow txtSize.*[1.4 4]]);
b1 = uiradiobutton(bg,'Position',[10 bg.Position(4)-hrow/2 txtSize], ...
    'Text','Both Sides');
b2 = uiradiobutton(bg,'Position',[10 bg.Position(4)-2*hrow/2 txtSize], ...
    'Text','Single Side');
b3 = uiradiobutton(bg,'Position',[10 bg.Position(4)-3*hrow/2 txtSize], ...
    'Text','None',Value=true);

editVInferior = uieditfield(fig,'numeric','Position',[rpos-100 toprow fieldSize],...
    HorizontalAlignment='center',Tag='CorteSuperior');
uilabel(fig,'Position',[bg.Position(1)+bg.Position(3)+20 toprow txtSize],...
    'Text', 'From:');

editVSuperior = uieditfield(fig,'numeric','Position',[rpos-100 toprow-hrow fieldSize],...
    HorizontalAlignment='center',Tag='CorteSuperior');
uilabel(fig,'Position',[bg.Position(1)+bg.Position(3)+20 toprow-hrow txtSize],...
    'Text', 'To:');

uibutton(fig,'Position',[120 10 100 30],'Text','Continue',...
    'ButtonPushedFcn','uiresume(gcbf)',BackgroundColor=[0.78,0.96,0.55],...
    FontWeight='bold',FontSize=14);

% Initialize output
out = struct();

% make figure wait until pushing Confirm
uiwait(fig);

id = [b1 b2 b3];
id = [id.Value];
opts = ["both", "single","none"];

if ishghandle(fig) % In case preemptively closed figure
    out.VNormInferior = min([editVInferior.Value editVSuperior.Value]);
    out.VNormSuperior = max([editVInferior.Value editVSuperior.Value]);
    out.Range = opts(id);

    close(fig)
else
    out = 0;
    return
end

end