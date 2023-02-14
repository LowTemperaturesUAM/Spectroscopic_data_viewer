function initCell(app, Cell, isReal)
if isReal %Real
    minVector = cellfun(@(x) min(x,[],"all"),Cell);
    maxVector = cellfun(@(x) max(x,[],"all"),Cell);
    minValue = min(minVector);
else %FFT
    %We take the second largest point for the max, as the first one is always
    %the center point
    maxVector = cellfun(@(x) max(x(x~=max(x,[],"all")),[],"all"),Cell);
    minValue = 0; %always fix the lower limit to zero for FFT
end
    maxValue = max(maxVector);
    %Compare this to the current slider limits and take the widest
    %values = chooseContrast([minValue maxValue],app.MinSlider.Limits(1),app.MinSlider.Limits(2));
    values = sort([minValue maxValue app.MinSlider.Limits],"ascend");
    values = values([1,end]);
    [app.MinSlider.Limits,app.MaxSlider.Limits] = deal(values);
end