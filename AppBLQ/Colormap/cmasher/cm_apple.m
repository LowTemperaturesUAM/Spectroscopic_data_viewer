function map = cm_apple(N) 

if nargin<1 || isnumeric(N)&&isequal(N,[])
N=256;
end

raw = [0.000000 0.000000 0.000000;0.000345 0.000192 0.000222;0.001253 0.000645 0.000767;0.002703 0.001298 0.001579;0.004702 0.002118 0.002635;0.007261 0.003083 0.003917;0.010395 0.004175 0.005412;0.014119 0.005380 0.007110;0.018449 0.006683 0.008999;0.023403 0.008074 0.011073;0.028998 0.009543 0.013324;0.035251 0.011078 0.015743;0.042131 0.012672 0.018324;0.049094 0.014315 0.021060;0.056028 0.016000 0.023944;0.062941 0.017718 0.026970;0.069836 0.019462 0.030130;0.076719 0.021225 0.033418;0.083594 0.022999 0.036827;0.090463 0.024776 0.040351;0.097330 0.026552 0.043837;0.104197 0.028318 0.047248;0.111067 0.030068 0.050586;0.117942 0.031796 0.053852;0.124822 0.033495 0.057048;0.131711 0.035159 0.060174;0.138609 0.036781 0.063231;0.145519 0.038356 0.066219;0.152439 0.039877 0.069139;0.159374 0.041318 0.071990;0.166322 0.042660 0.074772;0.173285 0.043910 0.077485;0.180264 0.045068 0.080127;0.187258 0.046132 0.082700;0.194270 0.047101 0.085201;0.201300 0.047975 0.087629;0.208348 0.048751 0.089984;0.215414 0.049429 0.092264;0.222499 0.050006 0.094468;0.229603 0.050481 0.096594;0.236726 0.050851 0.098639;0.243869 0.051114 0.100604;0.251030 0.051268 0.102484;0.258212 0.051309 0.104278;0.265413 0.051234 0.105983;0.272633 0.051041 0.107597;0.279872 0.050725 0.109117;0.287129 0.050282 0.110539;0.294404 0.049708 0.111860;0.301697 0.048999 0.113077;0.309007 0.048148 0.114184;0.316332 0.047152 0.115179;0.323672 0.046004 0.116056;0.331025 0.044699 0.116810;0.338390 0.043229 0.117436;0.345765 0.041589 0.117928;0.353148 0.039763 0.118281;0.360537 0.037775 0.118485;0.367928 0.035664 0.118536;0.375319 0.033444 0.118424;0.382704 0.031128 0.118141;0.390079 0.028735 0.117679;0.397439 0.026288 0.117027;0.404777 0.023815 0.116176;0.412085 0.021350 0.115115;0.419353 0.018937 0.113835;0.426571 0.016622 0.112324;0.433725 0.014468 0.110575;0.440801 0.012545 0.108579;0.447781 0.010934 0.106332;0.454646 0.009730 0.103831;0.461374 0.009039 0.101084;0.467944 0.008973 0.098099;0.474332 0.009651 0.094896;0.480518 0.011185 0.091504;0.486485 0.013680 0.087955;0.492219 0.017219 0.084290;0.497716 0.021863 0.080550;0.502974 0.027646 0.076773;0.508001 0.034578 0.072993;0.512805 0.042578 0.069239;0.517400 0.050840 0.065529;0.521801 0.059118 0.061877;0.526021 0.067360 0.058290;0.530076 0.075532 0.054770;0.533978 0.083614 0.051317;0.537739 0.091595 0.047926;0.541371 0.099469 0.044593;0.544883 0.107236 0.041311;0.548283 0.114896 0.038076;0.551578 0.122455 0.035011;0.554775 0.129915 0.032125;0.557879 0.137284 0.029403;0.560895 0.144564 0.026837;0.563827 0.151763 0.024417;0.566679 0.158885 0.022136;0.569454 0.165936 0.019988;0.572154 0.172920 0.017966;0.574782 0.179842 0.016068;0.577341 0.186706 0.014288;0.579832 0.193516 0.012627;0.582255 0.200277 0.011080;0.584615 0.206992 0.009648;0.586910 0.213663 0.008330;0.589142 0.220295 0.007127;0.591312 0.226890 0.006039;0.593421 0.233451 0.005069;0.595470 0.239981 0.004218;0.597459 0.246481 0.003488;0.599388 0.252954 0.002884;0.601257 0.259403 0.002407;0.603068 0.265828 0.002063;0.604821 0.272232 0.001856;0.606515 0.278617 0.001790;0.608150 0.284984 0.001871;0.609728 0.291334 0.002104;0.611247 0.297670 0.002497;0.612707 0.303992 0.003054;0.614109 0.310301 0.003784;0.615453 0.316599 0.004694;0.616738 0.322887 0.005791;0.617964 0.329166 0.007084;0.619131 0.335436 0.008582;0.620239 0.341699 0.010295;0.621288 0.347955 0.012231;0.622276 0.354205 0.014400;0.623205 0.360450 0.016815;0.624073 0.366691 0.019485;0.624881 0.372928 0.022422;0.625628 0.379161 0.025638;0.626314 0.385391 0.029147;0.626938 0.391620 0.032960;0.627500 0.397846 0.037092;0.628000 0.404071 0.041529;0.628438 0.410294 0.046038;0.628812 0.416517 0.050591;0.629124 0.422739 0.055189;0.629372 0.428961 0.059832;0.629556 0.435184 0.064522;0.629676 0.441406 0.069259;0.629731 0.447629 0.074044;0.629722 0.453852 0.078878;0.629647 0.460077 0.083760;0.629507 0.466302 0.088693;0.629301 0.472528 0.093676;0.629029 0.478756 0.098711;0.628690 0.484984 0.103798;0.628284 0.491214 0.108938;0.627811 0.497446 0.114132;0.627270 0.503679 0.119381;0.626662 0.509913 0.124685;0.625985 0.516149 0.130045;0.625239 0.522386 0.135462;0.624423 0.528625 0.140938;0.623538 0.534866 0.146472;0.622583 0.541108 0.152067;0.621557 0.547352 0.157723;0.620460 0.553597 0.163441;0.619291 0.559844 0.169224;0.618051 0.566092 0.175071;0.616737 0.572342 0.180984;0.615349 0.578593 0.186966;0.613889 0.584846 0.193018;0.612353 0.591100 0.199142;0.610742 0.597355 0.205340;0.609056 0.603610 0.211613;0.607294 0.609867 0.217966;0.605455 0.616124 0.224400;0.603540 0.622381 0.230918;0.601547 0.628639 0.237523;0.599477 0.634895 0.244218;0.597329 0.641151 0.251008;0.595105 0.647405 0.257897;0.592804 0.653657 0.264887;0.590426 0.659906 0.271985;0.587974 0.666152 0.279195;0.585449 0.672392 0.286522;0.582853 0.678626 0.293972;0.580189 0.684853 0.301551;0.577460 0.691070 0.309266;0.574671 0.697277 0.317124;0.571828 0.703470 0.325132;0.568938 0.709647 0.333298;0.566011 0.715805 0.341631;0.563057 0.721942 0.350138;0.560089 0.728052 0.358830;0.557125 0.734131 0.367715;0.554183 0.740174 0.376803;0.551287 0.746176 0.386104;0.548465 0.752129 0.395625;0.545750 0.758026 0.405376;0.543179 0.763859 0.415364;0.540799 0.769617 0.425594;0.538660 0.775291 0.436067;0.536818 0.780869 0.446784;0.535335 0.786340 0.457738;0.534279 0.791691 0.468918;0.533716 0.796911 0.480309;0.533712 0.801989 0.491884;0.534328 0.806916 0.503615;0.535614 0.811685 0.515464;0.537608 0.816293 0.527390;0.540329 0.820738 0.539352;0.543781 0.825024 0.551306;0.547949 0.829156 0.563211;0.552802 0.833142 0.575033;0.558300 0.836993 0.586742;0.564391 0.840721 0.598311;0.571021 0.844336 0.609723;0.578134 0.847851 0.620967;0.585672 0.851279 0.632031;0.593583 0.854629 0.642915;0.601817 0.857912 0.653615;0.610330 0.861137 0.664134;0.619079 0.864314 0.674474;0.628027 0.867449 0.684639;0.637144 0.870550 0.694636;0.646399 0.873624 0.704467;0.655769 0.876675 0.714141;0.665232 0.879709 0.723664;0.674768 0.882731 0.733039;0.684362 0.885745 0.742276;0.693998 0.888755 0.751377;0.703665 0.891763 0.760351;0.713353 0.894773 0.769201;0.723052 0.897789 0.777933;0.732754 0.900812 0.786552;0.742452 0.903846 0.795062;0.752141 0.906892 0.803467;0.761815 0.909953 0.811772;0.771470 0.913029 0.819981;0.781104 0.916124 0.828098;0.790712 0.919239 0.836126;0.800290 0.922375 0.844066;0.809839 0.925534 0.851926;0.819353 0.928718 0.859703;0.828834 0.931927 0.867404;0.838277 0.935165 0.875027;0.847685 0.938430 0.882579;0.857052 0.941725 0.890058;0.866379 0.945052 0.897468;0.875667 0.948411 0.904809;0.884910 0.951804 0.912082;0.894110 0.955233 0.919287;0.903266 0.958698 0.926426;0.912377 0.962201 0.933497;0.921439 0.965745 0.940501;0.930451 0.969331 0.947434;0.939410 0.972962 0.954296;0.948312 0.976640 0.961083;0.957152 0.980369 0.967791;0.965923 0.984154 0.974415;0.974613 0.988000 0.980950;0.983207 0.991916 0.987391;0.991680 0.995911 0.993737;1.000000 1.000000 1.000000;];

num = size(raw,1);

vec = linspace(0,num+1,N+2);
map = interp1(1:num,raw,vec(2:N+1),'linear','extrap');

map = max(0,min(1,map));
end