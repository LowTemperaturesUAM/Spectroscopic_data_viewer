function map = cm_wildfire(N) 

if nargin<1 || isnumeric(N)&&isequal(N,[])
N=256;
end

raw = [0.574853 0.992751 0.164218;0.564647 0.988966 0.176537;0.554620 0.985138 0.188152;0.544765 0.981269 0.199156;0.535080 0.977360 0.209621;0.525558 0.973416 0.219609;0.516196 0.969437 0.229165;0.506989 0.965426 0.238330;0.497932 0.961385 0.247139;0.489024 0.957316 0.255619;0.480259 0.953221 0.263794;0.471635 0.949100 0.271686;0.463148 0.944956 0.279315;0.454795 0.940790 0.286695;0.446574 0.936604 0.293842;0.438482 0.932398 0.300770;0.430516 0.928174 0.307489;0.422675 0.923932 0.314010;0.414956 0.919674 0.320343;0.407357 0.915401 0.326496;0.399877 0.911114 0.332478;0.392514 0.906814 0.338295;0.385267 0.902500 0.343954;0.378133 0.898175 0.349463;0.371113 0.893839 0.354824;0.364204 0.889492 0.360045;0.357407 0.885136 0.365129;0.350719 0.880770 0.370083;0.344141 0.876396 0.374908;0.337670 0.872014 0.379611;0.331308 0.867624 0.384193;0.325052 0.863228 0.388660;0.318904 0.858825 0.393012;0.312862 0.854416 0.397254;0.306925 0.850002 0.401389;0.301095 0.845582 0.405419;0.295369 0.841158 0.409346;0.289749 0.836729 0.413174;0.284234 0.832297 0.416903;0.278825 0.827862 0.420537;0.273520 0.823423 0.424077;0.268320 0.818981 0.427526;0.263225 0.814537 0.430884;0.258235 0.810091 0.434154;0.253351 0.805643 0.437337;0.248571 0.801194 0.440435;0.243897 0.796744 0.443450;0.239328 0.792292 0.446382;0.234864 0.787840 0.449234;0.230505 0.783388 0.452006;0.226252 0.778936 0.454699;0.222104 0.774484 0.457316;0.218061 0.770033 0.459857;0.214123 0.765582 0.462322;0.210289 0.761133 0.464715;0.206560 0.756685 0.467034;0.202935 0.752238 0.469282;0.199414 0.747793 0.471459;0.195996 0.743350 0.473567;0.192680 0.738909 0.475606;0.189466 0.734471 0.477577;0.186352 0.730035 0.479481;0.183339 0.725603 0.481320;0.180424 0.721173 0.483092;0.177606 0.716747 0.484801;0.174884 0.712324 0.486446;0.172257 0.707905 0.488028;0.169722 0.703491 0.489549;0.167279 0.699080 0.491008;0.164924 0.694674 0.492407;0.162655 0.690272 0.493747;0.160471 0.685875 0.495027;0.158369 0.681483 0.496250;0.156346 0.677096 0.497416;0.154400 0.672715 0.498525;0.152528 0.668339 0.499578;0.150726 0.663969 0.500577;0.148993 0.659605 0.501521;0.147324 0.655246 0.502413;0.145716 0.650895 0.503251;0.144166 0.646549 0.504038;0.142671 0.642211 0.504775;0.141228 0.637879 0.505461;0.139832 0.633554 0.506098;0.138480 0.629236 0.506686;0.137169 0.624925 0.507227;0.135894 0.620622 0.507721;0.134654 0.616326 0.508169;0.133443 0.612038 0.508573;0.132260 0.607758 0.508932;0.131099 0.603486 0.509249;0.129957 0.599222 0.509523;0.128833 0.594966 0.509756;0.127721 0.590718 0.509948;0.126619 0.586479 0.510101;0.125523 0.582248 0.510216;0.124432 0.578025 0.510294;0.123341 0.573811 0.510335;0.122248 0.569606 0.510342;0.121150 0.565409 0.510313;0.120045 0.561221 0.510252;0.118930 0.557042 0.510159;0.117803 0.552871 0.510034;0.116662 0.548709 0.509880;0.115504 0.544556 0.509697;0.114327 0.540411 0.509487;0.113131 0.536275 0.509249;0.111912 0.532147 0.508987;0.110670 0.528028 0.508700;0.109404 0.523917 0.508390;0.108112 0.519814 0.508058;0.106793 0.515720 0.507705;0.105447 0.511633 0.507333;0.104072 0.507554 0.506942;0.102668 0.503483 0.506534;0.101236 0.499419 0.506109;0.099774 0.495362 0.505670;0.098283 0.491312 0.505216;0.096763 0.487268 0.504750;0.095215 0.483231 0.504271;0.093640 0.479200 0.503782;0.092038 0.475174 0.503284;0.090411 0.471154 0.502776;0.088760 0.467139 0.502262;0.087087 0.463128 0.501740;0.085394 0.459122 0.501213;0.083683 0.455119 0.500681;0.081958 0.451120 0.500146;0.080221 0.447123 0.499607;0.078476 0.443129 0.499067;0.076726 0.439136 0.498525;0.074976 0.435145 0.497982;0.073231 0.431154 0.497440;0.071496 0.427164 0.496898;0.069777 0.423173 0.496358;0.068079 0.419181 0.495820;0.066411 0.415187 0.495284;0.064779 0.411190 0.494751;0.063192 0.407191 0.494221;0.061657 0.403187 0.493694;0.060186 0.399179 0.493171;0.058787 0.395166 0.492651;0.057470 0.391146 0.492136;0.056248 0.387119 0.491623;0.055129 0.383084 0.491115;0.054127 0.379041 0.490609;0.053253 0.374988 0.490107;0.052518 0.370924 0.489606;0.051933 0.366849 0.489107;0.051508 0.362762 0.488609;0.051254 0.358661 0.488110;0.051180 0.354545 0.487610;0.051293 0.350414 0.487107;0.051598 0.346266 0.486599;0.052102 0.342101 0.486085;0.052806 0.337917 0.485563;0.053713 0.333713 0.485029;0.054820 0.329488 0.484482;0.056128 0.325242 0.483918;0.057631 0.320972 0.483333;0.059325 0.316677 0.482724;0.061203 0.312358 0.482085;0.063259 0.308012 0.481412;0.065484 0.303639 0.480699;0.067871 0.299238 0.479939;0.070408 0.294808 0.479124;0.073086 0.290349 0.478246;0.075897 0.285860 0.477295;0.078827 0.281342 0.476261;0.081869 0.276793 0.475131;0.085010 0.272216 0.473891;0.088237 0.267611 0.472525;0.091540 0.262979 0.471017;0.094904 0.258325 0.469346;0.098315 0.253650 0.467492;0.101756 0.248961 0.465429;0.105208 0.244261 0.463133;0.108651 0.239560 0.460576;0.112062 0.234867 0.457730;0.115414 0.230190 0.454567;0.118676 0.225544 0.451059;0.121818 0.220941 0.447184;0.124805 0.216396 0.442923;0.127603 0.211922 0.438266;0.130179 0.207532 0.433212;0.132506 0.203238 0.427769;0.134560 0.199047 0.421958;0.136326 0.194964 0.415804;0.137796 0.190991 0.409343;0.138967 0.187126 0.402613;0.139847 0.183366 0.395651;0.140444 0.179703 0.388496;0.140773 0.176130 0.381184;0.140848 0.172640 0.373747;0.140686 0.169224 0.366214;0.140304 0.165874 0.358610;0.139718 0.162583 0.350956;0.138944 0.159343 0.343271;0.137996 0.156147 0.335570;0.136886 0.152990 0.327866;0.135629 0.149866 0.320170;0.134234 0.146770 0.312491;0.132711 0.143696 0.304837;0.131071 0.140642 0.297213;0.129320 0.137604 0.289626;0.127467 0.134577 0.282078;0.125519 0.131560 0.274573;0.123481 0.128548 0.267114;0.121358 0.125541 0.259703;0.119157 0.122534 0.252342;0.116880 0.119527 0.245032;0.114532 0.116518 0.237774;0.112117 0.113504 0.230569;0.109638 0.110483 0.223416;0.107097 0.107455 0.216317;0.104498 0.104418 0.209270;0.101843 0.101370 0.202276;0.099133 0.098310 0.195334;0.096370 0.095237 0.188445;0.093556 0.092149 0.181605;0.090693 0.089045 0.174817;0.087781 0.085923 0.168078;0.084822 0.082783 0.161387;0.081816 0.079624 0.154744;0.078764 0.076443 0.148146;0.075666 0.073241 0.141594;0.072523 0.070014 0.135086;0.069335 0.066762 0.128620;0.066102 0.063484 0.122195;0.062823 0.060177 0.115809;0.059498 0.056841 0.109460;0.056126 0.053472 0.103147;0.052707 0.050071 0.096867;0.049239 0.046633 0.090620;0.045722 0.043158 0.084401;0.042153 0.039633 0.078209;0.038526 0.036150 0.072042;0.034989 0.032810 0.065896;0.031598 0.029616 0.059767;0.028356 0.026568 0.053653;0.025267 0.023668 0.047549;0.022333 0.020918 0.041451;0.019557 0.018319 0.035458;0.016944 0.015875 0.029978;0.014497 0.013587 0.025017;0.012220 0.011457 0.020555;0.010116 0.009490 0.016576;0.008189 0.007688 0.013061;0.006445 0.006056 0.009996;0.004888 0.004598 0.007364;0.003525 0.003319 0.005151;0.002362 0.002228 0.003343;0.001411 0.001332 0.001928;0.000682 0.000645 0.000898;0.000197 0.000187 0.000249;0.000000 0.000000 0.000000;0.000247 0.000170 0.000221;0.000880 0.000579 0.000783;0.001872 0.001179 0.001654;0.003216 0.001946 0.002824;0.004913 0.002863 0.004290;0.006967 0.003917 0.006052;0.009382 0.005097 0.008109;0.012166 0.006394 0.010464;0.015325 0.007800 0.013119;0.018867 0.009308 0.016076;0.022799 0.010910 0.019339;0.027131 0.012600 0.022911;0.031870 0.014373 0.026795;0.037027 0.016221 0.030994;0.042542 0.018141 0.035512;0.048063 0.020125 0.040352;0.053566 0.022170 0.045262;0.059055 0.024269 0.050139;0.064533 0.026419 0.054987;0.070003 0.028613 0.059808;0.075468 0.030847 0.064604;0.080931 0.033116 0.069379;0.086393 0.035416 0.074132;0.091857 0.037742 0.078866;0.097326 0.040087 0.083581;0.102799 0.042388 0.088279;0.108280 0.044621 0.092960;0.113769 0.046792 0.097624;0.119268 0.048901 0.102274;0.124778 0.050950 0.106908;0.130301 0.052938 0.111527;0.135837 0.054867 0.116131;0.141387 0.056736 0.120720;0.146953 0.058545 0.125294;0.152536 0.060294 0.129854;0.158136 0.061984 0.134398;0.163753 0.063614 0.138926;0.169390 0.065185 0.143438;0.175046 0.066695 0.147934;0.180723 0.068145 0.152412;0.186421 0.069533 0.156872;0.192140 0.070861 0.161313;0.197881 0.072127 0.165734;0.203645 0.073330 0.170134;0.209433 0.074470 0.174513;0.215244 0.075547 0.178868;0.221079 0.076559 0.183199;0.226939 0.077506 0.187504;0.232824 0.078388 0.191781;0.238734 0.079202 0.196029;0.244670 0.079949 0.200246;0.250632 0.080627 0.204430;0.256620 0.081235 0.208579;0.262635 0.081774 0.212691;0.268676 0.082241 0.216763;0.274744 0.082636 0.220793;0.280838 0.082957 0.224779;0.286959 0.083204 0.228717;0.293107 0.083376 0.232605;0.299281 0.083472 0.236439;0.305481 0.083491 0.240217;0.311707 0.083433 0.243934;0.317959 0.083297 0.247587;0.324236 0.083082 0.251172;0.330537 0.082788 0.254684;0.336862 0.082416 0.258121;0.343210 0.081965 0.261477;0.349580 0.081436 0.264747;0.355971 0.080829 0.267926;0.362382 0.080146 0.271011;0.368811 0.079389 0.273994;0.375256 0.078560 0.276872;0.381716 0.077662 0.279639;0.388189 0.076699 0.282288;0.394673 0.075676 0.284815;0.401164 0.074600 0.287214;0.407660 0.073475 0.289479;0.414158 0.072313 0.291606;0.420656 0.071122 0.293588;0.427148 0.069914 0.295422;0.433633 0.068702 0.297102;0.440105 0.067501 0.298624;0.446561 0.066328 0.299987;0.452996 0.065201 0.301186;0.459406 0.064142 0.302219;0.465786 0.063170 0.303087;0.472133 0.062310 0.303788;0.478441 0.061584 0.304325;0.484707 0.061015 0.304698;0.490926 0.060627 0.304911;0.497094 0.060440 0.304967;0.503210 0.060475 0.304872;0.509268 0.060746 0.304632;0.515267 0.061267 0.304252;0.521204 0.062046 0.303740;0.527078 0.063090 0.303103;0.532888 0.064398 0.302349;0.538632 0.065968 0.301485;0.544311 0.067792 0.300520;0.549923 0.069860 0.299461;0.555470 0.072162 0.298316;0.560952 0.074682 0.297092;0.566370 0.077406 0.295797;0.571725 0.080319 0.294436;0.577018 0.083404 0.293017;0.582251 0.086646 0.291545;0.587424 0.090031 0.290025;0.592540 0.093544 0.288463;0.597600 0.097173 0.286863;0.602605 0.100905 0.285228;0.607558 0.104729 0.283564;0.612460 0.108636 0.281873;0.617312 0.112616 0.280158;0.622116 0.116661 0.278422;0.626874 0.120763 0.276668;0.631586 0.124918 0.274897;0.636255 0.129118 0.273112;0.640881 0.133359 0.271315;0.645465 0.137637 0.269506;0.650010 0.141947 0.267687;0.654516 0.146286 0.265860;0.658984 0.150651 0.264025;0.663415 0.155041 0.262183;0.667810 0.159451 0.260336;0.672170 0.163881 0.258483;0.676496 0.168329 0.256625;0.680789 0.172793 0.254763;0.685049 0.177273 0.252896;0.689278 0.181766 0.251026;0.693475 0.186273 0.249152;0.697641 0.190792 0.247276;0.701778 0.195323 0.245396;0.705885 0.199865 0.243512;0.709963 0.204419 0.241626;0.714012 0.208982 0.239737;0.718033 0.213557 0.237844;0.722026 0.218141 0.235948;0.725992 0.222735 0.234049;0.729931 0.227339 0.232147;0.733843 0.231953 0.230241;0.737728 0.236577 0.228331;0.741587 0.241211 0.226418;0.745420 0.245854 0.224500;0.749227 0.250508 0.222579;0.753008 0.255172 0.220653;0.756763 0.259846 0.218722;0.760494 0.264530 0.216786;0.764198 0.269225 0.214845;0.767878 0.273931 0.212899;0.771532 0.278648 0.210948;0.775161 0.283375 0.208991;0.778765 0.288114 0.207027;0.782344 0.292865 0.205057;0.785898 0.297627 0.203081;0.789426 0.302401 0.201098;0.792930 0.307187 0.199108;0.796408 0.311985 0.197111;0.799862 0.316796 0.195106;0.803290 0.321620 0.193094;0.806692 0.326456 0.191074;0.810070 0.331306 0.189045;0.813422 0.336169 0.187008;0.816748 0.341045 0.184962;0.820049 0.345935 0.182908;0.823323 0.350840 0.180844;0.826573 0.355758 0.178771;0.829796 0.360690 0.176689;0.832992 0.365638 0.174597;0.836163 0.370599 0.172496;0.839307 0.375576 0.170384;0.842425 0.380568 0.168263;0.845515 0.385575 0.166131;0.848579 0.390598 0.163989;0.851616 0.395636 0.161836;0.854625 0.400690 0.159673;0.857608 0.405759 0.157500;0.860562 0.410845 0.155315;0.863489 0.415947 0.153121;0.866387 0.421066 0.150916;0.869258 0.426201 0.148700;0.872100 0.431352 0.146474;0.874914 0.436520 0.144238;0.877699 0.441705 0.141992;0.880455 0.446908 0.139736;0.883181 0.452127 0.137470;0.885879 0.457363 0.135195;0.888547 0.462617 0.132912;0.891185 0.467888 0.130620;0.893793 0.473177 0.128320;0.896371 0.478483 0.126012;0.898918 0.483807 0.123699;0.901435 0.489149 0.121379;0.903921 0.494509 0.119054;0.906376 0.499887 0.116725;0.908800 0.505282 0.114394;0.911193 0.510696 0.112061;0.913554 0.516128 0.109727;0.915883 0.521578 0.107395;0.918180 0.527046 0.105067;0.920444 0.532532 0.102743;0.922677 0.538037 0.100427;0.924876 0.543560 0.098120;0.927043 0.549102 0.095826;0.929177 0.554662 0.093547;0.931277 0.560240 0.091288;0.933344 0.565837 0.089050;0.935377 0.571453 0.086838;0.937377 0.577087 0.084657;0.939342 0.582740 0.082512;0.941273 0.588411 0.080407;0.943170 0.594101 0.078349;0.945032 0.599810 0.076342;0.946859 0.605537 0.074395;0.948651 0.611283 0.072515;0.950408 0.617047 0.070708;0.952130 0.622830 0.068984;0.953816 0.628632 0.067350;0.955466 0.634452 0.065816;0.957080 0.640292 0.064392;0.958658 0.646149 0.063087;0.960199 0.652026 0.061911;0.961704 0.657921 0.060874;0.963172 0.663835 0.059985;0.964603 0.669768 0.059255;0.965997 0.675719 0.058693;0.967353 0.681689 0.058306;0.968672 0.687678 0.058103;0.969953 0.693685 0.058090;0.971196 0.699711 0.058272;0.972401 0.705756 0.058654;0.973567 0.711820 0.059237;0.974695 0.717902 0.060024;0.975783 0.724003 0.061014;0.976833 0.730123 0.062204;0.977843 0.736262 0.063593;0.978814 0.742419 0.065177;0.979745 0.748596 0.066949;0.980636 0.754791 0.068904;0.981486 0.761004 0.071036;0.982296 0.767237 0.073338;0.983065 0.773489 0.075801;0.983793 0.779759 0.078419;0.984480 0.786049 0.081184;0.985125 0.792357 0.084088;0.985727 0.798685 0.087124;0.986288 0.805031 0.090285;0.986806 0.811397 0.093564;0.987281 0.817782 0.096954;0.987713 0.824186 0.100449;0.988101 0.830609 0.104044;0.988445 0.837051 0.107733;0.988745 0.843513 0.111511;0.988999 0.849994 0.115374;0.989209 0.856495 0.119316;0.989373 0.863016 0.123333;];

num = size(raw,1);

vec = linspace(0,num+1,N+2);
map = interp1(1:num,raw,vec(2:N+1),'linear','extrap');

map = max(0,min(1,map));
end