function map = cm_holly(N) 

if nargin<1 || isnumeric(N)&&isequal(N,[])
N=256;
end

raw = [0.077201 0.078786 0.002500;0.080065 0.082721 0.003015;0.082889 0.086639 0.003557;0.085674 0.090542 0.004125;0.088421 0.094430 0.004718;0.091131 0.098305 0.005336;0.093805 0.102168 0.005978;0.096445 0.106019 0.006644;0.099049 0.109860 0.007333;0.101620 0.113691 0.008044;0.104159 0.117513 0.008777;0.106664 0.121327 0.009532;0.109138 0.125133 0.010307;0.111580 0.128931 0.011102;0.113991 0.132724 0.011917;0.116372 0.136510 0.012751;0.118722 0.140291 0.013604;0.121042 0.144067 0.014476;0.123333 0.147839 0.015365;0.125594 0.151607 0.016272;0.127826 0.155371 0.017196;0.130029 0.159132 0.018136;0.132203 0.162891 0.019093;0.134348 0.166647 0.020067;0.136464 0.170402 0.021056;0.138552 0.174155 0.022060;0.140611 0.177907 0.023080;0.142641 0.181658 0.024115;0.144643 0.185409 0.025165;0.146617 0.189160 0.026229;0.148561 0.192910 0.027307;0.150477 0.196661 0.028400;0.152364 0.200413 0.029507;0.154222 0.204166 0.030628;0.156052 0.207921 0.031763;0.157851 0.211677 0.032911;0.159622 0.215434 0.034074;0.161363 0.219194 0.035250;0.163074 0.222957 0.036440;0.164755 0.226721 0.037644;0.166405 0.230489 0.038862;0.168025 0.234260 0.040094;0.169614 0.238034 0.041320;0.171172 0.241811 0.042533;0.172698 0.245592 0.043740;0.174192 0.249377 0.044940;0.175654 0.253167 0.046134;0.177083 0.256961 0.047321;0.178479 0.260759 0.048505;0.179841 0.264562 0.049683;0.181169 0.268370 0.050858;0.182462 0.272183 0.052029;0.183719 0.276002 0.053198;0.184941 0.279826 0.054364;0.186127 0.283655 0.055529;0.187275 0.287491 0.056692;0.188385 0.291333 0.057855;0.189456 0.295181 0.059018;0.190489 0.299036 0.060182;0.191481 0.302897 0.061347;0.192432 0.306765 0.062515;0.193341 0.310640 0.063685;0.194208 0.314523 0.064859;0.195030 0.318412 0.066038;0.195808 0.322310 0.067222;0.196540 0.326215 0.068412;0.197225 0.330128 0.069610;0.197861 0.334048 0.070815;0.198448 0.337978 0.072030;0.198984 0.341915 0.073254;0.199468 0.345861 0.074491;0.199898 0.349816 0.075739;0.200272 0.353780 0.077002;0.200589 0.357753 0.078279;0.200847 0.361736 0.079573;0.201044 0.365728 0.080885;0.201178 0.369729 0.082216;0.201248 0.373740 0.083569;0.201249 0.377762 0.084945;0.201181 0.381793 0.086346;0.201041 0.385835 0.087775;0.200825 0.389888 0.089233;0.200530 0.393951 0.090724;0.200155 0.398025 0.092250;0.199694 0.402110 0.093814;0.199144 0.406207 0.095419;0.198501 0.410315 0.097069;0.197761 0.414435 0.098769;0.196918 0.418566 0.100523;0.195968 0.422710 0.102337;0.194905 0.426865 0.104216;0.193724 0.431033 0.106167;0.192418 0.435212 0.108199;0.190978 0.439405 0.110320;0.189399 0.443609 0.112542;0.187672 0.447825 0.114877;0.185790 0.452053 0.117343;0.183744 0.456293 0.119958;0.181528 0.460542 0.122747;0.179139 0.464799 0.125740;0.176578 0.469062 0.128978;0.173862 0.473325 0.132512;0.171029 0.477580 0.136408;0.168170 0.481814 0.140752;0.165461 0.486002 0.145637;0.163219 0.490108 0.151144;0.161900 0.494086 0.157269;0.161929 0.497899 0.163873;0.163461 0.501542 0.170731;0.166353 0.505036 0.177646;0.170321 0.508414 0.184502;0.175090 0.511702 0.191248;0.180438 0.514922 0.197872;0.186201 0.518089 0.204373;0.192260 0.521214 0.210759;0.198528 0.524305 0.217040;0.204942 0.527369 0.223226;0.211456 0.530409 0.229325;0.218037 0.533430 0.235347;0.224659 0.536435 0.241298;0.231304 0.539426 0.247184;0.237957 0.542405 0.253011;0.244609 0.545373 0.258786;0.251251 0.548333 0.264511;0.257878 0.551285 0.270192;0.264485 0.554230 0.275831;0.271070 0.557170 0.281433;0.277630 0.560104 0.287000;0.284163 0.563035 0.292534;0.290668 0.565962 0.298038;0.297146 0.568887 0.303516;0.303595 0.571809 0.308967;0.310016 0.574729 0.314394;0.316409 0.577648 0.319800;0.322773 0.580566 0.325185;0.329111 0.583484 0.330550;0.335421 0.586402 0.335899;0.341706 0.589320 0.341230;0.347965 0.592239 0.346547;0.354199 0.595159 0.351849;0.360408 0.598081 0.357139;0.366594 0.601004 0.362416;0.372758 0.603929 0.367682;0.378899 0.606856 0.372937;0.385018 0.609786 0.378183;0.391117 0.612718 0.383420;0.397195 0.615654 0.388650;0.403254 0.618592 0.393871;0.409295 0.621535 0.399086;0.415317 0.624481 0.404295;0.421321 0.627431 0.409498;0.427309 0.630385 0.414697;0.433280 0.633344 0.419891;0.439235 0.636307 0.425082;0.445175 0.639275 0.430269;0.451101 0.642248 0.435453;0.457012 0.645227 0.440636;0.462909 0.648211 0.445816;0.468793 0.651200 0.450995;0.474664 0.654195 0.456173;0.480523 0.657197 0.461350;0.486370 0.660204 0.466528;0.492206 0.663218 0.471705;0.498030 0.666238 0.476884;0.503844 0.669265 0.482063;0.509647 0.672299 0.487244;0.515441 0.675340 0.492427;0.521225 0.678388 0.497612;0.526999 0.681444 0.502800;0.532765 0.684507 0.507991;0.538522 0.687578 0.513185;0.544271 0.690657 0.518382;0.550012 0.693744 0.523584;0.555745 0.696839 0.528790;0.561471 0.699943 0.534000;0.567189 0.703055 0.539216;0.572901 0.706177 0.544437;0.578606 0.709307 0.549664;0.584304 0.712446 0.554896;0.589997 0.715594 0.560136;0.595683 0.718752 0.565381;0.601363 0.721919 0.570634;0.607038 0.725096 0.575894;0.612707 0.728283 0.581162;0.618371 0.731480 0.586438;0.624030 0.734688 0.591722;0.629684 0.737906 0.597015;0.635333 0.741134 0.602317;0.640978 0.744373 0.607628;0.646617 0.747623 0.612950;0.652253 0.750884 0.618281;0.657884 0.754157 0.623623;0.663511 0.757441 0.628975;0.669133 0.760736 0.634339;0.674752 0.764043 0.639714;0.680366 0.767363 0.645101;0.685976 0.770694 0.650501;0.691583 0.774038 0.655913;0.697185 0.777394 0.661339;0.702784 0.780763 0.666778;0.708378 0.784145 0.672231;0.713969 0.787540 0.677698;0.719555 0.790949 0.683181;0.725138 0.794370 0.688678;0.730716 0.797806 0.694191;0.736290 0.801256 0.699720;0.741860 0.804719 0.705266;0.747426 0.808198 0.710829;0.752986 0.811690 0.716410;0.758543 0.815198 0.722009;0.764094 0.818721 0.727626;0.769640 0.822259 0.733262;0.775181 0.825812 0.738918;0.780716 0.829382 0.744595;0.786245 0.832968 0.750292;0.791769 0.836570 0.756010;0.797285 0.840189 0.761750;0.802795 0.843825 0.767513;0.808298 0.847478 0.773299;0.813793 0.851149 0.779108;0.819279 0.854838 0.784942;0.824758 0.858545 0.790800;0.830227 0.862272 0.796684;0.835686 0.866017 0.802593;0.841135 0.869782 0.808530;0.846573 0.873567 0.814493;0.851999 0.877372 0.820483;0.857413 0.881199 0.826502;0.862814 0.885046 0.832548;0.868201 0.888916 0.838623;0.873573 0.892808 0.844727;0.878930 0.896723 0.850859;0.884271 0.900661 0.857019;0.889595 0.904624 0.863207;0.894901 0.908611 0.869423;0.900190 0.912623 0.875664;0.905459 0.916662 0.881930;0.910710 0.920726 0.888218;0.915941 0.924818 0.894525;0.921152 0.928938 0.900849;0.926344 0.933086 0.907184;0.931516 0.937263 0.913526;0.936668 0.941471 0.919866;0.941800 0.945710 0.926198;0.946911 0.949982 0.932513;0.951997 0.954290 0.938801;0.957056 0.958636 0.945054;0.962079 0.963023 0.951264;0.967059 0.967457 0.957429;0.971984 0.971941 0.963551;0.976845 0.976478 0.969635;0.981632 0.981072 0.975697;0.986341 0.985722 0.981750;0.990969 0.990429 0.987809;0.995521 0.995189 0.993890;1.000000 1.000000 1.000000;0.996547 0.994720 0.994519;0.993082 0.989465 0.989068;0.989606 0.984237 0.983646;0.986115 0.979036 0.978253;0.982608 0.973862 0.972891;0.979082 0.968716 0.967559;0.975533 0.963601 0.962259;0.971953 0.958518 0.956991;0.968330 0.953473 0.951759;0.964644 0.948471 0.946574;0.960866 0.943520 0.941488;0.957162 0.938543 0.936585;0.953847 0.933440 0.931604;0.950766 0.928283 0.926455;0.947798 0.923111 0.921219;0.944907 0.917933 0.915939;0.942075 0.912754 0.910636;0.939294 0.907577 0.905319;0.936559 0.902402 0.899995;0.933864 0.897230 0.894668;0.931206 0.892064 0.889340;0.928583 0.886901 0.884014;0.925991 0.881745 0.878691;0.923431 0.876594 0.873371;0.920898 0.871450 0.868058;0.918394 0.866312 0.862750;0.915915 0.861180 0.857449;0.913460 0.856056 0.852155;0.911030 0.850938 0.846868;0.908621 0.845827 0.841590;0.906236 0.840723 0.836320;0.903870 0.835626 0.831060;0.901525 0.830536 0.825808;0.899200 0.825453 0.820565;0.896893 0.820378 0.815332;0.894604 0.815310 0.810109;0.892333 0.810248 0.804895;0.890078 0.805194 0.799692;0.887839 0.800148 0.794499;0.885617 0.795108 0.789317;0.883410 0.790075 0.784144;0.881217 0.785049 0.778983;0.879039 0.780031 0.773832;0.876875 0.775019 0.768692;0.874723 0.770014 0.763564;0.872585 0.765015 0.758446;0.870459 0.760024 0.753339;0.868345 0.755039 0.748244;0.866242 0.750061 0.743160;0.864151 0.745089 0.738088;0.862070 0.740124 0.733027;0.860000 0.735165 0.727978;0.857940 0.730213 0.722940;0.855890 0.725266 0.717914;0.853848 0.720326 0.712900;0.851816 0.715392 0.707898;0.849792 0.710464 0.702908;0.847777 0.705542 0.697930;0.845769 0.700626 0.692965;0.843769 0.695715 0.688012;0.841776 0.690810 0.683071;0.839790 0.685911 0.678142;0.837811 0.681016 0.673226;0.835838 0.676128 0.668323;0.833871 0.671244 0.663433;0.831909 0.666366 0.658555;0.829953 0.661492 0.653690;0.828002 0.656624 0.648839;0.826056 0.651760 0.644000;0.824114 0.646901 0.639175;0.822177 0.642047 0.634363;0.820243 0.637197 0.629564;0.818312 0.632352 0.624780;0.816385 0.627511 0.620009;0.814460 0.622674 0.615252;0.812539 0.617841 0.610508;0.810621 0.613012 0.605779;0.808704 0.608186 0.601064;0.806788 0.603365 0.596364;0.804875 0.598547 0.591678;0.802963 0.593732 0.587007;0.801052 0.588921 0.582351;0.799142 0.584113 0.577710;0.797232 0.579308 0.573084;0.795322 0.574507 0.568474;0.793413 0.569707 0.563879;0.791502 0.564911 0.559300;0.789592 0.560117 0.554737;0.787681 0.555325 0.550191;0.785768 0.550535 0.545661;0.783854 0.545748 0.541148;0.781939 0.540963 0.536652;0.780021 0.536179 0.532174;0.778101 0.531397 0.527713;0.776179 0.526617 0.523270;0.774254 0.521838 0.518846;0.772326 0.517059 0.514440;0.770395 0.512282 0.510053;0.768460 0.507506 0.505685;0.766521 0.502731 0.501338;0.764578 0.497956 0.497010;0.762631 0.493181 0.492703;0.760679 0.488406 0.488417;0.758722 0.483632 0.484153;0.756760 0.478857 0.479911;0.754792 0.474081 0.475692;0.752818 0.469305 0.471496;0.750838 0.464528 0.467324;0.748851 0.459750 0.463177;0.746857 0.454971 0.459055;0.744857 0.450191 0.454959;0.742848 0.445409 0.450890;0.740832 0.440625 0.446850;0.738807 0.435839 0.442838;0.736773 0.431051 0.438856;0.734730 0.426260 0.434905;0.732677 0.421467 0.430986;0.730614 0.416671 0.427101;0.728541 0.411872 0.423251;0.726456 0.407070 0.419438;0.724359 0.402265 0.415663;0.722249 0.397457 0.411928;0.720126 0.392645 0.408236;0.717989 0.387830 0.404588;0.715838 0.383011 0.400987;0.713670 0.378189 0.397436;0.711485 0.373364 0.393938;0.709281 0.368536 0.390496;0.707058 0.363705 0.387114;0.704813 0.358872 0.383796;0.702545 0.354038 0.380548;0.700251 0.349205 0.377374;0.697929 0.344372 0.374281;0.695575 0.339542 0.371275;0.693185 0.334718 0.368365;0.690755 0.329903 0.365558;0.688280 0.325101 0.362866;0.685753 0.320317 0.360298;0.683164 0.315559 0.357867;0.680506 0.310834 0.355586;0.677765 0.306155 0.353467;0.674928 0.301535 0.351525;0.671979 0.296990 0.349770;0.668902 0.292541 0.348210;0.665678 0.288208 0.346848;0.662294 0.284011 0.345676;0.658736 0.279968 0.344682;0.655001 0.276093 0.343842;0.651090 0.272392 0.343127;0.647011 0.268864 0.342506;0.642777 0.265501 0.341949;0.638404 0.262292 0.341429;0.633908 0.259224 0.340925;0.629306 0.256281 0.340420;0.624614 0.253451 0.339901;0.619843 0.250720 0.339359;0.615006 0.248076 0.338789;0.610113 0.245510 0.338185;0.605172 0.243011 0.337544;0.600190 0.240573 0.336866;0.595174 0.238188 0.336149;0.590128 0.235850 0.335393;0.585057 0.233555 0.334597;0.579966 0.231297 0.333762;0.574856 0.229072 0.332888;0.569732 0.226878 0.331977;0.564594 0.224711 0.331027;0.559447 0.222568 0.330041;0.554291 0.220447 0.329018;0.549128 0.218345 0.327959;0.543960 0.216261 0.326865;0.538788 0.214193 0.325736;0.533613 0.212139 0.324574;0.528435 0.210098 0.323377;0.523257 0.208068 0.322149;0.518079 0.206048 0.320887;0.512901 0.204038 0.319594;0.507724 0.202035 0.318270;0.502549 0.200040 0.316914;0.497376 0.198050 0.315528;0.492206 0.196066 0.314112;0.487038 0.194087 0.312666;0.481875 0.192112 0.311190;0.476715 0.190139 0.309685;0.471559 0.188170 0.308152;0.466408 0.186202 0.306589;0.461262 0.184236 0.304999;0.456120 0.182271 0.303380;0.450984 0.180306 0.301734;0.445853 0.178341 0.300060;0.440727 0.176375 0.298358;0.435607 0.174409 0.296630;0.430492 0.172441 0.294874;0.425384 0.170471 0.293091;0.420281 0.168500 0.291282;0.415185 0.166525 0.289446;0.410094 0.164548 0.287583;0.405010 0.162568 0.285694;0.399932 0.160584 0.283779;0.394860 0.158596 0.281837;0.389794 0.156604 0.279869;0.384735 0.154607 0.277875;0.379682 0.152605 0.275855;0.374635 0.150599 0.273809;0.369594 0.148587 0.271737;0.364560 0.146569 0.269639;0.359532 0.144545 0.267514;0.354510 0.142515 0.265364;0.349495 0.140478 0.263188;0.344485 0.138435 0.260986;0.339482 0.136384 0.258758;0.334484 0.134326 0.256503;0.329493 0.132260 0.254223;0.324507 0.130186 0.251916;0.319527 0.128104 0.249582;0.314553 0.126013 0.247223;0.309584 0.123913 0.244837;0.304621 0.121804 0.242424;0.299664 0.119686 0.239985;0.294711 0.117558 0.237518;0.289764 0.115419 0.235025;0.284822 0.113271 0.232504;0.279884 0.111111 0.229957;0.274952 0.108941 0.227381;0.270023 0.106759 0.224778;0.265100 0.104565 0.222148;0.260180 0.102359 0.219489;0.255265 0.100141 0.216801;0.250353 0.097910 0.214086;0.245445 0.095665 0.211341;0.240541 0.093407 0.208567;0.235640 0.091135 0.205764;0.230741 0.088847 0.202931;0.225846 0.086545 0.200068;0.220953 0.084227 0.197175;0.216062 0.081893 0.194251;0.211173 0.079543 0.191295;0.206285 0.077175 0.188308;0.201399 0.074789 0.185290;0.196514 0.072384 0.182238;0.191629 0.069961 0.179154;0.186745 0.067517 0.176037;0.181861 0.065052 0.172885;0.176976 0.062566 0.169699;0.172090 0.060057 0.166478;0.167202 0.057524 0.163221;0.162313 0.054967 0.159927;0.157421 0.052384 0.156597;0.152526 0.049773 0.153228;0.147627 0.047134 0.149821;0.142724 0.044465 0.146375;0.137816 0.041765 0.142888;0.132903 0.039021 0.139360;0.127983 0.036318 0.135790;0.123056 0.033693 0.132176;];

num = size(raw,1);

vec = linspace(0,num+1,N+2);
map = interp1(1:num,raw,vec(2:N+1),'linear','extrap');

map = max(0,min(1,map));
end