function map = cm_cosmic(N) 

if nargin<1 || isnumeric(N)&&isequal(N,[])
N=256;
end

raw = [0.000000 0.000000 0.000000;0.000223 0.000177 0.000250;0.000784 0.000605 0.000902;0.001648 0.001238 0.001937;0.002801 0.002053 0.003361;0.004239 0.003035 0.005182;0.005959 0.004172 0.007414;0.007959 0.005454 0.010073;0.010239 0.006872 0.013172;0.012802 0.008420 0.016731;0.015647 0.010091 0.020766;0.018779 0.011878 0.025297;0.022197 0.013776 0.030343;0.025907 0.015780 0.035927;0.029910 0.017884 0.042023;0.034209 0.020083 0.048205;0.038809 0.022373 0.054399;0.043584 0.024749 0.060612;0.048320 0.027206 0.066848;0.053028 0.029739 0.073111;0.057710 0.032343 0.079404;0.062370 0.035015 0.085731;0.067009 0.037750 0.092095;0.071631 0.040540 0.098500;0.076237 0.043279 0.104947;0.080829 0.045959 0.111440;0.085408 0.048582 0.117982;0.089977 0.051147 0.124575;0.094536 0.053656 0.131221;0.099087 0.056109 0.137922;0.103630 0.058507 0.144682;0.108168 0.060850 0.151501;0.112700 0.063138 0.158384;0.117228 0.065370 0.165331;0.121753 0.067548 0.172345;0.126275 0.069670 0.179428;0.130796 0.071736 0.186582;0.135315 0.073746 0.193809;0.139833 0.075698 0.201111;0.144351 0.077593 0.208491;0.148869 0.079429 0.215952;0.153389 0.081206 0.223495;0.157909 0.082922 0.231121;0.162432 0.084576 0.238834;0.166956 0.086166 0.246636;0.171483 0.087693 0.254529;0.176012 0.089153 0.262515;0.180544 0.090545 0.270596;0.185079 0.091867 0.278775;0.189617 0.093117 0.287056;0.194158 0.094294 0.295437;0.198702 0.095394 0.303925;0.203250 0.096415 0.312519;0.207800 0.097355 0.321224;0.212354 0.098210 0.330041;0.216911 0.098978 0.338971;0.221470 0.099655 0.348020;0.226031 0.100238 0.357189;0.230595 0.100723 0.366480;0.235159 0.101106 0.375895;0.239725 0.101382 0.385438;0.244291 0.101547 0.395110;0.248856 0.101596 0.404914;0.253420 0.101523 0.414854;0.257982 0.101322 0.424930;0.262540 0.100988 0.435146;0.267093 0.100514 0.445503;0.271640 0.099893 0.456003;0.276178 0.099117 0.466647;0.280707 0.098177 0.477440;0.285223 0.097067 0.488380;0.289725 0.095775 0.499470;0.294209 0.094291 0.510709;0.298673 0.092605 0.522100;0.303113 0.090707 0.533640;0.307524 0.088582 0.545329;0.311903 0.086217 0.557168;0.316243 0.083600 0.569151;0.320540 0.080716 0.581276;0.324787 0.077549 0.593537;0.328977 0.074083 0.605931;0.333101 0.070304 0.618447;0.337149 0.066199 0.631074;0.341113 0.061750 0.643803;0.344979 0.056950 0.656617;0.348735 0.051794 0.669495;0.352366 0.046287 0.682419;0.355857 0.040450 0.695360;0.359190 0.034502 0.708287;0.362347 0.028943 0.721164;0.365306 0.023929 0.733951;0.368046 0.019645 0.746599;0.370547 0.016290 0.759059;0.372784 0.014087 0.771271;0.374737 0.013269 0.783177;0.376385 0.014076 0.794714;0.377711 0.016748 0.805820;0.378699 0.021514 0.816436;0.379340 0.028581 0.826507;0.379627 0.038129 0.835985;0.379559 0.049520 0.844834;0.379142 0.061441 0.853028;0.378382 0.073668 0.860552;0.377294 0.086044 0.867403;0.375894 0.098454 0.873588;0.374200 0.110815 0.879125;0.372232 0.123065 0.884038;0.370012 0.135159 0.888357;0.367559 0.147063 0.892115;0.364895 0.158754 0.895348;0.362038 0.170215 0.898093;0.359009 0.181436 0.900388;0.355826 0.192411 0.902268;0.352503 0.203140 0.903770;0.349057 0.213623 0.904926;0.345501 0.223863 0.905768;0.341849 0.233865 0.906326;0.338112 0.243635 0.906627;0.334301 0.253179 0.906696;0.330427 0.262505 0.906559;0.326497 0.271620 0.906235;0.322520 0.280532 0.905746;0.318505 0.289249 0.905109;0.314456 0.297778 0.904341;0.310381 0.306128 0.903457;0.306285 0.314306 0.902472;0.302174 0.322319 0.901398;0.298053 0.330174 0.900248;0.293925 0.337879 0.899030;0.289795 0.345439 0.897757;0.285667 0.352862 0.896435;0.281544 0.360153 0.895073;0.277429 0.367318 0.893679;0.273326 0.374363 0.892259;0.269237 0.381293 0.890819;0.265164 0.388114 0.889366;0.261111 0.394830 0.887903;0.257079 0.401446 0.886435;0.253070 0.407967 0.884968;0.249087 0.414396 0.883504;0.245131 0.420739 0.882047;0.241205 0.426998 0.880600;0.237309 0.433178 0.879166;0.233446 0.439282 0.877747;0.229616 0.445314 0.876346;0.225822 0.451277 0.874965;0.222064 0.457174 0.873606;0.218343 0.463008 0.872270;0.214662 0.468783 0.870960;0.211021 0.474500 0.869675;0.207421 0.480162 0.868418;0.203862 0.485773 0.867189;0.200347 0.491334 0.865990;0.196875 0.496848 0.864821;0.193446 0.502317 0.863683;0.190063 0.507743 0.862577;0.186726 0.513128 0.861502;0.183433 0.518475 0.860460;0.180188 0.523785 0.859451;0.176988 0.529060 0.858475;0.173835 0.534302 0.857531;0.170729 0.539513 0.856621;0.167669 0.544694 0.855744;0.164655 0.549847 0.854901;0.161687 0.554973 0.854090;0.158765 0.560074 0.853312;0.155887 0.565151 0.852567;0.153054 0.570207 0.851855;0.150264 0.575241 0.851175;0.147516 0.580255 0.850527;0.144809 0.585252 0.849910;0.142142 0.590231 0.849324;0.139513 0.595194 0.848768;0.136920 0.600142 0.848243;0.134362 0.605077 0.847747;0.131837 0.609999 0.847280;0.129343 0.614909 0.846842;0.126876 0.619808 0.846431;0.124435 0.624698 0.846047;0.122018 0.629579 0.845689;0.119620 0.634453 0.845356;0.117239 0.639319 0.845049;0.114872 0.644179 0.844765;0.112515 0.649034 0.844504;0.110165 0.653884 0.844265;0.107819 0.658731 0.844048;0.105472 0.663574 0.843851;0.103120 0.668416 0.843673;0.100760 0.673255 0.843513;0.098387 0.678094 0.843371;0.095996 0.682932 0.843245;0.093584 0.687770 0.843135;0.091145 0.692610 0.843038;0.088676 0.697450 0.842955;0.086171 0.702293 0.842883;0.083625 0.707138 0.842822;0.081034 0.711985 0.842771;0.078392 0.716836 0.842728;0.075695 0.721691 0.842692;0.072938 0.726550 0.842663;0.070116 0.731413 0.842637;0.067224 0.736281 0.842615;0.064258 0.741155 0.842596;0.061211 0.746034 0.842576;0.058082 0.750918 0.842557;0.054866 0.755808 0.842535;0.051558 0.760705 0.842510;0.048159 0.765608 0.842480;0.044664 0.770517 0.842444;0.041075 0.775433 0.842400;0.037411 0.780355 0.842348;0.033853 0.785284 0.842285;0.030431 0.790219 0.842211;0.027169 0.795162 0.842123;0.024091 0.800110 0.842020;0.021220 0.805066 0.841902;0.018588 0.810027 0.841765;0.016224 0.814995 0.841610;0.014165 0.819968 0.841433;0.012451 0.824947 0.841235;0.011123 0.829931 0.841013;0.010229 0.834919 0.840767;0.009821 0.839912 0.840493;0.009956 0.844909 0.840192;0.010692 0.849909 0.839861;0.012100 0.854912 0.839500;0.014255 0.859916 0.839106;0.017238 0.864921 0.838678;0.021137 0.869926 0.838216;0.026051 0.874930 0.837716;0.032092 0.879932 0.837179;0.039372 0.884930 0.836603;0.047531 0.889922 0.835987;0.056079 0.894908 0.835329;0.065002 0.899885 0.834628;0.074288 0.904852 0.833884;0.083931 0.909805 0.833096;0.093933 0.914742 0.832262;0.104302 0.919660 0.831384;0.115052 0.924556 0.830460;0.126200 0.929425 0.829490;0.137770 0.934263 0.828476;0.149789 0.939065 0.827419;0.162292 0.943823 0.826322;0.175318 0.948530 0.825188;0.188915 0.953178 0.824023;0.203140 0.957755 0.822834;0.218056 0.962249 0.821634;0.233742 0.966643 0.820439;0.250285 0.970917 0.819273;0.267780 0.975048 0.818174;0.286329 0.979006 0.817193;0.306019 0.982758 0.816409;0.326891 0.986268 0.815932;0.348883 0.989506 0.815911;0.371763 0.992456 0.816521;];

num = size(raw,1);

vec = linspace(0,num+1,N+2);
map = interp1(1:num,raw,vec(2:N+1),'linear','extrap');

map = max(0,min(1,map));
end