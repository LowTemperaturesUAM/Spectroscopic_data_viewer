function curves2Workspace(Name)
a = gcf;
assignin('base', Name, a.UserData.curves)
end