function [CellWarped,tform] = WarpMatrixv2(Cell,XShear,YShear,YXratio,Info)
% This function applies an affine transformation to FFT maps in order to
% correct image warping.
% The function make slight adjustments to the input
% parameters of the transformation to ensure that each dimension of the
% maps keeps the same parity. If the original image is of size NxM,
% the output of the transform of size PxQ will always satisfy
% mod(N,2) = mod(P,2) and mod(M,2) == mod(Q,2).
% The output images are then cut to the size of the input images, filling
% the missing points with zeros, if necessary.


% Columnas = length(Info.DistanciaFourierColumnas);
% Filas    = length(Info.DistanciaFourierFilas)
[Filas,Columnas] = size(Cell{1});
tform = affine2d([1,YShear,0;-XShear,YXratio,0;0,0,1]);
%The first element is the equivalent parameter for XYratio but for the
%x-axis. We fix it as 1 as we only want to change the relative size of
% one axis to the other

    CellWarpedAUX = cellfun(@(x) imwarp(x,tform),...
        Cell,UniformOutput = false);
    %We calculate this for every map, but we can probably assume they are
    %all the same
%     CentroY = cellfun(@(x) size(x,1),...
%         CellWarpedAUX,UniformOutput = false);
%     CentroX = cellfun(@(x) size(x,2),...
%         CellWarpedAUX,UniformOutput = false);
    [TestFilas, TestColumnas] = size(CellWarpedAUX{1});
    %Compare if both are even/odd of othewise.
    parityFilas = mod(TestFilas,2) - mod(Filas,2);
   
    if parityFilas == 1 % Original was even, now its odd
        %We change the scaling slightly to make sure they match
        fprintf('Rescale by a factor %g\n',(TestFilas+1)/TestFilas)
        tform.T(2,2) = YXratio*(TestFilas+1)/TestFilas;
        CellWarpedAUX = cellfun(@(x) imwarp(x,tform),...
            Cell,UniformOutput = false);
        [TestFilas, TestColumnas] = size(CellWarpedAUX{1});
        % try the other way around if it doesn't work
        if (mod(TestFilas,2) - mod(Filas,2))~=0
            fprintf('Rescale by a factor %g\n',(TestFilas-1)/TestFilas)
            tform.T(2,2) = YXratio*(TestFilas-1)/TestFilas;
            CellWarpedAUX = cellfun(@(x) imwarp(x,tform),...
                Cell,UniformOutput = false);
            [TestFilas, TestColumnas] = size(CellWarpedAUX{1});
        end
        

    elseif parityFilas == -1 %Original was odd, now is even
        %We change the scaling slightly to make sure they match
        fprintf('Rescale by a factor %g\n',(TestFilas-1)/TestFilas)
        tform.T(2,2) = YXratio*(TestFilas-1)/TestFilas;
        CellWarpedAUX = cellfun(@(x) imwarp(x,tform),...
            Cell,UniformOutput = false);
        [TestFilas, TestColumnas] = size(CellWarpedAUX{1});
        % try the other way around if it doesn't work
        if (mod(TestFilas,2) - mod(Filas,2))~=0
            fprintf('Rescale by a factor %g\n',(TestFilas+1)/TestFilas)
            tform.T(2,2) = YXratio*(TestFilas+1)/TestFilas;
            CellWarpedAUX = cellfun(@(x) imwarp(x,tform),...
                Cell,UniformOutput = false);
            [TestFilas, TestColumnas] = size(CellWarpedAUX{1});
        end
        

    end

    parityColumnas = mod(TestColumnas,2) - mod(Columnas,2);


    if parityColumnas == 1 % Original was even, now its odd
        %We change the scaling slightly to make sure they match
        fprintf('Rescale by a factor %g\n',(TestColumnas+1)/TestColumnas)
        tform.T(1,1) = (TestColumnas+1)/TestColumnas;
        CellWarpedAUX = cellfun(@(x) imwarp(x,tform),...
            Cell,UniformOutput = false);
        [TestFilas, TestColumnas] = size(CellWarpedAUX{1});
        % try the other way around if it doesn't work
        if (mod(TestColumnas,2) - mod(Columnas,2))~=0
            fprintf('Rescale by a factor %g\n',(TestColumnas-1)/TestColumnas)
            tform.T(1,1) = (TestColumnas-1)/TestColumnas;
            CellWarpedAUX = cellfun(@(x) imwarp(x,tform),...
                Cell,UniformOutput = false);
            [TestFilas, TestColumnas] = size(CellWarpedAUX{1});
        end

    elseif parityColumnas == -1 %Original was odd, now is even
        %We change the scaling slightly to make sure they match
        fprintf('Rescale by a factor %g\n',(TestColumnas-1)/TestColumnas)
        tform.T(1,1) = (TestColumnas-1)/TestColumnas;
        CellWarpedAUX = cellfun(@(x) imwarp(x,tform),...
            Cell,UniformOutput = false);
        [TestFilas, TestColumnas] = size(CellWarpedAUX{1});
        % try the other way around if it doesn't work
        if (mod(TestColumnas,2) - mod(Columnas,2))~=0
            fprintf('Rescale by a factor %g\n',(TestColumnas+1)/TestColumnas)
            tform.T(1,1) = (TestColumnas+1)/TestColumnas;
            CellWarpedAUX = cellfun(@(x) imwarp(x,tform),...
                Cell,UniformOutput = false);
            [TestFilas, TestColumnas] = size(CellWarpedAUX{1});
        end
    end

    %Sanity check
    assert((mod(TestFilas,2) - mod(Filas,2))==0)
    assert((mod(TestColumnas,2) - mod(Columnas,2))==0)

    NewFilas = TestFilas;
    NewColumnas = TestColumnas;
    CentroY = floor(NewFilas/2);
    CentroX = floor(NewColumnas/2);

    %In order to allow values of YXRatio lower than 1, we have to make
    %sure we fill the missing part of the matrix with zeros
    %We have to compare the number of rows of the initial image and the
    %warped one to see if it shrank or not. In the columns, its always
    %larger as we are only applying a shear transform
    if NewFilas >= Filas
    CellWarped = cellfun(@(x) ...
        x(CentroY-floor(Filas/2)+1:CentroY+floor(Filas/2),...
        CentroX-floor(Columnas/2)+1:CentroX+floor(Columnas/2)),CellWarpedAUX,...
        UniformOutput = false);
    else
        CellWarped = cellfun(@(x) zeros(size(x)),Cell,UniformOutput=false);
        ptgap = floor((Filas-NewFilas)/2);
        for k = 1:numel(CellWarped)
            CellWarped{k}(1+ptgap:end-ptgap,:) = ...
                CellWarpedAUX{k}(:,CentroX-floor(Columnas/2)+1:CentroX+floor(Columnas/2));
        end

    end
    
    clear CellWarpedAUX CentroX CentroY NewFilas NewColumnas
    
end