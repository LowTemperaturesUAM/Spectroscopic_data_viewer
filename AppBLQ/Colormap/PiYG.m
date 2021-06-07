function map = PiYG(N)

if nargin<1 || isnumeric(N)&&isequal(N,[])

N=256;
else
	assert(isscalar(N)&&isfinite(N)&&isreal(N),...
		'SC:inferno:N:NotRealFiniteScalarNumeric',...
		'First argument <N> must be a real finite numeric scalar.')
end

raw = [0.556862745098039 0.00392156862745098 0.32156862745098;0.565321030372933 0.007920030757401 0.328181468665898;0.573779315647828 0.011918492887351 0.334794309880815;0.582237600922722 0.015916955017301 0.341407151095732;0.590695886197616 0.0199154171472511 0.34801999231065;0.599154171472511 0.0239138792772011 0.354632833525567;0.607612456747405 0.0279123414071511 0.361245674740484;0.616070742022299 0.0319108035371011 0.367858515955402;0.624529027297193 0.0359092656670511 0.374471357170319;0.632987312572088 0.0399077277970012 0.381084198385236;0.641445597846982 0.0439061899269512 0.387697039600154;0.649903883121876 0.0479046520569012 0.394309880815071;0.658362168396771 0.0519031141868512 0.400922722029988;0.666820453671665 0.0559015763168012 0.407535563244906;0.675278738946559 0.0599000384467513 0.414148404459823;0.683737024221453 0.0638985005767013 0.42076124567474;0.692195309496348 0.0678969627066513 0.427374086889658;0.700653594771242 0.0718954248366013 0.433986928104575;0.709111880046136 0.0758938869665513 0.440599769319493;0.71757016532103 0.0798923490965013 0.44721261053441;0.726028450595925 0.0838908112264514 0.453825451749327;0.734486735870819 0.0878892733564014 0.460438292964244;0.742945021145713 0.0918877354863514 0.467051134179162;0.751403306420607 0.0958861976163014 0.473663975394079;0.759861591695502 0.0998846597462514 0.480276816608997;0.768319876970396 0.103883121876201 0.486889657823914;0.774471357170319 0.112956555171088 0.493963860053825;0.778316032295271 0.127104959630911 0.501499423298731;0.782160707420223 0.141253364090734 0.509034986543637;0.786005382545175 0.155401768550557 0.516570549788543;0.789850057670127 0.169550173010381 0.524106113033449;0.793694732795079 0.183698577470204 0.531641676278354;0.797539407920031 0.197846981930027 0.53917723952326;0.801384083044983 0.21199538638985 0.546712802768166;0.805228758169935 0.226143790849673 0.554248366013072;0.809073433294887 0.240292195309496 0.561783929257978;0.812918108419839 0.254440599769319 0.569319492502883;0.81676278354479 0.268589004229143 0.576855055747789;0.820607458669742 0.282737408688966 0.584390618992695;0.824452133794694 0.296885813148789 0.591926182237601;0.828296808919646 0.311034217608612 0.599461745482507;0.832141484044598 0.325182622068435 0.606997308727413;0.83598615916955 0.339331026528258 0.614532871972318;0.839830834294502 0.353479430988081 0.622068435217224;0.843675509419454 0.367627835447905 0.62960399846213;0.847520184544406 0.381776239907728 0.637139561707036;0.851364859669358 0.395924644367551 0.644675124951942;0.85520953479431 0.410073048827374 0.652210688196847;0.859054209919262 0.424221453287197 0.659746251441753;0.862898885044214 0.43836985774702 0.667281814686659;0.866743560169166 0.452518262206844 0.674817377931565;0.870588235294118 0.466666666666667 0.682352941176471;0.873510188389081 0.476355247981546 0.689119569396386;0.876432141484045 0.486043829296424 0.695886197616301;0.879354094579008 0.495732410611303 0.702652825836217;0.882276047673971 0.505420991926182 0.709419454056132;0.885198000768935 0.515109573241061 0.716186082276048;0.888119953863899 0.52479815455594 0.722952710495963;0.891041906958862 0.534486735870819 0.729719338715878;0.893963860053825 0.544175317185698 0.736485966935794;0.896885813148789 0.553863898500577 0.743252595155709;0.899807766243752 0.563552479815455 0.750019223375625;0.902729719338716 0.573241061130334 0.75678585159554;0.905651672433679 0.582929642445213 0.763552479815456;0.908573625528643 0.592618223760092 0.770319108035371;0.911495578623606 0.602306805074971 0.777085736255286;0.91441753171857 0.61199538638985 0.783852364475202;0.917339484813533 0.621683967704729 0.790618992695117;0.920261437908497 0.631372549019608 0.797385620915033;0.92318339100346 0.641061130334487 0.804152249134948;0.926105344098424 0.650749711649366 0.810918877354863;0.929027297193387 0.660438292964244 0.817685505574779;0.931949250288351 0.670126874279123 0.824452133794694;0.934871203383314 0.679815455594002 0.83121876201461;0.937793156478277 0.689504036908881 0.837985390234525;0.940715109573241 0.69919261822376 0.84475201845444;0.943637062668204 0.708881199538639 0.851518646674356;0.946020761245675 0.716955017301038 0.856516724336793;0.947866205305652 0.723414071510957 0.859746251441753;0.949711649365629 0.729873125720876 0.862975778546713;0.951557093425605 0.736332179930796 0.866205305651672;0.953402537485582 0.742791234140715 0.869434832756632;0.955247981545559 0.749250288350634 0.872664359861592;0.957093425605536 0.755709342560554 0.875893886966551;0.958938869665513 0.762168396770473 0.879123414071511;0.96078431372549 0.768627450980392 0.882352941176471;0.962629757785467 0.775086505190311 0.88558246828143;0.964475201845444 0.781545559400231 0.88881199538639;0.966320645905421 0.78800461361015 0.892041522491349;0.968166089965398 0.794463667820069 0.895271049596309;0.970011534025375 0.800922722029988 0.898500576701269;0.971856978085352 0.807381776239908 0.901730103806228;0.973702422145329 0.813840830449827 0.904959630911188;0.975547866205306 0.820299884659746 0.908189158016148;0.977393310265283 0.826758938869665 0.911418685121107;0.97923875432526 0.833217993079585 0.914648212226067;0.981084198385236 0.839677047289504 0.917877739331026;0.982929642445213 0.846136101499423 0.921107266435986;0.98477508650519 0.852595155709342 0.924336793540946;0.986620530565167 0.859054209919262 0.927566320645905;0.988465974625144 0.865513264129181 0.930795847750865;0.990311418685121 0.8719723183391 0.934025374855825;0.992156862745098 0.87843137254902 0.937254901960784;0.99123414071511 0.881968473663975 0.938485198000769;0.990311418685121 0.885505574778931 0.939715494040754;0.989388696655133 0.889042675893887 0.940945790080738;0.988465974625144 0.892579777008843 0.942176086120723;0.987543252595156 0.896116878123798 0.943406382160707;0.986620530565167 0.899653979238754 0.944636678200692;0.985697808535179 0.90319108035371 0.945866974240677;0.98477508650519 0.906728181468666 0.947097270280661;0.983852364475202 0.910265282583622 0.948327566320646;0.982929642445213 0.913802383698577 0.949557862360631;0.982006920415225 0.917339484813533 0.950788158400615;0.981084198385237 0.920876585928489 0.9520184544406;0.980161476355248 0.924413687043445 0.953248750480584;0.97923875432526 0.927950788158401 0.954479046520569;0.978316032295271 0.931487889273356 0.955709342560554;0.977393310265283 0.935024990388312 0.956939638600538;0.976470588235294 0.938562091503268 0.958169934640523;0.975547866205306 0.942099192618224 0.959400230680508;0.974625144175317 0.94563629373318 0.960630526720492;0.973702422145329 0.949173394848135 0.961860822760477;0.97277970011534 0.952710495963091 0.963091118800461;0.971856978085352 0.956247597078047 0.964321414840446;0.970934256055363 0.959784698193003 0.965551710880431;0.970011534025375 0.963321799307958 0.966782006920415;0.969088811995386 0.966858900422914 0.9680123029604;0.967320261437909 0.968473663975394 0.96562860438293;0.964705882352941 0.968166089965398 0.959630911188005;0.962091503267974 0.967858515955402 0.95363321799308;0.959477124183007 0.967550941945406 0.947635524798155;0.956862745098039 0.967243367935409 0.94163783160323;0.954248366013072 0.966935793925413 0.935640138408305;0.951633986928105 0.966628219915417 0.929642445213379;0.949019607843137 0.966320645905421 0.923644752018455;0.94640522875817 0.966013071895425 0.917647058823529;0.943790849673203 0.965705497885429 0.911649365628604;0.941176470588235 0.965397923875433 0.905651672433679;0.938562091503268 0.965090349865436 0.899653979238754;0.935947712418301 0.96478277585544 0.893656286043829;0.933333333333333 0.964475201845444 0.887658592848904;0.930718954248366 0.964167627835448 0.881660899653979;0.928104575163399 0.963860053825452 0.875663206459054;0.925490196078431 0.963552479815456 0.869665513264129;0.922875816993464 0.96324490580546 0.863667820069204;0.920261437908497 0.962937331795463 0.857670126874279;0.917647058823529 0.962629757785467 0.851672433679354;0.915032679738562 0.962322183775471 0.845674740484429;0.912418300653595 0.962014609765475 0.839677047289504;0.909803921568628 0.961707035755479 0.833679354094579;0.90718954248366 0.961399461745483 0.827681660899654;0.904575163398693 0.961091887735486 0.821683967704729;0.901960784313726 0.96078431372549 0.815686274509804;0.894886582083814 0.957708573625529 0.804306036139946;0.887812379853903 0.954632833525567 0.792925797770089;0.880738177623991 0.951557093425606 0.781545559400231;0.873663975394079 0.948481353325644 0.770165321030373;0.866589773164168 0.945405613225683 0.758785082660515;0.859515570934256 0.942329873125721 0.747404844290658;0.852441368704345 0.939254133025759 0.7360246059208;0.845367166474433 0.936178392925798 0.724644367550942;0.838292964244522 0.933102652825836 0.713264129181085;0.83121876201461 0.930026912725875 0.701883890811227;0.824144559784699 0.926951172625913 0.690503652441369;0.817070357554787 0.923875432525952 0.679123414071511;0.809996155324875 0.92079969242599 0.667743175701654;0.802921953094964 0.917723952326029 0.656362937331796;0.795847750865052 0.914648212226067 0.644982698961938;0.78877354863514 0.911572472126105 0.63360246059208;0.781699346405229 0.908496732026144 0.622222222222223;0.774625144175317 0.905420991926182 0.610841983852365;0.767550941945406 0.902345251826221 0.599461745482507;0.760476739715494 0.899269511726259 0.588081507112649;0.753402537485583 0.896193771626298 0.576701268742792;0.746328335255671 0.893118031526336 0.565321030372934;0.739254133025759 0.890042291426375 0.553940792003076;0.732179930795848 0.886966551326413 0.542560553633218;0.725105728565936 0.883890811226451 0.531180315263361;0.717185697808535 0.879507881584006 0.520184544405998;0.708419838523645 0.873817762399078 0.509573241061131;0.699653979238754 0.868127643214148 0.498961937716263;0.690888119953864 0.86243752402922 0.488350634371396;0.682122260668974 0.856747404844291 0.477739331026529;0.673356401384083 0.851057285659362 0.467128027681661;0.664590542099193 0.845367166474433 0.456516724336794;0.655824682814302 0.839677047289504 0.445905420991926;0.647058823529412 0.833986928104575 0.435294117647059;0.638292964244522 0.828296808919646 0.424682814302192;0.629527104959631 0.822606689734718 0.414071510957324;0.620761245674741 0.816916570549789 0.403460207612457;0.61199538638985 0.81122645136486 0.39284890426759;0.60322952710496 0.805536332179931 0.382237600922722;0.594463667820069 0.799846212995002 0.371626297577855;0.585697808535179 0.794156093810073 0.361014994232987;0.576931949250288 0.788465974625144 0.35040369088812;0.568166089965398 0.782775855440216 0.339792387543253;0.559400230680508 0.777085736255287 0.329181084198385;0.550634371395617 0.771395617070358 0.318569780853518;0.541868512110727 0.765705497885429 0.307958477508651;0.533102652825836 0.7600153787005 0.297347174163783;0.524336793540946 0.754325259515571 0.286735870818916;0.515570934256055 0.748635140330642 0.276124567474048;0.506805074971165 0.742945021145713 0.265513264129181;0.498039215686275 0.737254901960784 0.254901960784314;0.490349865436371 0.730795847750865 0.249980776624375;0.482660515186467 0.724336793540946 0.245059592464437;0.474971164936563 0.717877739331027 0.240138408304498;0.467281814686659 0.711418685121107 0.23521722414456;0.459592464436755 0.704959630911188 0.230296039984621;0.451903114186851 0.698500576701269 0.225374855824683;0.444213763936947 0.69204152249135 0.220453671664744;0.436524413687044 0.68558246828143 0.215532487504806;0.42883506343714 0.679123414071511 0.210611303344867;0.421145713187236 0.672664359861592 0.205690119184929;0.413456362937332 0.666205305651672 0.20076893502499;0.405767012687428 0.659746251441753 0.195847750865052;0.398077662437524 0.653287197231834 0.190926566705113;0.39038831218762 0.646828143021915 0.186005382545175;0.382698961937716 0.640369088811995 0.181084198385236;0.375009611687812 0.633910034602076 0.176163014225298;0.367320261437909 0.627450980392157 0.171241830065359;0.359630911188005 0.620991926182238 0.166320645905421;0.351941560938101 0.614532871972318 0.161399461745483;0.344252210688197 0.608073817762399 0.156478277585544;0.336562860438293 0.60161476355248 0.151557093425606;0.328873510188389 0.595155709342561 0.146635909265667;0.321184159938485 0.588696655132641 0.141714725105729;0.313494809688582 0.582237600922722 0.13679354094579;0.305805459438677 0.575778546712803 0.131872356785852;0.299038831218762 0.569011918492887 0.12879661668589;0.293194925028835 0.561937716262976 0.127566320645905;0.287351018838908 0.554863514033064 0.126336024605921;0.281507112648981 0.547789311803153 0.125105728565936;0.275663206459054 0.540715109573241 0.123875432525952;0.269819300269127 0.533640907343329 0.122645136485967;0.2639753940792 0.526566705113418 0.121414840445982;0.258131487889273 0.519492502883506 0.120184544405998;0.252287581699346 0.512418300653595 0.118954248366013;0.246443675509419 0.505344098423683 0.117723952326028;0.240599769319493 0.498269896193772 0.116493656286044;0.234755863129566 0.49119569396386 0.115263360246059;0.228911956939639 0.484121491733948 0.114033064206075;0.223068050749712 0.477047289504037 0.11280276816609;0.217224144559785 0.469973087274126 0.111572472126105;0.211380238369858 0.462898885044214 0.110342176086121;0.205536332179931 0.455824682814302 0.109111880046136;0.199692425990004 0.448750480584391 0.107881584006151;0.193848519800077 0.441676278354479 0.106651287966167;0.18800461361015 0.434602076124567 0.105420991926182;0.182160707420223 0.427527873894656 0.104190695886198;0.176316801230296 0.420453671664744 0.102960399846213;0.170472895040369 0.413379469434833 0.101730103806228;0.164628988850442 0.406305267204921 0.100499807766244;0.158785082660515 0.39923106497501 0.0992695117262591;0.152941176470588 0.392156862745098 0.0980392156862745];

num = size(raw,1);

vec = linspace(0,num+1,N+2);
map = interp1(1:num,raw,vec(2:N+1),'linear','extrap');

map = max(0,min(1,map));
%
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%inferno