function map = terrain(N)
% Perceptually uniform sequential colormap from MatPlotLib.
%
% Copyright (c) 2017-2020 Stephen Cobeldick
%
%%% Syntax:
%  map = inferno
%  map = inferno(N)
%
% Colormap designed by Nathaniel J. Smith and Stefan van der Walt.
%
% For MatPlotLib 2.0 improved colormaps were created in the perceptually
% uniform colorspace CAM02-UCS. The new colormaps are introduced here:
% <http://matplotlib.org/2.0.0rc2/users/dflt_style_changes.html>
% The RGB data is from here: <https://bids.github.io/colormap/>
%
% Note VIRIDIS replaces the awful JET as the MatPlotLib default colormap.
%
%% Examples %%
%
%%% Plot the scheme's RGB values:
% rgbplot(inferno(256))
%
%%% New colors for the COLORMAP example:
% load spine
% image(X)
% colormap(inferno)
%
%%% New colors for the SURF example:
% [X,Y,Z] = peaks(30);
% surfc(X,Y,Z)
% colormap(inferno)
% axis([-3,3,-3,3,-10,5])
%
%% Input and Output Arguments %%
%
%%% Inputs (*=default):
% N = NumericScalar, N>=0, an integer to define the colormap length.
%   = *[], use the length of the current figure's colormap (see COLORMAP).
%
%%% Outputs:
% map = NumericMatrix, size Nx3, a colormap of RGB values between 0 and 1.
%
% See also CIVIDIS MAGMA PLASMA VIRIDIS TWILIGHT TAB10 SET LINES COLORMAP PARULA

if nargin<1 || isnumeric(N)&&isequal(N,[])
% 	N = size(get(gcf,'colormap'),1);
N=256;
else
	assert(isscalar(N)&&isfinite(N)&&isreal(N),...
		'SC:inferno:N:NotRealFiniteScalarNumeric',...
		'First argument <N> must be a real finite numeric scalar.')
end
%
raw = [0.2 0.2 0.6;0.194771241830065 0.210457516339869 0.610457516339869;0.189542483660131 0.220915032679739 0.620915032679739;0.184313725490196 0.231372549019608 0.631372549019608;0.179084967320261 0.241830065359477 0.641830065359477;0.173856209150327 0.252287581699346 0.652287581699346;0.168627450980392 0.262745098039216 0.662745098039216;0.163398692810458 0.273202614379085 0.673202614379085;0.158169934640523 0.283660130718954 0.683660130718954;0.152941176470588 0.294117647058824 0.694117647058824;0.147712418300654 0.304575163398693 0.704575163398693;0.142483660130719 0.315032679738562 0.715032679738562;0.137254901960784 0.325490196078431 0.725490196078431;0.13202614379085 0.335947712418301 0.735947712418301;0.126797385620915 0.34640522875817 0.74640522875817;0.12156862745098 0.356862745098039 0.756862745098039;0.116339869281046 0.367320261437909 0.767320261437908;0.111111111111111 0.377777777777778 0.777777777777778;0.105882352941176 0.388235294117647 0.788235294117647;0.100653594771242 0.398692810457516 0.798692810457516;0.0954248366013072 0.409150326797386 0.809150326797386;0.0901960784313725 0.419607843137255 0.819607843137255;0.0849673202614379 0.430065359477124 0.830065359477124;0.0797385620915033 0.440522875816993 0.840522875816993;0.0745098039215686 0.450980392156863 0.850980392156863;0.069281045751634 0.461437908496732 0.861437908496732;0.0640522875816993 0.471895424836601 0.871895424836601;0.0588235294117647 0.482352941176471 0.882352941176471;0.0535947712418301 0.49281045751634 0.89281045751634;0.0483660130718954 0.503267973856209 0.903267973856209;0.0431372549019608 0.513725490196078 0.913725490196078;0.0379084967320261 0.524183006535948 0.924183006535948;0.0326797385620915 0.534640522875817 0.934640522875817;0.0274509803921569 0.545098039215686 0.945098039215686;0.0222222222222222 0.555555555555556 0.955555555555555;0.0169934640522876 0.566013071895425 0.966013071895425;0.011764705882353 0.576470588235294 0.976470588235294;0.00653594771241833 0.586928104575163 0.986928104575163;0.00130718954248366 0.597385620915033 0.997385620915033;0 0.605882352941176 0.982352941176471;0 0.613725490196078 0.958823529411765;0 0.62156862745098 0.935294117647059;0 0.629411764705882 0.911764705882353;0 0.637254901960784 0.888235294117647;0 0.645098039215686 0.864705882352941;0 0.652941176470588 0.841176470588235;0 0.66078431372549 0.817647058823529;0 0.668627450980392 0.794117647058824;0 0.676470588235294 0.770588235294118;0 0.684313725490196 0.747058823529412;0 0.692156862745098 0.723529411764706;0 0.7 0.7;0 0.707843137254902 0.676470588235294;0 0.715686274509804 0.652941176470588;0 0.723529411764706 0.629411764705882;0 0.731372549019608 0.605882352941177;0 0.73921568627451 0.582352941176471;0 0.747058823529412 0.558823529411765;0 0.754901960784314 0.535294117647059;0 0.762745098039216 0.511764705882353;0 0.770588235294118 0.488235294117647;0 0.77843137254902 0.464705882352941;0 0.786274509803922 0.441176470588235;0 0.794117647058824 0.417647058823529;0.00392156862745098 0.80078431372549 0.40078431372549;0.0196078431372549 0.803921568627451 0.403921568627451;0.0352941176470586 0.807058823529412 0.407058823529412;0.0509803921568627 0.810196078431373 0.410196078431373;0.0666666666666667 0.813333333333333 0.413333333333333;0.0823529411764706 0.816470588235294 0.416470588235294;0.0980392156862745 0.819607843137255 0.419607843137255;0.113725490196078 0.822745098039216 0.422745098039216;0.129411764705882 0.825882352941177 0.425882352941176;0.145098039215686 0.829019607843137 0.429019607843137;0.16078431372549 0.832156862745098 0.432156862745098;0.176470588235294 0.835294117647059 0.435294117647059;0.192156862745098 0.83843137254902 0.43843137254902;0.207843137254902 0.84156862745098 0.44156862745098;0.223529411764706 0.844705882352941 0.444705882352941;0.23921568627451 0.847843137254902 0.447843137254902;0.254901960784314 0.850980392156863 0.450980392156863;0.270588235294118 0.854117647058824 0.454117647058824;0.286274509803921 0.857254901960784 0.457254901960784;0.301960784313725 0.860392156862745 0.460392156862745;0.317647058823529 0.863529411764706 0.463529411764706;0.333333333333333 0.866666666666667 0.466666666666667;0.349019607843137 0.869803921568628 0.469803921568627;0.364705882352941 0.872941176470588 0.472941176470588;0.380392156862745 0.876078431372549 0.476078431372549;0.396078431372549 0.87921568627451 0.47921568627451;0.411764705882353 0.882352941176471 0.482352941176471;0.427450980392157 0.885490196078431 0.485490196078431;0.443137254901961 0.888627450980392 0.488627450980392;0.458823529411765 0.891764705882353 0.491764705882353;0.474509803921569 0.894901960784314 0.494901960784314;0.490196078431373 0.898039215686275 0.498039215686275;0.505882352941176 0.901176470588235 0.501176470588235;0.52156862745098 0.904313725490196 0.504313725490196;0.537254901960784 0.907450980392157 0.507450980392157;0.552941176470588 0.910588235294118 0.510588235294118;0.568627450980392 0.913725490196078 0.513725490196078;0.584313725490196 0.916862745098039 0.516862745098039;0.6 0.92 0.52;0.615686274509804 0.923137254901961 0.523137254901961;0.631372549019608 0.926274509803922 0.526274509803922;0.647058823529412 0.929411764705882 0.529411764705882;0.662745098039215 0.932549019607843 0.532549019607843;0.67843137254902 0.935686274509804 0.535686274509804;0.694117647058824 0.938823529411765 0.538823529411765;0.709803921568627 0.941960784313726 0.541960784313726;0.725490196078431 0.945098039215686 0.545098039215686;0.741176470588235 0.948235294117647 0.548235294117647;0.756862745098039 0.951372549019608 0.551372549019608;0.772549019607843 0.954509803921569 0.554509803921569;0.788235294117647 0.957647058823529 0.557647058823529;0.803921568627451 0.96078431372549 0.56078431372549;0.819607843137255 0.963921568627451 0.563921568627451;0.835294117647059 0.967058823529412 0.567058823529412;0.850980392156863 0.970196078431373 0.570196078431373;0.866666666666667 0.973333333333333 0.573333333333333;0.882352941176471 0.976470588235294 0.576470588235294;0.898039215686275 0.979607843137255 0.579607843137255;0.913725490196078 0.982745098039216 0.582745098039216;0.929411764705882 0.985882352941176 0.585882352941177;0.945098039215686 0.989019607843137 0.589019607843137;0.96078431372549 0.992156862745098 0.592156862745098;0.976470588235294 0.995294117647059 0.595294117647059;0.992156862745098 0.99843137254902 0.59843137254902;0.996078431372549 0.994980392156863 0.597882352941176;0.988235294117647 0.984941176470588 0.593647058823529;0.980392156862745 0.974901960784314 0.589411764705882;0.972549019607843 0.964862745098039 0.585176470588235;0.964705882352941 0.954823529411765 0.580941176470588;0.956862745098039 0.94478431372549 0.576705882352941;0.949019607843137 0.934745098039216 0.572470588235294;0.941176470588235 0.924705882352941 0.568235294117647;0.933333333333333 0.914666666666667 0.564;0.925490196078431 0.904627450980392 0.559764705882353;0.917647058823529 0.894588235294118 0.555529411764706;0.909803921568627 0.884549019607843 0.551294117647059;0.901960784313726 0.874509803921569 0.547058823529412;0.894117647058824 0.864470588235294 0.542823529411765;0.886274509803922 0.85443137254902 0.538588235294118;0.87843137254902 0.844392156862745 0.534352941176471;0.870588235294118 0.834352941176471 0.530117647058823;0.862745098039216 0.824313725490196 0.525882352941176;0.854901960784314 0.814274509803922 0.521647058823529;0.847058823529412 0.804235294117647 0.517411764705882;0.83921568627451 0.794196078431373 0.513176470588235;0.831372549019608 0.784156862745098 0.508941176470588;0.823529411764706 0.774117647058824 0.504705882352941;0.815686274509804 0.764078431372549 0.500470588235294;0.807843137254902 0.754039215686275 0.496235294117647;0.8 0.744 0.492;0.792156862745098 0.733960784313725 0.487764705882353;0.784313725490196 0.723921568627451 0.483529411764706;0.776470588235294 0.713882352941176 0.479294117647059;0.768627450980392 0.703843137254902 0.475058823529412;0.76078431372549 0.693803921568627 0.470823529411765;0.752941176470588 0.683764705882353 0.466588235294118;0.745098039215686 0.673725490196079 0.462352941176471;0.737254901960784 0.663686274509804 0.458117647058824;0.729411764705882 0.653647058823529 0.453882352941177;0.72156862745098 0.643607843137255 0.449647058823529;0.713725490196079 0.633568627450981 0.445411764705883;0.705882352941176 0.623529411764706 0.441176470588235;0.698039215686274 0.613490196078431 0.436941176470588;0.690196078431373 0.603450980392157 0.432705882352941;0.682352941176471 0.593411764705882 0.428470588235294;0.674509803921569 0.583372549019608 0.424235294117647;0.666666666666667 0.573333333333333 0.42;0.658823529411765 0.563294117647059 0.415764705882353;0.650980392156863 0.553254901960784 0.411529411764706;0.643137254901961 0.54321568627451 0.407294117647059;0.635294117647059 0.533176470588235 0.403058823529412;0.627450980392157 0.523137254901961 0.398823529411765;0.619607843137255 0.513098039215686 0.394588235294118;0.611764705882353 0.503058823529412 0.390352941176471;0.603921568627451 0.493019607843137 0.386117647058824;0.596078431372549 0.482980392156863 0.381882352941176;0.588235294117647 0.472941176470589 0.37764705882353;0.580392156862745 0.462901960784314 0.373411764705882;0.572549019607843 0.452862745098039 0.369176470588235;0.564705882352941 0.442823529411765 0.364941176470588;0.556862745098039 0.43278431372549 0.360705882352941;0.549019607843137 0.422745098039216 0.356470588235294;0.541176470588235 0.412705882352941 0.352235294117647;0.533333333333333 0.402666666666667 0.348;0.525490196078431 0.392627450980392 0.343764705882353;0.517647058823529 0.382588235294118 0.339529411764706;0.509803921568627 0.372549019607843 0.335294117647059;0.501960784313725 0.362509803921569 0.331058823529412;0.505882352941176 0.367529411764706 0.337882352941176;0.513725490196078 0.37756862745098 0.348392156862745;0.52156862745098 0.387607843137255 0.358901960784314;0.529411764705882 0.397647058823529 0.369411764705882;0.537254901960784 0.407686274509804 0.379921568627451;0.545098039215686 0.417725490196078 0.39043137254902;0.552941176470588 0.427764705882353 0.400941176470588;0.56078431372549 0.437803921568627 0.411450980392157;0.568627450980392 0.447843137254902 0.421960784313726;0.576470588235294 0.457882352941176 0.432470588235294;0.584313725490196 0.467921568627451 0.442980392156863;0.592156862745098 0.477960784313725 0.453490196078431;0.6 0.488 0.464;0.607843137254902 0.498039215686275 0.474509803921569;0.615686274509804 0.508078431372549 0.485019607843137;0.623529411764706 0.518117647058824 0.495529411764706;0.631372549019608 0.528156862745098 0.506039215686275;0.63921568627451 0.538196078431373 0.516549019607843;0.647058823529412 0.548235294117647 0.527058823529412;0.654901960784314 0.558274509803922 0.53756862745098;0.662745098039215 0.568313725490196 0.548078431372549;0.670588235294118 0.578352941176471 0.558588235294118;0.67843137254902 0.588392156862745 0.569098039215686;0.686274509803922 0.59843137254902 0.579607843137255;0.694117647058824 0.608470588235294 0.590117647058824;0.701960784313725 0.618509803921569 0.600627450980392;0.709803921568627 0.628549019607843 0.611137254901961;0.717647058823529 0.638588235294118 0.621647058823529;0.725490196078431 0.648627450980392 0.632156862745098;0.733333333333333 0.658666666666667 0.642666666666667;0.741176470588235 0.668705882352941 0.653176470588235;0.749019607843137 0.678745098039216 0.663686274509804;0.756862745098039 0.68878431372549 0.674196078431373;0.764705882352941 0.698823529411765 0.684705882352941;0.772549019607843 0.708862745098039 0.69521568627451;0.780392156862745 0.718901960784314 0.705725490196078;0.788235294117647 0.728941176470588 0.716235294117647;0.796078431372549 0.738980392156863 0.726745098039216;0.803921568627451 0.749019607843137 0.737254901960784;0.811764705882353 0.759058823529412 0.747764705882353;0.819607843137255 0.769098039215686 0.758274509803922;0.827450980392157 0.779137254901961 0.76878431372549;0.835294117647059 0.789176470588235 0.779294117647059;0.843137254901961 0.79921568627451 0.789803921568627;0.850980392156863 0.809254901960784 0.800313725490196;0.858823529411765 0.819294117647059 0.810823529411765;0.866666666666667 0.829333333333333 0.821333333333333;0.874509803921569 0.839372549019608 0.831843137254902;0.882352941176471 0.849411764705882 0.842352941176471;0.890196078431372 0.859450980392157 0.852862745098039;0.898039215686274 0.869490196078431 0.863372549019608;0.905882352941176 0.879529411764706 0.873882352941176;0.913725490196078 0.88956862745098 0.884392156862745;0.92156862745098 0.899607843137255 0.894901960784314;0.929411764705882 0.909647058823529 0.905411764705882;0.937254901960784 0.919686274509804 0.915921568627451;0.945098039215686 0.929725490196078 0.926431372549019;0.952941176470588 0.939764705882353 0.936941176470588;0.96078431372549 0.949803921568627 0.947450980392157;0.968627450980392 0.959843137254902 0.957960784313725;0.976470588235294 0.969882352941176 0.968470588235294;0.984313725490196 0.979921568627451 0.978980392156863;0.992156862745098 0.989960784313725 0.989490196078431;1 1 1];
%
num = size(raw,1);
% With small extrapolation when N>num:
vec = linspace(0,num+1,N+2);
map = interp1(1:num,raw,vec(2:N+1),'linear','extrap');
% Interpolation only for all values of N:
%map = interp1(1:num,raw,linspace(1,num,N),'spline')
% Range limits:
map = max(0,min(1,map));
%
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%inferno