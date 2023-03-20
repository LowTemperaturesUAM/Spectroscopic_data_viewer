function [CellWarped] = WarpRealMatrix(Cell,XShear,YShear,YXratio,Info)
% This functin applies an affine transformation to generic maps in order to
% correct image warping.
% The current implementation then cuts the images to the size of the input
% images taking the middle of the image as the reference and
% filling the missing points with zeros, if necessary.

Columnas = length(Info.DistanciaColumnas);
Filas    = length(Info.DistanciaFilas);
tform = affine2d([1,YShear,0;-XShear,YXratio,0;0,0,1]);
%The first element is the equivalent parameter for XYratio but for the
%x-axis. We fix it as 1 as we only want to change the relative size of
% one axis to the other

    CellWarpedAUX = cellfun(@(x) imwarp(x,tform),...
        Cell,UniformOutput = false);
    %We calculate this for every map, but we can probably assume they are
    %all the same
    %In real space we don't have to worry about the center, so no need to
    %check for parity

    [NewFilas, NewColumnas] = size(CellWarpedAUX{1});
    CentroY = floor(NewFilas/2);
    CentroX = floor(NewColumnas/2);

    %In order to allow values of YXRatio lower than 1, we have to make
    %sure we fill the missing part of the matrix with zeros
    %We have to compare the number of rows of the initial image and the
    %warped one to see if it shrank or not. In the columns, its always
    %larger as we are only applying a shear transform
    if NewFilas >= Filas
    CellWarped = cellfun(@(x) ...
        x(CentroY-Filas/2+1:CentroY+Filas/2,...
        CentroX-Columnas/2+1:CentroX+Columnas/2),CellWarpedAUX,...
        UniformOutput = false);
    else
        CellWarped = cellfun(@(x) zeros(size(x)),Cell,UniformOutput=false);
        ptgap = (Filas-NewFilas)/2;
        for k = 1:numel(CellWarped)
            CellWarped{k}(1+ptgap:end-ptgap,:) = ...
                CellWarpedAUX{k}(:,CentroX-Columnas/2+1:CentroX+Columnas/2);
        end

    end
    
    clear CellWarpedAUX CentroX CentroY NewFilas NewColumnas
    
end