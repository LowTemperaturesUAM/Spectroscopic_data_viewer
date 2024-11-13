function SaveClick()

f = gcf;
f.Children.CurrentPoint

number = f.UserData.number;

f.UserData.Points(end+1,:) = [f.UserData.Energy(number) f.Children.CurrentPoint(2)];