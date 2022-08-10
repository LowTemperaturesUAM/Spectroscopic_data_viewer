function map = cm_watermelon(N) 

if nargin<1 || isnumeric(N)&&isequal(N,[])
N=256;
end

raw = [0.593577 0.989836 0.102981;0.585435 0.985864 0.107478;0.577299 0.981895 0.111813;0.569169 0.977929 0.116003;0.561046 0.973966 0.120062;0.552928 0.970005 0.124002;0.544817 0.966047 0.127834;0.536713 0.962091 0.131567;0.528615 0.958136 0.135208;0.520525 0.954183 0.138765;0.512443 0.950231 0.142244;0.504369 0.946279 0.145650;0.496304 0.942328 0.148990;0.488249 0.938376 0.152266;0.480205 0.934425 0.155483;0.472173 0.930472 0.158645;0.464155 0.926518 0.161754;0.456151 0.922562 0.164814;0.448163 0.918604 0.167829;0.440193 0.914644 0.170799;0.432243 0.910681 0.173727;0.424314 0.906714 0.176616;0.416410 0.902744 0.179465;0.408533 0.898769 0.182279;0.400685 0.894789 0.185057;0.392871 0.890804 0.187800;0.385093 0.886813 0.190510;0.377356 0.882816 0.193186;0.369663 0.878812 0.195831;0.362018 0.874801 0.198444;0.354428 0.870783 0.201024;0.346898 0.866756 0.203573;0.339432 0.862720 0.206090;0.332037 0.858675 0.208575;0.324720 0.854621 0.211028;0.317488 0.850556 0.213447;0.310348 0.846481 0.215832;0.303308 0.842395 0.218183;0.296376 0.838298 0.220498;0.289560 0.834189 0.222776;0.282871 0.830068 0.225016;0.276317 0.825935 0.227217;0.269908 0.821789 0.229376;0.263654 0.817631 0.231494;0.257564 0.813460 0.233567;0.251648 0.809276 0.235595;0.245917 0.805079 0.237577;0.240380 0.800869 0.239509;0.235047 0.796647 0.241392;0.229927 0.792412 0.243223;0.225028 0.788164 0.245000;0.220358 0.783904 0.246723;0.215925 0.779633 0.248390;0.211735 0.775349 0.249999;0.207793 0.771055 0.251550;0.204104 0.766749 0.253042;0.200670 0.762433 0.254474;0.197492 0.758108 0.255844;0.194572 0.753773 0.257153;0.191907 0.749430 0.258399;0.189496 0.745078 0.259583;0.187334 0.740719 0.260704;0.185416 0.736353 0.261763;0.183737 0.731981 0.262758;0.182287 0.727603 0.263691;0.181059 0.723221 0.264562;0.180044 0.718834 0.265371;0.179230 0.714443 0.266119;0.178608 0.710049 0.266806;0.178166 0.705653 0.267433;0.177893 0.701254 0.268001;0.177777 0.696855 0.268510;0.177806 0.692454 0.268962;0.177968 0.688054 0.269357;0.178254 0.683654 0.269697;0.178650 0.679254 0.269982;0.179147 0.674856 0.270213;0.179734 0.670459 0.270392;0.180401 0.666065 0.270520;0.181139 0.661673 0.270597;0.181939 0.657284 0.270625;0.182793 0.652898 0.270604;0.183692 0.648516 0.270537;0.184630 0.644138 0.270423;0.185599 0.639765 0.270265;0.186593 0.635396 0.270063;0.187607 0.631032 0.269818;0.188635 0.626674 0.269531;0.189671 0.622321 0.269203;0.190712 0.617973 0.268835;0.191753 0.613632 0.268429;0.192790 0.609296 0.267985;0.193820 0.604967 0.267504;0.194840 0.600645 0.266986;0.195847 0.596329 0.266434;0.196837 0.592020 0.265847;0.197810 0.587718 0.265227;0.198762 0.583423 0.264574;0.199692 0.579135 0.263890;0.200598 0.574855 0.263174;0.201479 0.570582 0.262429;0.202332 0.566317 0.261653;0.203158 0.562059 0.260849;0.203955 0.557809 0.260017;0.204722 0.553567 0.259158;0.205457 0.549333 0.258271;0.206161 0.545107 0.257359;0.206833 0.540888 0.256421;0.207473 0.536678 0.255458;0.208079 0.532475 0.254471;0.208651 0.528281 0.253460;0.209190 0.524095 0.252425;0.209694 0.519917 0.251369;0.210164 0.515747 0.250290;0.210600 0.511586 0.249189;0.211001 0.507432 0.248067;0.211367 0.503287 0.246925;0.211699 0.499150 0.245762;0.211996 0.495021 0.244580;0.212258 0.490900 0.243378;0.212486 0.486787 0.242157;0.212679 0.482683 0.240918;0.212838 0.478586 0.239660;0.212962 0.474498 0.238385;0.213052 0.470418 0.237092;0.213109 0.466346 0.235783;0.213131 0.462282 0.234456;0.213120 0.458226 0.233113;0.213075 0.454177 0.231755;0.212998 0.450137 0.230380;0.212887 0.446105 0.228990;0.212743 0.442080 0.227585;0.212566 0.438063 0.226165;0.212358 0.434054 0.224731;0.212117 0.430053 0.223282;0.211844 0.426059 0.221819;0.211539 0.422073 0.220343;0.211203 0.418095 0.218853;0.210835 0.414124 0.217349;0.210437 0.410160 0.215833;0.210007 0.406204 0.214304;0.209547 0.402255 0.212762;0.209057 0.398313 0.211207;0.208536 0.394378 0.209641;0.207986 0.390451 0.208062;0.207406 0.386530 0.206472;0.206796 0.382617 0.204870;0.206157 0.378710 0.203256;0.205490 0.374810 0.201631;0.204793 0.370917 0.199995;0.204067 0.367031 0.198348;0.203314 0.363151 0.196690;0.202531 0.359277 0.195022;0.201721 0.355410 0.193342;0.200883 0.351550 0.191653;0.200017 0.347695 0.189953;0.199124 0.343847 0.188243;0.198203 0.340005 0.186523;0.197255 0.336168 0.184793;0.196280 0.332338 0.183053;0.195279 0.328513 0.181304;0.194250 0.324694 0.179545;0.193195 0.320881 0.177776;0.192113 0.317073 0.175998;0.191005 0.313271 0.174210;0.189871 0.309473 0.172414;0.188711 0.305681 0.170608;0.187525 0.301894 0.168793;0.186313 0.298112 0.166969;0.185075 0.294335 0.165136;0.183812 0.290562 0.163294;0.182523 0.286794 0.161444;0.181208 0.283031 0.159584;0.179868 0.279272 0.157716;0.178503 0.275517 0.155839;0.177112 0.271766 0.153953;0.175697 0.268019 0.152059;0.174256 0.264276 0.150156;0.172789 0.260537 0.148245;0.171298 0.256801 0.146325;0.169781 0.253069 0.144396;0.168240 0.249340 0.142459;0.166673 0.245614 0.140513;0.165081 0.241891 0.138559;0.163464 0.238171 0.136596;0.161822 0.234453 0.134625;0.160155 0.230738 0.132645;0.158462 0.227026 0.130657;0.156744 0.223315 0.128660;0.155001 0.219606 0.126654;0.153232 0.215899 0.124640;0.151438 0.212194 0.122617;0.149618 0.208490 0.120585;0.147772 0.204788 0.118545;0.145900 0.201086 0.116495;0.144002 0.197385 0.114437;0.142078 0.193684 0.112370;0.140128 0.189984 0.110293;0.138151 0.186284 0.108208;0.136148 0.182584 0.106113;0.134117 0.178884 0.104009;0.132059 0.175182 0.101895;0.129974 0.171480 0.099772;0.127861 0.167777 0.097639;0.125720 0.164072 0.095496;0.123550 0.160365 0.093343;0.121352 0.156656 0.091179;0.119125 0.152945 0.089006;0.116868 0.149231 0.086822;0.114582 0.145514 0.084626;0.112265 0.141794 0.082420;0.109917 0.138069 0.080203;0.107537 0.134341 0.077974;0.105126 0.130607 0.075733;0.102682 0.126869 0.073480;0.100206 0.123125 0.071215;0.097695 0.119374 0.068936;0.095150 0.115617 0.066644;0.092569 0.111853 0.064339;0.089952 0.108082 0.062020;0.087299 0.104302 0.059685;0.084607 0.100513 0.057336;0.081876 0.096714 0.054970;0.079105 0.092905 0.052589;0.076292 0.089084 0.050189;0.073437 0.085252 0.047772;0.070539 0.081406 0.045336;0.067594 0.077547 0.042880;0.064603 0.073672 0.040402;0.061562 0.069781 0.037908;0.058471 0.065873 0.035483;0.055328 0.061946 0.033129;0.052129 0.057998 0.030846;0.048873 0.054029 0.028633;0.045557 0.050035 0.026491;0.042179 0.046016 0.024420;0.038727 0.041968 0.022420;0.035333 0.037894 0.020493;0.032054 0.033991 0.018638;0.028895 0.030301 0.016855;0.025860 0.026823 0.015147;0.022956 0.023555 0.013512;0.020187 0.020497 0.011954;0.017559 0.017648 0.010471;0.015080 0.015007 0.009067;0.012755 0.012573 0.007743;0.010592 0.010346 0.006501;0.008598 0.008327 0.005345;0.006782 0.006517 0.004277;0.005153 0.004915 0.003304;0.003720 0.003525 0.002431;0.002494 0.002350 0.001665;0.001488 0.001396 0.001019;0.000718 0.000672 0.000506;0.000207 0.000193 0.000151;0.000000 0.000000 0.000000;0.000238 0.000179 0.000173;0.000844 0.000614 0.000592;0.001784 0.001260 0.001212;0.003047 0.002097 0.002011;0.004631 0.003110 0.002975;0.006533 0.004290 0.004095;0.008755 0.005629 0.005362;0.011297 0.007119 0.006769;0.014162 0.008756 0.008310;0.017352 0.010534 0.009982;0.020870 0.012451 0.011779;0.024719 0.014501 0.013698;0.028903 0.016682 0.015737;0.033425 0.018990 0.017891;0.038289 0.021424 0.020159;0.043384 0.023979 0.022538;0.048440 0.026655 0.025025;0.053463 0.029449 0.027619;0.058456 0.032358 0.030318;0.063423 0.035382 0.033120;0.068366 0.038517 0.036024;0.073288 0.041729 0.039028;0.078190 0.044894 0.042082;0.083075 0.048019 0.045089;0.087944 0.051107 0.048060;0.092799 0.054158 0.050996;0.097642 0.057176 0.053899;0.102472 0.060161 0.056772;0.107293 0.063114 0.059614;0.112104 0.066038 0.062429;0.116908 0.068933 0.065217;0.121704 0.071800 0.067979;0.126494 0.074641 0.070717;0.131279 0.077456 0.073430;0.136059 0.080246 0.076122;0.140834 0.083013 0.078792;0.145607 0.085756 0.081441;0.150377 0.088476 0.084071;0.155145 0.091175 0.086681;0.159912 0.093853 0.089273;0.164678 0.096510 0.091847;0.169443 0.099147 0.094405;0.174209 0.101765 0.096945;0.178975 0.104364 0.099471;0.183742 0.106944 0.101981;0.188510 0.109506 0.104476;0.193281 0.112051 0.106957;0.198053 0.114578 0.109425;0.202828 0.117089 0.111880;0.207606 0.119583 0.114323;0.212387 0.122061 0.116753;0.217172 0.124523 0.119171;0.221960 0.126970 0.121579;0.226753 0.129402 0.123975;0.231550 0.131818 0.126362;0.236352 0.134220 0.128738;0.241159 0.136608 0.131104;0.245971 0.138981 0.133462;0.250789 0.141340 0.135811;0.255612 0.143686 0.138151;0.260441 0.146018 0.140483;0.265277 0.148337 0.142807;0.270119 0.150643 0.145124;0.274968 0.152936 0.147434;0.279823 0.155216 0.149737;0.284686 0.157483 0.152034;0.289556 0.159738 0.154325;0.294434 0.161981 0.156610;0.299319 0.164211 0.158889;0.304212 0.166429 0.161164;0.309113 0.168636 0.163434;0.314022 0.170830 0.165699;0.318940 0.173013 0.167960;0.323866 0.175185 0.170217;0.328801 0.177345 0.172471;0.333744 0.179493 0.174722;0.338697 0.181631 0.176970;0.343659 0.183757 0.179215;0.348630 0.185872 0.181458;0.353611 0.187976 0.183700;0.358601 0.190069 0.185939;0.363601 0.192151 0.188178;0.368611 0.194222 0.190416;0.373631 0.196283 0.192653;0.378661 0.198332 0.194890;0.383701 0.200371 0.197127;0.388752 0.202400 0.199365;0.393813 0.204418 0.201604;0.398884 0.206426 0.203844;0.403967 0.208423 0.206086;0.409060 0.210409 0.208330;0.414165 0.212385 0.210577;0.419280 0.214352 0.212827;0.424407 0.216307 0.215080;0.429544 0.218252 0.217337;0.434693 0.220187 0.219598;0.439854 0.222112 0.221865;0.445026 0.224027 0.224136;0.450209 0.225931 0.226414;0.455405 0.227825 0.228698;0.460612 0.229709 0.230989;0.465831 0.231583 0.233287;0.471061 0.233447 0.235594;0.476303 0.235300 0.237910;0.481558 0.237144 0.240235;0.486824 0.238977 0.242571;0.492102 0.240801 0.244918;0.497392 0.242614 0.247277;0.502694 0.244418 0.249648;0.508008 0.246211 0.252033;0.513334 0.247995 0.254433;0.518672 0.249768 0.256848;0.524021 0.251533 0.259280;0.529382 0.253287 0.261730;0.534755 0.255031 0.264199;0.540139 0.256766 0.266688;0.545535 0.258492 0.269199;0.550941 0.260208 0.271734;0.556359 0.261915 0.274293;0.561787 0.263613 0.276879;0.567225 0.265302 0.279494;0.572672 0.266983 0.282140;0.578129 0.268655 0.284819;0.583595 0.270320 0.287534;0.589069 0.271977 0.290287;0.594550 0.273627 0.293082;0.600037 0.275272 0.295921;0.605529 0.276910 0.298809;0.611026 0.278545 0.301749;0.616524 0.280176 0.304747;0.622024 0.281805 0.307806;0.627521 0.283433 0.310934;0.633014 0.285064 0.314135;0.638500 0.286699 0.317418;0.643974 0.288342 0.320789;0.649433 0.289996 0.324258;0.654870 0.291666 0.327835;0.660279 0.293358 0.331529;0.665651 0.295079 0.335353;0.670978 0.296838 0.339318;0.676248 0.298646 0.343437;0.681447 0.300515 0.347721;0.686561 0.302460 0.352181;0.691574 0.304497 0.356825;0.696470 0.306643 0.361655;0.701233 0.308915 0.366669;0.705851 0.311326 0.371857;0.710316 0.313886 0.377203;0.714624 0.316603 0.382687;0.718778 0.319475 0.388285;0.722784 0.322497 0.393973;0.726650 0.325663 0.399729;0.730388 0.328960 0.405533;0.734010 0.332379 0.411370;0.737527 0.335906 0.417227;0.740949 0.339532 0.423093;0.744287 0.343246 0.428962;0.747548 0.347039 0.434828;0.750740 0.350903 0.440687;0.753869 0.354830 0.446536;0.756942 0.358815 0.452374;0.759964 0.362851 0.458197;0.762938 0.366934 0.464007;0.765869 0.371060 0.469801;0.768760 0.375226 0.475580;0.771614 0.379427 0.481344;0.774433 0.383661 0.487092;0.777220 0.387926 0.492825;0.779976 0.392219 0.498543;0.782704 0.396538 0.504245;0.785406 0.400882 0.509933;0.788083 0.405250 0.515607;0.790735 0.409639 0.521265;0.793366 0.414048 0.526910;0.795974 0.418477 0.532541;0.798563 0.422925 0.538159;0.801132 0.427390 0.543763;0.803683 0.431872 0.549354;0.806217 0.436370 0.554932;0.808734 0.440884 0.560498;0.811234 0.445412 0.566051;0.813720 0.449955 0.571592;0.816191 0.454511 0.577121;0.818648 0.459081 0.582638;0.821091 0.463664 0.588143;0.823522 0.468259 0.593637;0.825941 0.472867 0.599119;0.828348 0.477487 0.604591;0.830744 0.482119 0.610051;0.833129 0.486762 0.615500;0.835504 0.491417 0.620938;0.837869 0.496082 0.626366;0.840225 0.500759 0.631782;0.842572 0.505446 0.637189;0.844911 0.510144 0.642585;0.847241 0.514852 0.647970;0.849565 0.519571 0.653346;0.851880 0.524300 0.658711;0.854189 0.529039 0.664066;0.856492 0.533788 0.669411;0.858789 0.538548 0.674746;0.861080 0.543317 0.680071;0.863365 0.548096 0.685387;0.865646 0.552884 0.690692;0.867922 0.557683 0.695988;0.870194 0.562491 0.701275;0.872462 0.567309 0.706551;0.874726 0.572136 0.711818;0.876988 0.576973 0.717076;0.879246 0.581820 0.722324;0.881502 0.586676 0.727562;0.883756 0.591542 0.732791;0.886008 0.596418 0.738010;0.888258 0.601303 0.743221;0.890508 0.606197 0.748421;0.892756 0.611101 0.753613;0.895005 0.616015 0.758795;0.897253 0.620938 0.763968;0.899501 0.625871 0.769131;0.901750 0.630814 0.774285;0.904000 0.635766 0.779430;0.906250 0.640728 0.784565;0.908503 0.645700 0.789691;0.910757 0.650681 0.794808;0.913014 0.655672 0.799916;0.915273 0.660673 0.805014;0.917535 0.665684 0.810102;0.919801 0.670704 0.815182;0.922069 0.675735 0.820252;0.924342 0.680775 0.825313;0.926619 0.685826 0.830364;0.928901 0.690886 0.835406;0.931188 0.695957 0.840438;0.933480 0.701037 0.845461;0.935778 0.706128 0.850474;0.938081 0.711229 0.855477;0.940392 0.716340 0.860471;0.942708 0.721462 0.865456;0.945032 0.726594 0.870430;0.947364 0.731736 0.875395;0.949703 0.736889 0.880349;0.952051 0.742052 0.885294;0.954407 0.747226 0.890229;0.956772 0.752411 0.895153;0.959146 0.757606 0.900067;0.961530 0.762812 0.904971;0.963924 0.768029 0.909865;0.966329 0.773257 0.914748;0.968744 0.778496 0.919620;0.971171 0.783745 0.924481;0.973610 0.789006 0.929332;0.976061 0.794278 0.934171;0.978524 0.799561 0.938999;0.981001 0.804855 0.943816;0.983490 0.810161 0.948620;];

num = size(raw,1);

vec = linspace(0,num+1,N+2);
map = interp1(1:num,raw,vec(2:N+1),'linear','extrap');

map = max(0,min(1,map));
end