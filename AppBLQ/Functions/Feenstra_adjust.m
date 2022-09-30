function [Struct] = Feenstra_adjust(App, Struct, Voltaje, MatrizCorriente)
% function [] = Feenstra_adjust()%(~,  ~, ~, ~)

%Assume the offset applied is correct
%Main Current smooth filter with span (in fraction) and smoothing
%method as options
%2nd smoothing pass near zero (optional). We can keep the smoothing
%area to +/-10% of the zero bias point as a reasonable guess. same
%parameters as before

% plot I/V with the given parameters to see if it diverges

% all parameters should be introduced into the app and/or struct
% but inmediately or after pressing something?

Columnas = Struct.Columnas;
Filas = Struct.Filas;
OffsetVoltajeValue = App.OffsetvoltageEditField.Value;
VoltajeEscala = App.VoltageScaleFactor.Value;
NPuntosDerivadaValue = App.DerivativepointsSpinner.Value;

VoltajeOffset = Voltaje*VoltajeEscala + OffsetVoltajeValue;



fig = uifigure('Name','Conductance Smoothing');
fig.Position(3:4) = [650,420];

grid_main = uigridlayout(fig,[1,2]);
grid_main.ColumnWidth = {200,'1x'};

p1 = uipanel(grid_main,'Title','Smoothing',BorderType='none');%,'BackgroundColor','white');
% grid2 = uigridlayout(p1,[5,2],RowHeight={22,22,22,22,22}); %could increase row separation
grid_left = uigridlayout(p1,[3,1],RowHeight={'fit',22,'fit'});
grid_l1 = uigridlayout(grid_left,[2,2],RowHeight={22,22});
SpanLbl = uilabel(grid_l1);
SpanLbl.Text = 'Span';
SpanLbl.HorizontalAlignment = 'right';
SpanBox = uieditfield(grid_l1,'numeric');
SpanBox.Value = 0.1;
SpanBox.Limits = [0,1];
SpanBox.LowerLimitInclusive = 'off';
SpanBox.Tooltip = 'Fraction of points used to average. Setting the value to 1 applies no filter';

MethodLbl = uilabel(grid_l1);
MethodLbl.Text = 'Method';
MethodLbl.HorizontalAlignment = 'right';

MethodDropDown = uidropdown(grid_l1);
MethodDropDown.Items = {'moving','sgolay','rloess'};

SmoothPlus = uicheckbox(grid_left,'Text','Extra Smoothing');

grid_l2 = uigridlayout(grid_left,[2,2],RowHeight={22,22});
SpanLbl2 = uilabel(grid_l2);
SpanLbl2.Text = 'Span';
SpanLbl2.HorizontalAlignment = 'right';

SpanBox2 = uieditfield(grid_l2,'numeric');
SpanBox2.Value = 0.1;
SpanBox2.Limits = [0,1];
SpanBox2.LowerLimitInclusive = 'off';
SpanBox2.Tooltip = 'Fraction of points used to average. Setting the value to 1 applies no filter';

MethodLbl2 = uilabel(grid_l2);
MethodLbl2.Text = 'Method';
MethodLbl2.HorizontalAlignment = 'right';

MethodDropDown2 = uidropdown(grid_l2);
MethodDropDown2.Items = {'moving','sgolay','rloess'};






NewCurveBtn = uibutton(p1,Text='New Curve');
NewCurveBtn.Position(1:2) = [50,130];


FinishBtn = uibutton(p1,Text='Continue',BackgroundColor=[0.78,0.96,0.55]);
FinishBtn.Position(1:2) = [50,40];
FinishBtn.Position(4) = 40;




ax2 = uiaxes(grid_main);
ax2.XLabel.String = 'V(mv)';
ax2.YLabel.String = 'Conductance (\muS)';
ax2.Title.String = 'I/V';
ax2.Box = true;
ax2.FontWeight = 'bold';
ax2.FontSize = 12;
% ax2.GridLineStyle = ;
grid(ax2,"on")


fig.UserData = randi(Filas*Columnas);

if isfield(Struct,'Fspan')
    SpanBox.Value = Struct.Fspan;
    MethodDropDown.Value = Struct.Fmethod;
    SmoothPlus.Value = Struct.F2check ;
    SpanBox2.Value = Struct.Fspan2;
    MethodDropDown2.Value = Struct.Fmethod2;
    SecondFilt(SmoothPlus.Value,ax2,fig.UserData,MatrizCorriente,VoltajeOffset,...
    SpanBox,MethodDropDown,SpanLbl2,SpanBox2,MethodLbl2,MethodDropDown2)
else
    [SpanLbl2.Enable,SpanBox2.Enable,MethodLbl2.Enable,...
        MethodDropDown2.Enable] = deal(false);
end


SmoothCond(ax2,fig.UserData,MatrizCorriente,VoltajeOffset,SpanBox.Value,MethodDropDown.Value,...
    SpanBox2.Value,MethodDropDown2.Value,SmoothPlus.Value)

NewCurveBtn.ButtonPushedFcn = @(a,b,c,d,e,f,g,h,m,n,p) ...
    ChangeCurve(Filas,Columnas,ax2,fig.UserData,MatrizCorriente,VoltajeOffset,...
    SpanBox.Value,MethodDropDown.Value,...
    SpanBox2.Value,MethodDropDown2.Value,SmoothPlus.Value);

SpanBox.ValueChangedFcn = @(a,b,c,d,e,f,g,h,m) ...
    SmoothCond(ax2,fig.UserData,MatrizCorriente,VoltajeOffset,...
    SpanBox.Value,MethodDropDown.Value,...
    SpanBox2.Value,MethodDropDown2.Value,SmoothPlus.Value);

MethodDropDown.ValueChangedFcn = @(a,b,c,d,e,f,g,h,m) ...
    SmoothCond(ax2,fig.UserData,MatrizCorriente,VoltajeOffset,...
    SpanBox.Value,MethodDropDown.Value,...
    SpanBox2.Value,MethodDropDown2.Value,SmoothPlus.Value);

SpanBox2.ValueChangedFcn = @(a,b,c,d,e,f,g,h,m) ...
    SmoothCond(ax2,fig.UserData,MatrizCorriente,VoltajeOffset,...
    SpanBox.Value,MethodDropDown.Value,...
    SpanBox2.Value,MethodDropDown2.Value,SmoothPlus.Value);

MethodDropDown2.ValueChangedFcn = @(a,b,c,d,e,f,g,h,m) ...
    SmoothCond(ax2,fig.UserData,MatrizCorriente,VoltajeOffset,...
    SpanBox.Value,MethodDropDown.Value,...
    SpanBox2.Value,MethodDropDown2.Value,SmoothPlus.Value);

SmoothPlus.ValueChangedFcn = @(Check,ax,pt,I,V,b1,m1,l2,b2,l3,b3) ...
    SecondFilt(SmoothPlus.Value,ax2,fig.UserData,MatrizCorriente,VoltajeOffset,...
    SpanBox,MethodDropDown,SpanLbl2,SpanBox2,MethodLbl2,MethodDropDown2);

% FinishBtn.ButtonPushedFcn = @(a,b) show(App,Struct);
% FinishBtn.ButtonPushedFcn = @(a,b,c,d,e,f) Export(Struct,SpanBox,MethodDropDown,SpanBox2,MethodDropDown2,SmoothPlus);
FinishBtn.ButtonPushedFcn = @(x,y) uiresume(fig);
uiwait(fig);

% it raises an error when the window is closed without pressing continue
Struct.Fspan = SpanBox.Value;
Struct.Fmethod = MethodDropDown.Value;
Struct.F2check = SmoothPlus.Value;
Struct.Fspan2 = SpanBox2.Value;
Struct.Fmethod2 = MethodDropDown2.Value;

close(fig)

    function SecondFilt(Value,ax,~,MatrizCorriente,VoltajeOffset,SpanBox,...
            MethodDropDown,SpanLbl2,SpanBox2,MethodLbl2,MethodDropDown2)
    if Value
        [SpanLbl2.Enable,...
            SpanBox2.Enable,...
            MethodLbl2.Enable,...
            MethodDropDown2.Enable] = deal(true);
    else
        [SpanLbl2.Enable,...
            SpanBox2.Enable,...
            MethodLbl2.Enable,...
            MethodDropDown2.Enable] = deal(false);
    end
    fig2 = ancestor(SpanBox,"figure","toplevel");
    SmoothCond(ax,fig2.UserData,MatrizCorriente,VoltajeOffset,...
    SpanBox.Value,MethodDropDown.Value,...
    SpanBox2.Value,MethodDropDown2.Value,Value);
    end

    function SmoothCond(ax,n,MatrizCorriente,VoltajeOffset,...
            Span,Method,Span2,Method2,DoubleSmooth)
        Current = MatrizCorriente(:,n);
        % Smooth the current
        Current_Smooth = smooth(Current,Span,Method);
        % Obtain the zero bias current of the curve
        Imin = interp1( VoltajeOffset,Current_Smooth,0);

        % Calculate I/V
        Test_G = (Current_Smooth-Imin)./VoltajeOffset;

        % Remove NaN points if voltage is exactly zero at any point
        if any( VoltajeOffset == 0 )
            center = find(VoltajeOffset == 0 );
            Test_G(center) = 0.5*(Test_G(center+1)+ Test_G(center-1));
        end

        % Here we would apply the secondary smoothing, but it is disabled initially
        if DoubleSmooth
            [~,center] = min(VoltajeOffset,[],1,ComparisonMethod="abs");
            midspan = floor(0.1*length(VoltajeOffset));
            Test_G(center-midspan:center+midspan) = smooth(Test_G(center-midspan:center+midspan),Span2,Method2);
        end
        % Now we can just go ahead and plot the curve

        plot(ax,VoltajeOffset,Test_G,LineWidth = 1.5)
        ax.XLim = [min(VoltajeOffset), max(VoltajeOffset)];
        legend(ax,num2str(n),Location="northwest")
        % Add switch to plot normalized conductance
    end
    function ChangeCurve(Filas,Columnas,ax,~,MatrizCorriente,VoltajeOffset,...
            Span,Method,Span2,Method2,DoubleSmooth)
        fig2 = ancestor(ax,"figure","toplevel");
        fig2.UserData = randi(Filas*Columnas);
        SmoothCond(ax,fig2.UserData,MatrizCorriente,VoltajeOffset,...
            Span,Method,Span2,Method2,DoubleSmooth)
    end
%     function [Struct] = Export(Struct,SpanBox,MethodDropDown,SpanBox2,MethodDropDown2,SmoothPlus)
%         disp(Struct)
%         Struct.Fspan = SpanBox.Value;
%         Struct.Fmethod = MethodDropDown.Value;
%         Struct.F2check = SmoothPlus.Value;
%         Struct.Fspan2 = SpanBox2.Value;
%         Struct.Fmethod2 = MethodDropDown2.Value;
% %         calculateblq(App, Struct, Voltaje, MatrizCorriente);
%     end
%     function show(App,Struct)
%         disp(App.OffsetvoltageEditField.Value)
%         disp(Struct.NPuntosDerivada)
% %         disp(Struct.OffsetVoltaje) 
%         %App refreshes inmediately, but the struct remains as the beggining
%     end
end