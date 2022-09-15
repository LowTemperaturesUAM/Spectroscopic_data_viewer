function map = cm_tropical(N) 

if nargin<1 || isnumeric(N)&&isequal(N,[])
N=256;
end

raw = [0.564552 0.054114 0.646281;0.569448 0.053685 0.642764;0.574346 0.053149 0.639217;0.579245 0.052510 0.635636;0.584145 0.051771 0.632018;0.589045 0.050938 0.628361;0.593943 0.050013 0.624660;0.598840 0.049000 0.620914;0.603734 0.047905 0.617120;0.608624 0.046730 0.613274;0.613509 0.045481 0.609375;0.618387 0.044162 0.605420;0.623259 0.042777 0.601406;0.628122 0.041334 0.597332;0.632976 0.039830 0.593195;0.637819 0.038293 0.588994;0.642650 0.036755 0.584727;0.647467 0.035226 0.580391;0.652269 0.033718 0.575986;0.657055 0.032242 0.571510;0.661823 0.030810 0.566962;0.666571 0.029434 0.562341;0.671299 0.028128 0.557646;0.676003 0.026902 0.552875;0.680683 0.025772 0.548030;0.685337 0.024750 0.543108;0.689964 0.023852 0.538111;0.694560 0.023090 0.533037;0.699124 0.022481 0.527888;0.703655 0.022040 0.522662;0.708150 0.021783 0.517362;0.712608 0.021725 0.511987;0.717025 0.021885 0.506539;0.721401 0.022278 0.501020;0.725733 0.022923 0.495429;0.730019 0.023837 0.489769;0.734256 0.025039 0.484042;0.738443 0.026548 0.478249;0.742576 0.028383 0.472394;0.746655 0.030564 0.466479;0.750677 0.033110 0.460505;0.754639 0.036041 0.454478;0.758539 0.039377 0.448399;0.762375 0.043045 0.442273;0.766145 0.046922 0.436102;0.769846 0.051001 0.429891;0.773477 0.055263 0.423644;0.777036 0.059693 0.417365;0.780520 0.064275 0.411058;0.783928 0.068998 0.404728;0.787257 0.073848 0.398380;0.790507 0.078814 0.392018;0.793675 0.083886 0.385647;0.796760 0.089056 0.379272;0.799761 0.094314 0.372898;0.802676 0.099652 0.366529;0.805504 0.105064 0.360171;0.808246 0.110542 0.353828;0.810899 0.116081 0.347505;0.813463 0.121674 0.341206;0.815938 0.127316 0.334935;0.818323 0.133002 0.328697;0.820619 0.138727 0.322495;0.822826 0.144486 0.316333;0.824943 0.150275 0.310214;0.826970 0.156089 0.304142;0.828910 0.161926 0.298119;0.830761 0.167780 0.292147;0.832525 0.173650 0.286229;0.834202 0.179531 0.280367;0.835794 0.185421 0.274562;0.837301 0.191316 0.268815;0.838725 0.197215 0.263128;0.840065 0.203115 0.257500;0.841325 0.209013 0.251932;0.842504 0.214908 0.246425;0.843604 0.220797 0.240978;0.844626 0.226680 0.235591;0.845572 0.232554 0.230262;0.846442 0.238418 0.224991;0.847238 0.244271 0.219777;0.847961 0.250112 0.214619;0.848612 0.255941 0.209515;0.849192 0.261755 0.204464;0.849703 0.267554 0.199464;0.850144 0.273339 0.194512;0.850519 0.279108 0.189608;0.850826 0.284860 0.184749;0.851068 0.290597 0.179933;0.851244 0.296317 0.175157;0.851357 0.302019 0.170419;0.851406 0.307706 0.165718;0.851392 0.313375 0.161050;0.851316 0.319028 0.156414;0.851179 0.324663 0.151806;0.850980 0.330282 0.147225;0.850721 0.335885 0.142668;0.850402 0.341471 0.138133;0.850023 0.347041 0.133617;0.849585 0.352595 0.129117;0.849087 0.358134 0.124632;0.848530 0.363657 0.120159;0.847915 0.369165 0.115695;0.847240 0.374659 0.111239;0.846507 0.380138 0.106788;0.845716 0.385604 0.102340;0.844866 0.391055 0.097894;0.843956 0.396493 0.093446;0.842988 0.401918 0.088997;0.841962 0.407330 0.084543;0.840875 0.412730 0.080084;0.839730 0.418118 0.075619;0.838525 0.423494 0.071148;0.837260 0.428858 0.066669;0.835934 0.434212 0.062184;0.834549 0.439554 0.057694;0.833102 0.444886 0.053201;0.831594 0.450207 0.048709;0.830024 0.455518 0.044223;0.828393 0.460819 0.039742;0.826698 0.466111 0.035410;0.824941 0.471392 0.031399;0.823120 0.476665 0.027712;0.821235 0.481928 0.024353;0.819286 0.487183 0.021325;0.817272 0.492428 0.018634;0.815191 0.497664 0.016283;0.813045 0.502892 0.014279;0.810832 0.508111 0.012628;0.808552 0.513322 0.011337;0.806204 0.518524 0.010413;0.803787 0.523718 0.009865;0.801301 0.528903 0.009700;0.798745 0.534079 0.009928;0.796119 0.539247 0.010559;0.793422 0.544407 0.011603;0.790653 0.549558 0.013071;0.787811 0.554701 0.014975;0.784896 0.559835 0.017327;0.781906 0.564960 0.020139;0.778843 0.570077 0.023426;0.775703 0.575184 0.027201;0.772487 0.580283 0.031479;0.769194 0.585373 0.036275;0.765823 0.590454 0.041577;0.762372 0.595525 0.047047;0.758842 0.600588 0.052609;0.755231 0.605640 0.058251;0.751537 0.610683 0.063964;0.747761 0.615717 0.069740;0.743901 0.620741 0.075575;0.739955 0.625754 0.081466;0.735923 0.630758 0.087410;0.731803 0.635751 0.093404;0.727594 0.640734 0.099448;0.723295 0.645706 0.105542;0.718905 0.650667 0.111685;0.714421 0.655618 0.117878;0.709842 0.660557 0.124121;0.705167 0.665485 0.130415;0.700395 0.670401 0.136760;0.695522 0.675306 0.143159;0.690549 0.680198 0.149611;0.685473 0.685078 0.156119;0.680291 0.689945 0.162684;0.675003 0.694800 0.169308;0.669606 0.699641 0.175992;0.664099 0.704468 0.182737;0.658479 0.709281 0.189547;0.652744 0.714080 0.196421;0.646893 0.718863 0.203363;0.640922 0.723632 0.210374;0.634831 0.728384 0.217456;0.628616 0.733119 0.224611;0.622276 0.737837 0.231840;0.615809 0.742538 0.239146;0.609212 0.747219 0.246530;0.602485 0.751881 0.253994;0.595623 0.756523 0.261541;0.588627 0.761143 0.269170;0.581494 0.765742 0.276885;0.574222 0.770317 0.284687;0.566809 0.774868 0.292577;0.559256 0.779393 0.300556;0.551559 0.783892 0.308626;0.543719 0.788364 0.316787;0.535735 0.792806 0.325042;0.527605 0.797218 0.333389;0.519330 0.801598 0.341830;0.510910 0.805944 0.350365;0.502346 0.810256 0.358994;0.493638 0.814532 0.367717;0.484787 0.818769 0.376533;0.475796 0.822968 0.385442;0.466666 0.827125 0.394443;0.457400 0.831240 0.403534;0.448001 0.835310 0.412714;0.438474 0.839335 0.421980;0.428822 0.843312 0.431332;0.419050 0.847241 0.440765;0.409165 0.851119 0.450278;0.399172 0.854945 0.459867;0.389080 0.858719 0.469529;0.378897 0.862437 0.479259;0.368630 0.866101 0.489056;0.358290 0.869708 0.498913;0.347887 0.873257 0.508828;0.337435 0.876748 0.518794;0.326946 0.880179 0.528808;0.316434 0.883551 0.538866;0.305915 0.886863 0.548961;0.295408 0.890115 0.559090;0.284932 0.893306 0.569246;0.274506 0.896436 0.579426;0.264157 0.899506 0.589624;0.253910 0.902515 0.599836;0.243795 0.905465 0.610056;0.233844 0.908356 0.620281;0.224096 0.911188 0.630504;0.214591 0.913962 0.640724;0.205376 0.916679 0.650934;0.196501 0.919341 0.661131;0.188025 0.921947 0.671312;0.180010 0.924501 0.681472;0.172521 0.927001 0.691609;0.165631 0.929451 0.701721;0.159416 0.931852 0.711802;0.153946 0.934204 0.721851;0.149294 0.936510 0.731867;0.145521 0.938771 0.741847;0.142678 0.940989 0.751789;0.140799 0.943165 0.761693;0.139900 0.945300 0.771556;0.139974 0.947398 0.781377;0.140992 0.949458 0.791157;0.142906 0.951484 0.800895;0.145655 0.953475 0.810590;0.149162 0.955435 0.820242;0.153349 0.957365 0.829853;0.158132 0.959266 0.839421;0.163430 0.961139 0.848948;0.169167 0.962987 0.858435;0.175270 0.964811 0.867883;0.181676 0.966612 0.877293;0.188327 0.968391 0.886668;0.195173 0.970151 0.896006;0.202169 0.971891 0.905312;0.209277 0.973614 0.914588;0.216465 0.975321 0.923834;0.223704 0.977013 0.933054;0.230970 0.978690 0.942250;0.238243 0.980354 0.951423;0.245506 0.982006 0.960580;0.252743 0.983647 0.969718;0.259943 0.985277 0.978844;0.267097 0.986898 0.987961;];

num = size(raw,1);

vec = linspace(0,num+1,N+2);
map = interp1(1:num,raw,vec(2:N+1),'linear','extrap');

map = max(0,min(1,map));
end