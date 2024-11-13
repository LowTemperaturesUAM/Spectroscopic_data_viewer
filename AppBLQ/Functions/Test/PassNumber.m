function PassNumber(~, event)
f = gcf;
number = f.UserData.number;

if strcmp(event.Key, 'leftarrow')
    disp('oli')

  
    if number >1
        number = number-1;
        f.UserData.number = number;
        
    else
        number = 1;
        f.UserData.number = number;
        
    end
end


if strcmp(event.Key, 'rightarrow')
        disp('oli2')
    
    if number <length(f.UserData.C)
        number = number+1
        f.UserData.number = number
        disp('oli3')
    else
        %number = number;
        f.UserData.number = number
        disp('oli4')
    end
end
number
X     = f.UserData.X;
C     = f.UserData.C ;
if isfield(f.UserData, 'Peaks')
    Peaks = f.UserData.Peaks;
end
% Peaks{1}= Peaks{1};
% Peaks{2}= Peaks{2};
% Peaks{3}= Peaks{4};
% Peaks{4}= Peaks{5};
 f.UserData.number 
  plot(X, C{number}, '.-')
    title(['Energy: ', num2str(f.UserData.Energy(number))])
    axis square
    hold on
    color = [{[1 0 0]}, {[0 1 0]}, {[0 0 1]}, {[0 0 0]}];
    
    if isfield(f.UserData, 'Peaks')
    for i = 1:1

        indi = find(Peaks{i}(:,2) == f.UserData.Energy(number));
        if indi
            i
        	plot([Peaks{i}(indi,1), Peaks{i}(indi,1)],[min(C{number}) max(C{number})],'--' , 'color', color{i},...
               'LineWidth',2 )
        
        end
    end
        
    end
    hold off
xlim([-1.42 1.42])
