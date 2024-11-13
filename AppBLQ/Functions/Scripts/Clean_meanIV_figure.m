a = gcf;
N = length(a.Children);

delete(a.Children(1:N-1))

a.Children.XLim = [-3.5 3.5];
a.Children.YLim = [0, 2];

% a.Children.XLim = [-85 85];
% a.Children.YLim = [0.2, 1.3];

% axis square

%%
for i = 1:length(a.Children.Children)
a.Children.Children(i).XData = a.Children.Children(i).XData+0.00107;
end

%% Curves storage

Gap15T = meanConductanceRegion(:,1:2);
Localized15T = meanConductanceRegion(:,3:4);

% figure
% plot(meanConductanceRegion(:,3),meanConductanceRegion(:,2));

%% Average several curves
Matrix = meanConductanceRegion;
% Matrix = singleConductance;

[~,A] = size(Matrix);
Mask = true(A,1);

for i=1:A
    if rem(i,2) == 1
        Mask(i) = false;
    end
end

CurvaPromedio = sum(Matrix(:,Mask),2)./(0.5*A);

fig = figure;
plot(Matrix(:,1),CurvaPromedio,'LineWidth',2)
% fig.Children.XLim = [-3,3];

