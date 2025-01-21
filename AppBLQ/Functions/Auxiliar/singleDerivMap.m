function SlopeMap = singleDerivMap(V,Matrix,derivPts,Vmap,Row,Col)
% SlopeMap = singleDerivMap(V,Matrix,derivPts,Vmap,Row,Col) calculates the
% map matrix SlopeMap(RowxCol) from the curves in Matrix with variable V.
% Values for map are interpolateed at a value Vmap.

% Calculate derivative from curves in Matrix, with variable V
    dMatrix = derivadorLeastSquaresArray(derivPts,Matrix,V);
    % Obtain interpolated values of derivated curves at voltage Vmap
    dV = interp1(V,dMatrix,Vmap,"makima");

    %We convert to a map similarly to how we do in curves2maps
    SlopeMap = reshape(dV,[1,Col,Row]);
    SlopeMap = permute(SlopeMap,[2,3,1]);
    SlopeMap = pagetranspose(SlopeMap);
end