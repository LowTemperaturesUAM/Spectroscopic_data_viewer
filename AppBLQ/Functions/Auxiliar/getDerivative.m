function Out = getDerivative(Curves,Voltage,derivPts,opts)
arguments
Curves {mustBeFinite,mustBeReal}
Voltage (:,1) {mustBeFinite,mustBeReal,mustBeVector}
derivPts {mustBeFinite,mustBeInteger, mustBePositive} 
opts.Method {mustBeMember(opts.Method,{'mirrorNorm','singleNorm','FeenstraNorm','Log','none','junctionNorm'})} = 'none'
opts.UpperValue {mustBeScalarOrEmpty} = max(Voltage)*0.9
opts.LowerValue {mustBeScalarOrEmpty} = max(Voltage)*0.7
opts.AuxData = []
end

dCurves = derivadorLeastSquaresArray(derivPts,Curves,Voltage);
switch opts.Method
    case 'mirrorNorm'
        Out = NormalizeRange(opts.UpperValue,opts.LowerValue,Voltage,dCurves,Range="both");
    case 'singleNorm'
        Out = NormalizeRange(opts.UpperValue,opts.LowerValue,Voltage,dCurves,Range="single");
    case 'juctionNorm'
        %We need the current at the set point as AuxData
        %Check if it's valid
        if isempty(opts.AuxData)
            error('Juction normalization requires the Current vector to be provided as AuxData')
        end
        CurNo = size(Curves,2);
        if numel(opts.AuxData) ~= CurNo
            error('The provided Current vector is not the right size')
        end
        Out = NormalizeJunction(Voltage,Curves,AuxData);
    case 'FeenstraNorm'
        %Let's to a lazy implementation here. We'll look at it later
        %we can use AuxData to input a different (maybe filtered) current for
        %the calculation of the division
        Out = Voltage.*dCurves./Curves;
    case 'Log'
        %Assume any kind of offset has already been corrected beforehand
        logCur = real(log(Curves));
        Out = derivadorLeastSquaresArray(derivPts,logCur,Voltage);
    case 'none'
        Out = dCurves; % units: uS
        % This is not technically correct if the set point is negative
        % Conductance = mean(max(dCurves))/max(Voltaje);
        % NormalizationFlag = 'none';
end