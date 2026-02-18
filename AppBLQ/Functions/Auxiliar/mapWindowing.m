function WindowedMaps = mapWindowing(Maps,alpha)
arguments
    Maps 
    alpha double {mustBeInRange(alpha,0,1)}
end
if iscell(Maps)
    [Row,Col] = size(Maps{1});
elseif ismatrix(Maps)
    [Row,Col] = size(Maps);
else
    error('The provided input is not an array or a cell array')
    return
end
wx = TukeyWindow(Row,alpha,1);
% enbw(wx) %efective noise bandwidth of the window.
if Row~=Col
    wy = TukeyWindow(Col,alpha,2);
else
    wy = wx.';
end

if iscell(Maps)
    WindowedMaps = cellfun(@(x) x.*wx.*wy*enbw(wx),Maps,UniformOutput=false);
elseif ismatrix(Maps)
    WindowedMaps = Maps.*wx.*wy*enbw(wx);
end
end



function w = TukeyWindow(N,alpha,dir)
arguments
N double {mustBeInteger}
alpha double {mustBeInRange(alpha,0,1)}
dir = 2;
end
%alpha parameter from [0,1]
%0 is equivalent to rectangular window, 1 o Hann window( a cosine)
n = 0:N-1;
r1 = 0<=n & n< (alpha*N/2);
% r2 = (alpha*N/2)<=n & n<=N/2; %these are all one, and we can define the rest
% by symmetry


if dir ==1
    w = ones([1,N]);
else
    w = ones([N,1]);
end
w(r1) = 1/2* ( 1-cos(2*pi*n(r1)/(alpha*N)) );
w(flip(r1)) =flip(w(r1));
end