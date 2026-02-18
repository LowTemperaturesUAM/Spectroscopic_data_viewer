function Out = warpRotateFFT(Maps,XShear,YShear,YXRatio,Angle,InfoStruct,opts)
arguments
    Maps
    XShear double {mustBeFinite}
    YShear double {mustBeFinite}
    YXRatio double {mustBePositive}
    Angle double {mustBeFinite}
    InfoStruct struct
    opts.RevertRotation = false
end
%Create the referene frame of the image
if iscell(Maps)
    [Row,Col] = size(Maps{1});
elseif ismatrix(Maps)
    [Row,Col] = size(Maps);
else
    error('The provided input is not an array or a cell array')
    return
end
RA = imref2d([Row,Col],InfoStruct.DistanciaFourierFilas([1 end]),...
    InfoStruct.DistanciaFourierColumnas([1 end]));
%Create the rotation transformation
trot = rigidtform2d(-Angle,[0,0]);
%Create the affine transformation for shear
tshear = affinetform2d([1,XShear, 0; YShear,YXRatio,0; 0, 0, 1]);
%Combined the desired transformations into one
tCombined = tshear;
if opts.RevertRotation %in case we rotate back after
    tCombined.A =  trot.A'*tshear.A*trot.A;
else
    tCombined.A =  tshear.A*trot.A;
end

if iscell(Maps)
    Out = cellfun(@(x) imwarp(x,RA,tCombined,"nearest",OutputView = RA),Maps,UniformOutput=false);
elseif ismatrix(Maps)
    Out = imwarp(Maps,RA,tCombined,OutputView = RA);
end
end