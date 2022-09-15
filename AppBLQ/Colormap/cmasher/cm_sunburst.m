function map = cm_sunburst(N) 

if nargin<1 || isnumeric(N)&&isequal(N,[])
N=256;
end

raw = [0.000000 0.000000 0.000000;0.000287 0.000208 0.000283;0.001024 0.000709 0.001010;0.002180 0.001442 0.002148;0.003753 0.002378 0.003689;0.005747 0.003494 0.005628;0.008174 0.004772 0.007966;0.011044 0.006199 0.010700;0.014374 0.007761 0.013830;0.018178 0.009445 0.017354;0.022473 0.011242 0.021269;0.027277 0.013139 0.025572;0.032609 0.015129 0.030258;0.038487 0.017201 0.035321;0.044722 0.019347 0.040749;0.050950 0.021557 0.046202;0.057181 0.023825 0.051569;0.063419 0.026142 0.056851;0.069667 0.028500 0.062048;0.075929 0.030894 0.067160;0.082207 0.033315 0.072188;0.088502 0.035758 0.077129;0.094815 0.038217 0.081985;0.101149 0.040681 0.086754;0.107503 0.043062 0.091435;0.113879 0.045363 0.096027;0.120275 0.047588 0.100530;0.126694 0.049738 0.104942;0.133134 0.051815 0.109264;0.139596 0.053821 0.113493;0.146079 0.055759 0.117629;0.152583 0.057629 0.121673;0.159109 0.059433 0.125622;0.165654 0.061173 0.129478;0.172220 0.062850 0.133239;0.178805 0.064466 0.136905;0.185410 0.066022 0.140475;0.192033 0.067518 0.143951;0.198675 0.068957 0.147331;0.205335 0.070339 0.150615;0.212012 0.071665 0.153805;0.218706 0.072935 0.156898;0.225417 0.074151 0.159897;0.232145 0.075314 0.162800;0.238888 0.076424 0.165608;0.245647 0.077481 0.168322;0.252421 0.078486 0.170941;0.259210 0.079440 0.173465;0.266014 0.080343 0.175895;0.272831 0.081196 0.178232;0.279663 0.081998 0.180475;0.286509 0.082750 0.182624;0.293368 0.083452 0.184681;0.300240 0.084104 0.186645;0.307125 0.084707 0.188516;0.314022 0.085260 0.190294;0.320933 0.085763 0.191981;0.327855 0.086217 0.193576;0.334789 0.086621 0.195079;0.341735 0.086976 0.196491;0.348693 0.087281 0.197811;0.355661 0.087535 0.199040;0.362641 0.087740 0.200178;0.369632 0.087893 0.201225;0.376633 0.087997 0.202182;0.383644 0.088049 0.203047;0.390666 0.088049 0.203822;0.397697 0.087999 0.204506;0.404738 0.087896 0.205100;0.411788 0.087741 0.205602;0.418847 0.087534 0.206014;0.425915 0.087273 0.206335;0.432991 0.086959 0.206564;0.440075 0.086592 0.206702;0.447166 0.086171 0.206749;0.454265 0.085696 0.206703;0.461370 0.085167 0.206566;0.468482 0.084583 0.206336;0.475600 0.083945 0.206013;0.482723 0.083252 0.205597;0.489851 0.082504 0.205087;0.496983 0.081702 0.204482;0.504119 0.080847 0.203783;0.511258 0.079938 0.202988;0.518399 0.078977 0.202097;0.525542 0.077964 0.201109;0.532685 0.076900 0.200023;0.539829 0.075789 0.198839;0.546970 0.074631 0.197554;0.554110 0.073430 0.196169;0.561247 0.072188 0.194682;0.568379 0.070910 0.193093;0.575505 0.069600 0.191398;0.582624 0.068264 0.189598;0.589734 0.066910 0.187691;0.596834 0.065545 0.185675;0.603921 0.064180 0.183549;0.610994 0.062826 0.181310;0.618051 0.061496 0.178957;0.625088 0.060208 0.176489;0.632104 0.058979 0.173901;0.639096 0.057831 0.171194;0.646060 0.056788 0.168363;0.652993 0.055878 0.165407;0.659892 0.055133 0.162324;0.666751 0.054586 0.159109;0.673567 0.054275 0.155762;0.680334 0.054238 0.152278;0.687047 0.054516 0.148655;0.693700 0.055150 0.144892;0.700285 0.056181 0.140985;0.706796 0.057644 0.136932;0.713225 0.059572 0.132732;0.719562 0.061993 0.128383;0.725798 0.064927 0.123887;0.731924 0.068388 0.119243;0.737928 0.072380 0.114455;0.743799 0.076903 0.109528;0.749526 0.081945 0.104468;0.755098 0.087492 0.099285;0.760503 0.093519 0.093993;0.765732 0.099999 0.088609;0.770776 0.106897 0.083154;0.775627 0.114175 0.077653;0.780281 0.121790 0.072135;0.784736 0.129699 0.066635;0.788991 0.137855 0.061191;0.793050 0.146215 0.055846;0.796917 0.154735 0.050648;0.800599 0.163375 0.045652;0.804106 0.172098 0.040919;0.807445 0.180874 0.036563;0.810627 0.189673 0.032849;0.813662 0.198473 0.029781;0.816559 0.207257 0.027354;0.819328 0.216009 0.025564;0.821977 0.224718 0.024404;0.824514 0.233375 0.023873;0.826946 0.241975 0.023967;0.829280 0.250513 0.024685;0.831522 0.258986 0.026032;0.833678 0.267394 0.028008;0.835751 0.275736 0.030623;0.837747 0.284012 0.033882;0.839669 0.292223 0.037796;0.841520 0.300370 0.042319;0.843304 0.308455 0.047182;0.845023 0.316480 0.052323;0.846680 0.324447 0.057698;0.848277 0.332357 0.063271;0.849816 0.340213 0.069011;0.851299 0.348017 0.074896;0.852727 0.355770 0.080906;0.854103 0.363474 0.087028;0.855427 0.371133 0.093250;0.856700 0.378746 0.099561;0.857925 0.386317 0.105956;0.859102 0.393846 0.112428;0.860232 0.401336 0.118972;0.861316 0.408787 0.125585;0.862355 0.416202 0.132265;0.863350 0.423582 0.139009;0.864303 0.430927 0.145815;0.865212 0.438241 0.152683;0.866081 0.445522 0.159610;0.866909 0.452773 0.166597;0.867697 0.459995 0.173644;0.868446 0.467188 0.180749;0.869156 0.474353 0.187913;0.869829 0.481492 0.195135;0.870466 0.488605 0.202417;0.871066 0.495693 0.209757;0.871631 0.502757 0.217157;0.872162 0.509796 0.224616;0.872659 0.516812 0.232136;0.873123 0.523806 0.239715;0.873556 0.530777 0.247355;0.873957 0.537727 0.255057;0.874329 0.544655 0.262820;0.874671 0.551562 0.270645;0.874985 0.558449 0.278533;0.875272 0.565315 0.286483;0.875533 0.572161 0.294498;0.875769 0.578986 0.302576;0.875982 0.585792 0.310719;0.876171 0.592578 0.318926;0.876340 0.599345 0.327200;0.876489 0.606092 0.335539;0.876619 0.612819 0.343944;0.876732 0.619527 0.352417;0.876830 0.626215 0.360957;0.876914 0.632883 0.369564;0.876986 0.639531 0.378240;0.877048 0.646159 0.386984;0.877101 0.652766 0.395796;0.877148 0.659353 0.404678;0.877191 0.665919 0.413629;0.877231 0.672464 0.422650;0.877272 0.678988 0.431740;0.877316 0.685489 0.440900;0.877365 0.691968 0.450129;0.877422 0.698424 0.459428;0.877490 0.704857 0.468797;0.877572 0.711265 0.478235;0.877670 0.717650 0.487743;0.877789 0.724009 0.497319;0.877931 0.730343 0.506963;0.878101 0.736650 0.516675;0.878301 0.742931 0.526453;0.878536 0.749183 0.536298;0.878809 0.755408 0.546208;0.879124 0.761603 0.556181;0.879487 0.767768 0.566217;0.879901 0.773903 0.576314;0.880370 0.780006 0.586471;0.880900 0.786078 0.596685;0.881495 0.792116 0.606954;0.882160 0.798121 0.617277;0.882899 0.804091 0.627651;0.883718 0.810026 0.638072;0.884622 0.815925 0.648539;0.885615 0.821788 0.659049;0.886702 0.827614 0.669597;0.887890 0.833402 0.680181;0.889181 0.839152 0.690796;0.890582 0.844864 0.701439;0.892097 0.850536 0.712106;0.893732 0.856169 0.722792;0.895489 0.861763 0.733492;0.897374 0.867316 0.744203;0.899391 0.872830 0.754918;0.901543 0.878304 0.765633;0.903836 0.883739 0.776342;0.906271 0.889133 0.787040;0.908854 0.894489 0.797722;0.911586 0.899805 0.808380;0.914472 0.905083 0.819009;0.917514 0.910322 0.829602;0.920715 0.915523 0.840153;0.924079 0.920687 0.850654;0.927608 0.925814 0.861095;0.931307 0.930904 0.871469;0.935178 0.935958 0.881765;0.939227 0.940976 0.891970;0.943457 0.945958 0.902069;0.947875 0.950904 0.912044;0.952485 0.955817 0.921873;0.957291 0.960697 0.931527;0.962292 0.965550 0.940972;0.967479 0.970383 0.950169;0.972826 0.975211 0.959082;0.978287 0.980054 0.967692;0.983795 0.984938 0.976013;0.989279 0.989886 0.984105;0.994685 0.994908 0.992067;1.000000 1.000000 1.000000;];

num = size(raw,1);

vec = linspace(0,num+1,N+2);
map = interp1(1:num,raw,vec(2:N+1),'linear','extrap');

map = max(0,min(1,map));
end