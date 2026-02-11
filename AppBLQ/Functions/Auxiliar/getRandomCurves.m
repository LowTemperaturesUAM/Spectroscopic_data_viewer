function SampleCurves = getRandomCurves(Curves,NrSamples,MaxIndex)
nCur = size(Curves,2);
if nCur<MaxIndex
    error('The range you provided is outside the bounds of the curves!')
end
% Random index for curve selection
MatrizCorrienteTest = Curves(:,randi(MaxIndex,1,NrSamples));
        
SampleCurves = MatrizCorrienteTest;

end