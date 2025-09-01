function [P] = wignerSeitz2D_V2(Bragg,opts)
arguments
    Bragg (:,2) double
    opts.Method {mustBeMember(opts.Method,{'voronoi','Intersection'})} = 'Intersection'
end
% Given a set of Bragg peaks, wignerSeitz2D(Bragg) calculates the vertices of a WignerSeitz
% (Brillouin in reciprocal space) cell around the origin, i.e. the area 
% enclosed by these Bragg peaks whose points lie closer to the origin than
% to any of the peaks.

% INPUT
% Bragg is a 2 column matrix with coordinates of the peaks

%Example: BrillouinPeaks = wignerSeitz_V2([0 1;1 0]).

Zero = mean(Bragg,1); %Center of polygon as center of mass
Bragg = Bragg - Zero;

% Sort peaks by angle
a = atan2d(Bragg(:,2),Bragg(:,1));
 [~,idx] = sort(a);
 Bragg = Bragg(idx,:);


normBragg = 0.5*vecnorm(Bragg,2,2).^2;
% Number of peaks
numPeaks = numel(normBragg);

% Solve linear system for every adjacent pair of peaks
P = zeros(size(Bragg));
for i = 1:numPeaks
    j = mod(i,numPeaks)+1;

    b = [normBragg(i); normBragg(j)];
    A = [Bragg(i,1), Bragg(i,2);
     Bragg(j,1), Bragg(j,2)];

    P(i,:) = (A\b).';
end
% Return polygon to original position
P = P + Zero;
end