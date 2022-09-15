function map = cm_emerald(N) 

if nargin<1 || isnumeric(N)&&isequal(N,[])
N=256;
end

raw = [0.000000 0.000000 0.000000;0.000179 0.000203 0.000166;0.000610 0.000708 0.000565;0.001245 0.001478 0.001149;0.002062 0.002495 0.001895;0.003044 0.003752 0.002787;0.004180 0.005242 0.003812;0.005461 0.006961 0.004962;0.006880 0.008907 0.006228;0.008430 0.011076 0.007602;0.010106 0.013469 0.009079;0.011902 0.016083 0.010653;0.013816 0.018918 0.012319;0.015842 0.021974 0.014073;0.017977 0.025250 0.015909;0.020217 0.028748 0.017825;0.022561 0.032467 0.019816;0.025004 0.036407 0.021879;0.027544 0.040568 0.024011;0.030179 0.044744 0.026209;0.032906 0.048884 0.028469;0.035723 0.052992 0.030790;0.038628 0.057069 0.033168;0.041589 0.061117 0.035601;0.044499 0.065140 0.038086;0.047368 0.069139 0.040619;0.050197 0.073114 0.043107;0.052987 0.077069 0.045552;0.055741 0.081005 0.047955;0.058459 0.084922 0.050317;0.061143 0.088822 0.052641;0.063794 0.092707 0.054927;0.066414 0.096576 0.057176;0.069002 0.100432 0.059390;0.071560 0.104275 0.061570;0.074089 0.108105 0.063717;0.076589 0.111924 0.065831;0.079062 0.115733 0.067914;0.081508 0.119532 0.069966;0.083927 0.123321 0.071988;0.086320 0.127102 0.073981;0.088688 0.130875 0.075945;0.091031 0.134641 0.077882;0.093349 0.138399 0.079791;0.095643 0.142152 0.081673;0.097913 0.145898 0.083530;0.100160 0.149639 0.085361;0.102384 0.153375 0.087166;0.104585 0.157107 0.088948;0.106763 0.160834 0.090705;0.108919 0.164558 0.092438;0.111052 0.168278 0.094148;0.113164 0.171995 0.095835;0.115253 0.175710 0.097500;0.117321 0.179422 0.099142;0.119367 0.183133 0.100763;0.121392 0.186841 0.102362;0.123395 0.190549 0.103940;0.125376 0.194255 0.105498;0.127336 0.197961 0.107035;0.129275 0.201666 0.108552;0.131192 0.205371 0.110049;0.133087 0.209076 0.111527;0.134961 0.212781 0.112985;0.136814 0.216487 0.114425;0.138644 0.220194 0.115846;0.140453 0.223901 0.117248;0.142240 0.227611 0.118632;0.144004 0.231321 0.119999;0.145746 0.235034 0.121347;0.147466 0.238748 0.122679;0.149163 0.242465 0.123993;0.150837 0.246184 0.125291;0.152488 0.249906 0.126572;0.154116 0.253631 0.127837;0.155719 0.257359 0.129085;0.157299 0.261090 0.130318;0.158854 0.264824 0.131536;0.160385 0.268563 0.132738;0.161890 0.272305 0.133925;0.163370 0.276051 0.135097;0.164823 0.279802 0.136256;0.166250 0.283557 0.137400;0.167650 0.287317 0.138530;0.169023 0.291082 0.139647;0.170367 0.294852 0.140750;0.171682 0.298628 0.141841;0.172968 0.302409 0.142919;0.174224 0.306195 0.143985;0.175449 0.309988 0.145039;0.176643 0.313786 0.146082;0.177804 0.317591 0.147114;0.178931 0.321403 0.148136;0.180025 0.325221 0.149147;0.181083 0.329047 0.150149;0.182105 0.332879 0.151142;0.183090 0.336719 0.152126;0.184036 0.340566 0.153102;0.184942 0.344422 0.154070;0.185807 0.348285 0.155032;0.186630 0.352156 0.155988;0.187408 0.356037 0.156939;0.188141 0.359925 0.157885;0.188827 0.363823 0.158827;0.189463 0.367730 0.159766;0.190048 0.371647 0.160704;0.190580 0.375573 0.161640;0.191056 0.379509 0.162578;0.191475 0.383456 0.163516;0.191833 0.387413 0.164457;0.192127 0.391381 0.165403;0.192355 0.395360 0.166354;0.192514 0.399350 0.167313;0.192600 0.403353 0.168282;0.192609 0.407367 0.169261;0.192537 0.411394 0.170254;0.192380 0.415433 0.171264;0.192133 0.419486 0.172291;0.191791 0.423552 0.173341;0.191347 0.427631 0.174415;0.190797 0.431725 0.175518;0.190134 0.435834 0.176652;0.189349 0.439957 0.177824;0.188436 0.444096 0.179037;0.187386 0.448250 0.180297;0.186190 0.452420 0.181610;0.184836 0.456606 0.182982;0.183315 0.460809 0.184422;0.181614 0.465029 0.185937;0.179721 0.469265 0.187537;0.177623 0.473518 0.189231;0.175305 0.477788 0.191032;0.172754 0.482074 0.192952;0.169954 0.486376 0.195004;0.166891 0.490692 0.197203;0.163553 0.495022 0.199564;0.159929 0.499363 0.202103;0.156011 0.503713 0.204837;0.151797 0.508069 0.207780;0.147291 0.512428 0.210946;0.142503 0.516785 0.214345;0.137453 0.521135 0.217984;0.132167 0.525474 0.221867;0.126680 0.529798 0.225989;0.121033 0.534101 0.230344;0.115270 0.538381 0.234919;0.109437 0.542635 0.239700;0.103581 0.546859 0.244667;0.097744 0.551055 0.249803;0.091970 0.555220 0.255088;0.086301 0.559355 0.260506;0.080776 0.563461 0.266038;0.075434 0.567539 0.271670;0.070315 0.571590 0.277388;0.065462 0.575615 0.283182;0.060920 0.579617 0.289040;0.056735 0.583596 0.294953;0.052958 0.587554 0.300915;0.049641 0.591493 0.306918;0.046833 0.595413 0.312958;0.044581 0.599316 0.319029;0.042925 0.603203 0.325128;0.041896 0.607076 0.331251;0.041505 0.610935 0.337395;0.041752 0.614782 0.343558;0.042617 0.618617 0.349737;0.044070 0.622441 0.355931;0.046062 0.626255 0.362138;0.048544 0.630060 0.368356;0.051459 0.633856 0.374585;0.054753 0.637645 0.380824;0.058373 0.641427 0.387071;0.062272 0.645202 0.393326;0.066405 0.648972 0.399588;0.070735 0.652736 0.405857;0.075230 0.656495 0.412132;0.079860 0.660249 0.418413;0.084604 0.664000 0.424698;0.089439 0.667748 0.430989;0.094350 0.671493 0.437284;0.099323 0.675235 0.443584;0.104345 0.678975 0.449888;0.109407 0.682713 0.456196;0.114500 0.686450 0.462508;0.119617 0.690186 0.468824;0.124753 0.693922 0.475144;0.129902 0.697657 0.481467;0.135061 0.701392 0.487794;0.140226 0.705128 0.494125;0.145394 0.708864 0.500459;0.150563 0.712602 0.506797;0.155730 0.716340 0.513137;0.160894 0.720081 0.519482;0.166053 0.723823 0.525830;0.171207 0.727568 0.532182;0.176354 0.731315 0.538537;0.181493 0.735065 0.544897;0.186624 0.738818 0.551260;0.191745 0.742574 0.557627;0.196858 0.746334 0.563997;0.201960 0.750097 0.570372;0.207052 0.753865 0.576751;0.212134 0.757637 0.583134;0.217205 0.761414 0.589522;0.222265 0.765195 0.595914;0.227314 0.768982 0.602310;0.232353 0.772774 0.608712;0.237380 0.776571 0.615118;0.242396 0.780375 0.621529;0.247400 0.784184 0.627945;0.252394 0.788000 0.634367;0.257376 0.791822 0.640795;0.262347 0.795650 0.647227;0.267307 0.799486 0.653666;0.272256 0.803329 0.660110;0.277194 0.807179 0.666562;0.282121 0.811036 0.673019;0.287037 0.814902 0.679483;0.291942 0.818775 0.685954;0.296836 0.822657 0.692432;0.301720 0.826547 0.698917;0.306592 0.830446 0.705409;0.311455 0.834353 0.711910;0.316307 0.838270 0.718418;0.321148 0.842196 0.724935;0.325979 0.846131 0.731460;0.330800 0.850075 0.737993;0.335610 0.854030 0.744536;0.340411 0.857995 0.751088;0.345201 0.861969 0.757650;0.349982 0.865954 0.764221;0.354753 0.869950 0.770803;0.359514 0.873957 0.777394;0.364265 0.877974 0.783996;0.369007 0.882003 0.790610;0.373739 0.886043 0.797234;0.378462 0.890094 0.803871;0.383175 0.894157 0.810519;0.387880 0.898232 0.817179;0.392575 0.902319 0.823852;0.397261 0.906418 0.830538;0.401938 0.910529 0.837237;0.406607 0.914653 0.843950;0.411266 0.918790 0.850676;0.415917 0.922940 0.857416;0.420560 0.927102 0.864171;0.425194 0.931278 0.870942;0.429819 0.935467 0.877727;0.434437 0.939670 0.884528;0.439046 0.943886 0.891345;0.443648 0.948117 0.898178;0.448241 0.952361 0.905029;0.452827 0.956619 0.911896;0.457405 0.960892 0.918781;0.461976 0.965180 0.925684;0.466539 0.969481 0.932606;];

num = size(raw,1);

vec = linspace(0,num+1,N+2);
map = interp1(1:num,raw,vec(2:N+1),'linear','extrap');

map = max(0,min(1,map));
end