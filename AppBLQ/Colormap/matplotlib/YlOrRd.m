function map = YlOrRd(N)

if nargin<1 || isnumeric(N)&&isequal(N,[])

N=256;
else
	assert(isscalar(N)&&isfinite(N)&&isreal(N),...
		'SC:inferno:N:NotRealFiniteScalarNumeric',...
		'First argument <N> must be a real finite numeric scalar.')
end

raw = [1 1 0.8;1 0.997785467128028 0.794586697424068;1 0.995570934256055 0.789173394848135;1 0.993356401384083 0.783760092272203;1 0.991141868512111 0.778346789696271;1 0.988927335640138 0.772933487120338;1 0.986712802768166 0.767520184544406;1 0.984498269896194 0.762106881968474;1 0.982283737024221 0.756693579392541;1 0.980069204152249 0.751280276816609;1 0.977854671280277 0.745866974240677;1 0.975640138408305 0.740453671664744;1 0.973425605536332 0.735040369088812;1 0.97121107266436 0.72962706651288;1 0.968996539792388 0.724213763936947;1 0.966782006920415 0.718800461361015;1 0.964567474048443 0.713387158785083;1 0.962352941176471 0.70797385620915;1 0.960138408304498 0.702560553633218;1 0.957923875432526 0.697147251057286;1 0.955709342560554 0.691733948481353;1 0.953494809688581 0.686320645905421;1 0.951280276816609 0.680907343329489;1 0.949065743944637 0.675494040753556;1 0.946851211072664 0.670080738177624;1 0.944636678200692 0.664667435601692;1 0.94242214532872 0.659254133025759;1 0.940207612456747 0.653840830449827;1 0.937993079584775 0.648427527873895;1 0.935778546712803 0.643014225297962;1 0.93356401384083 0.63760092272203;1 0.931349480968858 0.632187620146098;0.9999846212995 0.929104190695886 0.626805074971165;0.999861591695502 0.926643598615917 0.62163783160323;0.999738562091503 0.924183006535948 0.616470588235294;0.999615532487505 0.921722414455978 0.611303344867359;0.999492502883506 0.919261822376009 0.606136101499423;0.999369473279508 0.91680123029604 0.600968858131488;0.999246443675509 0.914340638216071 0.595801614763553;0.999123414071511 0.911880046136102 0.590634371395617;0.999000384467512 0.909419454056132 0.585467128027682;0.998877354863514 0.906958861976163 0.580299884659746;0.998754325259516 0.904498269896194 0.575132641291811;0.998631295655517 0.902037677816225 0.569965397923875;0.998508266051519 0.899577085736255 0.56479815455594;0.99838523644752 0.897116493656286 0.559630911188005;0.998262206843522 0.894655901576317 0.554463667820069;0.998139177239523 0.892195309496348 0.549296424452134;0.998016147635525 0.889734717416378 0.544129181084198;0.997893118031526 0.887274125336409 0.538961937716263;0.997770088427528 0.88481353325644 0.533794694348328;0.997647058823529 0.882352941176471 0.528627450980392;0.997524029219531 0.879892349096501 0.523460207612457;0.997400999615533 0.877431757016532 0.518292964244521;0.997277970011534 0.874971164936563 0.513125720876586;0.997154940407536 0.872510572856594 0.507958477508651;0.997031910803537 0.870049980776624 0.502791234140715;0.996908881199539 0.867589388696655 0.49762399077278;0.99678585159554 0.865128796616686 0.492456747404844;0.996662821991542 0.862668204536717 0.487289504036909;0.996539792387543 0.860207612456747 0.482122260668973;0.996416762783545 0.857747020376778 0.476955017301038;0.996293733179546 0.855286428296809 0.471787773933103;0.996170703575548 0.85282583621684 0.466620530565167;0.996078431372549 0.849780853517878 0.461453287197232;0.996078431372549 0.844982698961938 0.456286043829296;0.996078431372549 0.840184544405998 0.451118800461361;0.996078431372549 0.835386389850058 0.445951557093426;0.996078431372549 0.830588235294118 0.44078431372549;0.996078431372549 0.825790080738178 0.435617070357555;0.996078431372549 0.820991926182238 0.430449826989619;0.996078431372549 0.816193771626298 0.425282583621684;0.996078431372549 0.811395617070358 0.420115340253749;0.996078431372549 0.806597462514417 0.414948096885813;0.996078431372549 0.801799307958478 0.409780853517878;0.996078431372549 0.797001153402537 0.404613610149942;0.996078431372549 0.792202998846597 0.399446366782007;0.996078431372549 0.787404844290657 0.394279123414072;0.996078431372549 0.782606689734717 0.389111880046136;0.996078431372549 0.777808535178777 0.383944636678201;0.996078431372549 0.773010380622837 0.378777393310265;0.996078431372549 0.768212226066897 0.37361014994233;0.996078431372549 0.763414071510957 0.368442906574395;0.996078431372549 0.758615916955017 0.363275663206459;0.996078431372549 0.753817762399077 0.358108419838524;0.996078431372549 0.749019607843137 0.352941176470588;0.996078431372549 0.744221453287197 0.347773933102653;0.996078431372549 0.739423298731257 0.342606689734717;0.996078431372549 0.734625144175317 0.337439446366782;0.996078431372549 0.729826989619377 0.332272202998847;0.996078431372549 0.725028835063437 0.327104959630911;0.996078431372549 0.720230680507497 0.321937716262976;0.996078431372549 0.715432525951557 0.31677047289504;0.996078431372549 0.710634371395617 0.311603229527105;0.996078431372549 0.705836216839677 0.30643598615917;0.996078431372549 0.701038062283737 0.301268742791234;0.99603229527105 0.696332179930796 0.297301038062284;0.995909265667051 0.691780084582853 0.295332564398308;0.995786236063053 0.68722798923491 0.293364090734333;0.995663206459054 0.682675893886966 0.291395617070358;0.995540176855056 0.678123798539023 0.289427143406382;0.995417147251057 0.67357170319108 0.287458669742407;0.995294117647059 0.669019607843137 0.285490196078431;0.99517108804306 0.664467512495194 0.283521722414456;0.995048058439062 0.659915417147251 0.281553248750481;0.994925028835064 0.655363321799308 0.279584775086505;0.994801999231065 0.650811226451365 0.27761630142253;0.994678969627066 0.646259131103422 0.275647827758554;0.994555940023068 0.641707035755479 0.273679354094579;0.99443291041907 0.637154940407536 0.271710880430604;0.994309880815071 0.632602845059592 0.269742406766628;0.994186851211073 0.628050749711649 0.267773933102653;0.994063821607074 0.623498654363706 0.265805459438677;0.993940792003076 0.618946559015763 0.263836985774702;0.993817762399077 0.61439446366782 0.261868512110727;0.993694732795079 0.609842368319877 0.259900038446751;0.99357170319108 0.605290272971934 0.257931564782776;0.993448673587082 0.600738177623991 0.2559630911188;0.993325643983083 0.596186082276048 0.253994617454825;0.993202614379085 0.591633986928105 0.25202614379085;0.993079584775087 0.587081891580161 0.250057670126874;0.992956555171088 0.582529796232218 0.248089196462899;0.99283352556709 0.577977700884275 0.246120722798924;0.992710495963091 0.573425605536332 0.244152249134948;0.992587466359093 0.568873510188389 0.242183775470973;0.992464436755094 0.564321414840446 0.240215301806997;0.992341407151096 0.559769319492503 0.238246828143022;0.992218377547097 0.55521722414456 0.236278354479047;0.992095347943099 0.549065743944637 0.234186851211073;0.9919723183391 0.541314878892734 0.2319723183391;0.991849288735102 0.533564013840831 0.229757785467128;0.991726259131103 0.525813148788927 0.227543252595156;0.991603229527105 0.518062283737024 0.225328719723183;0.991480199923107 0.510311418685121 0.223114186851211;0.991357170319108 0.502560553633218 0.220899653979239;0.99123414071511 0.494809688581315 0.218685121107266;0.991111111111111 0.487058823529412 0.216470588235294;0.990988081507113 0.479307958477509 0.214256055363322;0.990865051903114 0.471557093425606 0.212041522491349;0.990742022299116 0.463806228373702 0.209826989619377;0.990618992695117 0.456055363321799 0.207612456747405;0.990495963091119 0.448304498269896 0.205397923875433;0.99037293348712 0.440553633217993 0.20318339100346;0.990249903883122 0.43280276816609 0.200968858131488;0.990126874279123 0.425051903114187 0.198754325259516;0.990003844675125 0.417301038062284 0.196539792387543;0.989880815071127 0.409550173010381 0.194325259515571;0.989757785467128 0.401799307958478 0.192110726643599;0.98963475586313 0.394048442906575 0.189896193771626;0.989511726259131 0.386297577854671 0.187681660899654;0.989388696655133 0.378546712802768 0.185467128027682;0.989265667051134 0.370795847750865 0.183252595155709;0.989142637447136 0.363044982698962 0.181038062283737;0.989019607843137 0.355294117647059 0.178823529411765;0.988896578239139 0.347543252595156 0.176608996539792;0.98877354863514 0.339792387543253 0.17439446366782;0.988650519031142 0.332041522491349 0.172179930795848;0.988527489427143 0.324290657439446 0.169965397923875;0.988404459823145 0.316539792387543 0.167750865051903;0.988281430219146 0.30878892733564 0.165536332179931;0.986312956555171 0.301883890811226 0.163629373317955;0.98323721645521 0.295486351403306 0.161906958861976;0.980161476355248 0.289088811995386 0.160184544405998;0.977085736255286 0.282691272587466 0.158462129950019;0.974009996155325 0.276293733179547 0.156739715494041;0.970934256055363 0.269896193771626 0.155017301038062;0.967858515955402 0.263498654363706 0.153294886582084;0.96478277585544 0.257101114955786 0.151572472126105;0.961707035755479 0.250703575547866 0.149850057670127;0.958631295655517 0.244306036139946 0.148127643214148;0.955555555555556 0.237908496732026 0.14640522875817;0.952479815455594 0.231510957324106 0.144682814302191;0.949404075355632 0.225113417916186 0.142960399846213;0.946328335255671 0.218715878508266 0.141237985390235;0.943252595155709 0.212318339100346 0.139515570934256;0.940176855055748 0.205920799692426 0.137793156478278;0.937101114955786 0.199523260284506 0.136070742022299;0.934025374855825 0.193125720876586 0.134348327566321;0.930949634755863 0.186728181468666 0.132625913110342;0.927873894655902 0.180330642060746 0.130903498654364;0.92479815455594 0.173933102652826 0.129181084198385;0.921722414455978 0.167535563244906 0.127458669742407;0.918646674356017 0.161138023836986 0.125736255286428;0.915570934256055 0.154740484429066 0.12401384083045;0.912495194156094 0.148342945021146 0.122291426374471;0.909419454056132 0.141945405613226 0.120569011918493;0.906343713956171 0.135547866205306 0.118846597462514;0.903267973856209 0.129150326797386 0.117124183006536;0.900192233756248 0.122752787389466 0.115401768550557;0.897116493656286 0.116355247981546 0.113679354094579;0.894040753556324 0.109957708573626 0.111956939638601;0.890965013456363 0.103560169165705 0.110234525182622;0.886689734717416 0.0995617070357555 0.110726643598616;0.882014609765475 0.0963629373317955 0.111956939638601;0.877339484813533 0.0931641676278354 0.113187235678585;0.872664359861592 0.0899653979238754 0.11441753171857;0.86798923490965 0.0867666282199155 0.115647827758554;0.863314109957709 0.0835678585159554 0.116878123798539;0.858638985005767 0.0803690888119954 0.118108419838524;0.853963860053825 0.0771703191080354 0.119338715878508;0.849288735101884 0.0739715494040754 0.120569011918493;0.844613610149942 0.0707727797001153 0.121799307958478;0.839938485198001 0.0675740099961553 0.123029603998462;0.835263360246059 0.0643752402921953 0.124259900038447;0.830588235294118 0.0611764705882353 0.125490196078431;0.825913110342176 0.0579777008842753 0.126720492118416;0.821237985390235 0.0547789311803153 0.127950788158401;0.816562860438293 0.0515801614763552 0.129181084198385;0.811887735486351 0.0483813917723952 0.13041138023837;0.80721261053441 0.0451826220684352 0.131641676278354;0.802537485582468 0.0419838523644752 0.132871972318339;0.797862360630527 0.0387850826605152 0.134102268358324;0.793187235678585 0.0355863129565553 0.135332564398308;0.788512110726644 0.0323875432525952 0.136562860438293;0.783836985774702 0.0291887735486351 0.137793156478278;0.779161860822761 0.0259900038446751 0.139023452518262;0.774486735870819 0.0227912341407151 0.140253748558247;0.769811610918877 0.0195924644367551 0.141484044598231;0.765136485966936 0.0163936947327951 0.142714340638216;0.760461361014994 0.0131949250288351 0.143944636678201;0.755786236063053 0.00999615532487505 0.145174932718185;0.751111111111111 0.00679738562091503 0.14640522875817;0.74643598615917 0.00359861591695501 0.147635524798155;0.741760861207228 0.000399846212995006 0.148865820838139;0.734609765474817 0 0.149019607843137;0.727104959630911 0 0.149019607843137;0.719600153787005 0 0.149019607843137;0.712095347943099 0 0.149019607843137;0.704590542099193 0 0.149019607843137;0.697085736255286 0 0.149019607843137;0.68958093041138 0 0.149019607843137;0.682076124567474 0 0.149019607843137;0.674571318723568 0 0.149019607843137;0.667066512879662 0 0.149019607843137;0.659561707035755 0 0.149019607843137;0.652056901191849 0 0.149019607843137;0.644552095347943 0 0.149019607843137;0.637047289504037 0 0.149019607843137;0.629542483660131 0 0.149019607843137;0.622037677816225 0 0.149019607843137;0.614532871972318 0 0.149019607843137;0.607028066128412 0 0.149019607843137;0.599523260284506 0 0.149019607843137;0.5920184544406 0 0.149019607843137;0.584513648596694 0 0.149019607843137;0.577008842752787 0 0.149019607843137;0.569504036908881 0 0.149019607843137;0.561999231064975 0 0.149019607843137;0.554494425221069 0 0.149019607843137;0.546989619377163 0 0.149019607843137;0.539484813533256 0 0.149019607843137;0.53198000768935 0 0.149019607843137;0.524475201845444 0 0.149019607843137;0.516970396001538 0 0.149019607843137;0.509465590157632 0 0.149019607843137;0.501960784313725 0 0.149019607843137];

num = size(raw,1);

vec = linspace(0,num+1,N+2);
map = interp1(1:num,raw,vec(2:N+1),'linear','extrap');

map = max(0,min(1,map));
%
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%inferno