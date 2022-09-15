function map = gist_ncar(N)

if nargin<1 || isnumeric(N)&&isequal(N,[])

N=256;
else
	assert(isscalar(N)&&isfinite(N)&&isreal(N),...
		'SC:inferno:N:NotRealFiniteScalarNumeric',...
		'First argument <N> must be a real finite numeric scalar.')
end

raw = [0 0 0.502;0 0.0286197616301423 0.465106497500961;0 0.0572395232602845 0.428212995001922;0 0.0858592848904268 0.391319492502884;0 0.114479046520569 0.354425990003845;0 0.143098808150711 0.317532487504806;0 0.171718569780854 0.280638985005767;0 0.200338331410996 0.243745482506728;0 0.228958093041138 0.206851980007689;0 0.25757785467128 0.169958477508651;0 0.286197616301423 0.133064975009612;0 0.314817377931565 0.0961714725105728;0 0.343437139561707 0.059277970011534;0 0.372056901191849 0.0223844675124951;0 0.345746269509625 0.0870866880085368;0 0.319159605700204 0.15229943977591;0 0.292572941890782 0.217512191543284;0 0.26598627808136 0.282724943310658;0 0.239399614271938 0.347937695078031;0 0.212812950462516 0.413150446845405;0 0.186226286653095 0.478363198612779;0 0.159639622843673 0.543575950380152;0 0.133052959034251 0.608788702147526;0 0.106466295224829 0.674001453914899;0 0.0798796314154077 0.739214205682273;0 0.0532929676059859 0.804426957449647;0 0.0267063037965642 0.86963970921702;0 0.000119639987142428 0.934852460984394;0 0.0551294963475586 1;0 0.110508196847366 1;0 0.165886897347174 1;0 0.221265597846982 1;0 0.27664429834679 1;0 0.332022998846597 1;0 0.387401699346405 1;0 0.442780399846213 1;0 0.498159100346021 1;0 0.553537800845828 1;0 0.608916501345636 1;0 0.664295201845444 1;0 0.719673902345252 1;0 0.753565258924082 1;0 0.775225928489043 1;0 0.792511587850827 1;0 0.80979724721261 1;0 0.827082906574394 1;0 0.844368565936178 1;0 0.861654225297962 1;0 0.878939884659746 1;0 0.89622554402153 1;0 0.913511203383314 1;0 0.930796862745098 1;0 0.948082522106882 0.999858593437375;0 0.965368181468666 0.97414830932373;0 0.98265384083045 0.948438025210084;0 0.999939500192234 0.922727741096439;0 0.998222883399299 0.897017456982793;0 0.996439525044357 0.871307172869148;0 0.994656166689414 0.845596888755502;0 0.992872808334471 0.819886604641857;0 0.991089449979528 0.794176320528211;0 0.989306091624585 0.768466036414566;0 0.987522733269642 0.742755752300921;0 0.985739374914699 0.717045468187275;0 0.983956016559756 0.691335184073629;0 0.982172658204813 0.665624899959984;0 0.9804 0.639914615846339;0 0.9804 0.614029494989847;0 0.9804 0.573116015846067;0 0.9804 0.532202536702287;0 0.982030471422612 0.491289057558507;0 0.983665848977889 0.450375578414728;0 0.985301226533167 0.409462099270948;0 0.986936604088444 0.368548620127168;0 0.988571981643721 0.327635140983389;0 0.990207359198999 0.286721661839608;0 0.991842736754276 0.245808182695829;0 0.993478114309554 0.204894703552049;0 0.995113491864831 0.163981224408269;2.49742002061627e-05 0.996748869420108 0.123067745264489;0.0249991744066045 0.998384246975386 0.0821542661207096;0.0499733746130029 0.999822929642445 0.0412407869769298;0.0749475748194009 0.98506706651288 0.000327307833150714;0.0999217750257996 0.970311203383314 0;0.124895975232198 0.955555340253749 0;0.149870175438596 0.940799477124183 0;0.174844375644995 0.926043613994617 0;0.199818575851393 0.911287750865052 0;0.224792776057791 0.896531887735486 0;0.24976697626419 0.881776024605921 0;0.274741176470588 0.867020161476355 0;0.299715376676987 0.85226429834679 0;0.324689576883385 0.837508435217224 0;0.349663777089783 0.822752572087659 0;0.374637977296182 0.808189437065149 0;0.399397078046905 0.820966160657812 0;0.407163321799308 0.833742884250474 0;0.414929565551711 0.846519607843137 0;0.422695809304114 0.8592963314358 0;0.430462053056517 0.872073055028463 0;0.43822829680892 0.884849778621126 0;0.445994540561323 0.897626502213789 0;0.453760784313726 0.910403225806452 0;0.461527028066128 0.923179949399115 0;0.469293271818531 0.935956672991777 0;0.477059515570934 0.94873339658444 0;0.484825759323337 0.961510120177103 0;0.49259200307574 0.974286843769766 0.0155649126317193;0.50043385299475 0.987063567362429 0.031184493797519;0.518280918961392 0.999840290955092 0.0468040749633187;0.536127984928033 1 0.0624236561291183;0.553975050894675 1 0.078043237294918;0.571822116861317 1 0.0936628184607177;0.589669182827958 1 0.109282399626517;0.6075162487946 1 0.124901980792317;0.625363314761242 1 0.140521561958117;0.643210380727883 1 0.156141143123916;0.661057446694525 1 0.171760724289716;0.678904512661167 1 0.187380305455516;0.696751578627808 1 0.202999886621315;0.71459864459445 1 0.218619467787115;0.732445710561092 1 0.234160951047085;0.750292776527733 1 0.218541369881286;0.768139842494375 1 0.202921788715486;0.785986908461016 1 0.187302207549686;0.803833974427658 1 0.171682626383887;0.8216810403943 1 0.156063045218087;0.839528106360941 1 0.140443464052287;0.857375172327583 1 0.124823882886488;0.875222238294225 1 0.109204301720688;0.893069304260866 1 0.0935847205548886;0.910916370227508 1 0.0779651393890889;0.928763436194149 1 0.0623455582232897;0.946610502160791 1 0.0467259770574897;0.964457568127433 0.990405600200007 0.03110639589169;0.982304634094075 0.980733826208079 0.0154868147258904;1 0.97106205221615 0;1 0.961390278224222 0;1 0.951718504232294 0;1 0.942046730240366 0;1 0.932374956248437 0;1 0.922703182256509 0;1 0.913031408264581 0;1 0.903359634272652 0;1 0.893687860280724 0;1 0.884016086288796 0;1 0.874344312296867 0;1 0.864672538304939 0;1 0.855000764313011 0;1 0.845328990321083 0.00421301038062281;1 0.835657216329154 0.00843446366782005;1 0.825985442337226 0.0126559169550173;1 0.816313668345298 0.0168773702422145;1 0.80664189435337 0.0210988235294118;1 0.796970120361441 0.025320276816609;1 0.787298346369513 0.0295417301038063;1 0.777626572377585 0.0337631833910035;1 0.767954798385656 0.0379846366782007;1 0.758283024393728 0.042206089965398;1 0.7486112504018 0.0464275432525952;1 0.738939476409872 0.0506489965397925;1 0.729267702417943 0.0548704498269897;1 0.697309375334833 0.0512641656662664;1 0.665193942640808 0.0476027010804321;1 0.633078509946784 0.0439412364945979;1 0.600963077252759 0.0402797719087634;1 0.568847644558734 0.0366183073229291;1 0.536732211864709 0.0329568427370948;1 0.504616779170685 0.0292953781512605;1 0.47250134647666 0.0256339135654261;1 0.440385913782635 0.0219724489795918;1 0.40827048108861 0.0183109843937575;1 0.376155048394586 0.0146495198079232;1 0.344039615700561 0.0109880552220888;1 0.311924183006536 0.0073265906362545;1 0.279808750312512 0.00366512605042018;1 0.2610737494998 3.66146458585098e-06;1 0.242426290516207 0;1 0.223778831532613 0;1 0.20513137254902 0;1 0.186483913565427 0;1 0.167836454581833 0;1 0.149188995598239 0;1 0.130541536614646 0;1 0.111894077631052 0;1 0.093246618647459 0;1 0.0745991596638655 0;1 0.055951700680272 0;1 0.0373042416966785 0;1 0.018656782713085 0.0687596914175517;1 9.32372949158378e-06 0.138319318547092;1 0 0.207878945676632;1 0 0.277438572806173;1 0 0.346998199935713;1 0 0.416557827065253;1 0 0.486117454194793;1 0 0.555677081324332;1 0 0.625236708453874;1 0 0.694796335583414;1 0 0.764355962712954;1 0 0.833915589842495;1 0 0.903475216972035;1 0 0.973034844101575;0.973281917211329 0.0133573481258909 0.986827551533434;0.946266666666666 0.0268632612966602 1;0.919251416122004 0.0403691744674295 1;0.892236165577342 0.0538750876381988 1;0.86522091503268 0.067381000808968 1;0.838205664488017 0.0808869139797373 1;0.811190413943355 0.0943928271505066 1;0.784175163398692 0.107898740321276 1;0.75715991285403 0.121404653492045 1;0.730144662309369 0.134910566662814 1;0.703129411764705 0.148416479833584 1;0.676114161220043 0.161922393004353 1;0.649098910675381 0.175520340012143 0.999955280545734;0.622083660130718 0.198714025500911 0.995247969570342;0.644800281212682 0.221907710989678 0.99054065859495;0.668044628067337 0.245101396478446 0.985833347619558;0.691288974921993 0.268295081967213 0.981126036644166;0.714533321776648 0.291488767455981 0.976418725668774;0.737777668631303 0.314682452944748 0.971711414693382;0.761022015485959 0.337876138433515 0.96700410371799;0.784266362340614 0.361069823922283 0.962296792742598;0.80751070919527 0.38426350941105 0.957589481767206;0.830755056049925 0.407457194899818 0.952882170791814;0.85399940290458 0.430650880388585 0.948174859816422;0.877243749759236 0.453844565877353 0.94346754884103;0.90048809661389 0.477038251366119 0.938760237865638;0.923527912341407 0.500181660899654 0.934123836985775;0.926319146482122 0.518347750865052 0.936507535563245;0.929110380622837 0.53651384083045 0.938891234140715;0.931901614763552 0.554679930795848 0.941274932718185;0.934692848904268 0.572846020761246 0.943658631295656;0.937484083044983 0.591012110726644 0.946042329873126;0.940275317185698 0.609178200692041 0.948426028450596;0.943066551326413 0.627344290657439 0.950809727028066;0.945857785467128 0.645510380622837 0.953193425605536;0.948649019607843 0.663676470588235 0.955577124183007;0.951440253748558 0.681842560553633 0.957960822760477;0.954231487889273 0.700008650519031 0.960344521337947;0.957022722029988 0.718174740484429 0.962728219915417;0.959813956170704 0.736340830449827 0.965111918492887;0.962605190311419 0.754506920415225 0.967495617070358;0.965396424452134 0.772673010380622 0.969879315647828;0.968187658592849 0.790839100346021 0.972263014225298;0.970978892733564 0.809005190311419 0.974646712802768;0.973770126874279 0.827171280276817 0.977030411380238;0.976561361014994 0.845337370242214 0.979414109957709;0.979352595155709 0.863503460207612 0.981797808535179;0.982143829296424 0.88166955017301 0.984181507112649;0.98493506343714 0.899835640138408 0.986565205690119;0.987726297577855 0.918001730103806 0.988948904267589;0.99051753171857 0.936167820069204 0.99133260284506;0.993308765859285 0.954333910034602 0.99371630142253;0.9961 0.9725 0.9961];

num = size(raw,1);

vec = linspace(0,num+1,N+2);
map = interp1(1:num,raw,vec(2:N+1),'linear','extrap');

map = max(0,min(1,map));
%
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%inferno