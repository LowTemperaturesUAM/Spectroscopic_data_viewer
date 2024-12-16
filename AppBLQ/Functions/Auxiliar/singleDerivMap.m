function SlopeMap = singleDerivMap(V,Matrix,derivPts,Vmap,Row,Col)
    dMatrix = derivadorLeastSquaresArray(derivPts,Matrix,V);
    dV = interp1(V,dMatrix,Vmap,"makima");
    %We convert to a map similarly to how we do in curves2maps
    SlopeMap = reshape(dV,[1,Col,Row]);
    SlopeMap = permute(SlopeMap,[2,3,1]);
    SlopeMap = pagetranspose(SlopeMap);
end