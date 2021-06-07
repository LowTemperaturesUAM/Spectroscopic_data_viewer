function map = pink(N)

if nargin<1 || isnumeric(N)&&isequal(N,[])

N=256;
else
	assert(isscalar(N)&&isfinite(N)&&isreal(N),...
		'SC:inferno:N:NotRealFiniteScalarNumeric',...
		'First argument <N> must be a real finite numeric scalar.')
end

raw = [0.1178 0 0;0.137084689872925 0.0254147195323666 0.0254147195323666;0.15636937974585 0.0508294390647332 0.0508294390647332;0.175654069618775 0.0762441585970998 0.0762441585970998;0.194938759491701 0.101658878129466 0.101658878129466;0.208752126522656 0.112894934988876 0.112894934988876;0.222291951827187 0.123422121986651 0.123422121986651;0.235831777131718 0.133949308984427 0.133949308984427;0.24937160243625 0.144476495982202 0.144476495982202;0.260676781982723 0.152787366816014 0.152787366816014;0.271746757758581 0.160864963128904 0.160864963128904;0.282816733534439 0.168942559441795 0.168942559441795;0.293886709310298 0.177020155754685 0.177020155754685;0.303696454208219 0.184011170882112 0.184011170882112;0.313296181455005 0.190821107103813 0.190821107103813;0.322895908701791 0.197631043325514 0.197631043325514;0.332495635948577 0.204440979547215 0.204440979547215;0.341281746109746 0.210594901992902 0.210594901992902;0.349876437057378 0.216594484463073 0.216594484463073;0.35847112800501 0.222594066933243 0.222594066933243;0.367065818952642 0.228593649403414 0.228593649403414;0.375094282529341 0.23415463154969 0.23415463154969;0.382945819792643 0.23957856638539 0.23957856638539;0.390797357055945 0.245002501221089 0.245002501221089;0.398648894319247 0.250426436056789 0.250426436056789;0.406087299476358 0.255539065879536 0.255539065879536;0.413360471455413 0.260527188514718 0.260527188514718;0.420633643434467 0.265515311149899 0.265515311149899;0.427906815413521 0.270503433785081 0.270503433785081;0.434869009159715 0.275261122867417 0.275261122867417;0.441675733613498 0.279903609862845 0.279903609862845;0.448482458067282 0.284546096858273 0.284546096858273;0.455289182521065 0.289188583853701 0.289188583853701;0.461856388324976 0.293656555664262 0.293656555664262;0.468276218274218 0.298017148260148 0.298017148260148;0.47469604822346 0.302377740856035 0.302377740856035;0.481115878172702 0.306738333451922 0.306738333451922;0.487348354815119 0.310963811417341 0.310963811417341;0.49344033737769 0.315087968482674 0.315087968482674;0.499532319940261 0.319212125548008 0.319212125548008;0.505624302502832 0.323336282613341 0.323336282613341;0.511568614684203 0.327354960834961 0.327354960834961;0.517378702847232 0.331277764757765 0.331277764757765;0.523188791010262 0.335200568680569 0.335200568680569;0.528998879173291 0.339123372603373 0.339123372603373;0.534691779792544 0.342962874537227 0.342962874537227;0.540255797121268 0.346710760638055 0.346710760638055;0.545819814449991 0.350458646738882 0.350458646738882;0.551383831778714 0.354206532839709 0.354206532839709;0.556854661983662 0.357888870270517 0.357888870270517;0.562201267330267 0.36148382680665 0.36148382680665;0.567547872676873 0.365078783342783 0.365078783342783;0.572894478023478 0.368673739878916 0.368673739878916;0.578167284868991 0.372216924507395 0.372216924507395;0.583320195904255 0.375675998554704 0.375675998554704;0.588473106939519 0.379135072602014 0.379135072602014;0.593626017974783 0.382594146649323 0.382594146649323;0.598720860258448 0.386012778488073 0.386012778488073;0.603699594648948 0.389350546531723 0.389350546531723;0.608678329039447 0.392688314575373 0.392688314575373;0.613657063429946 0.396026082619024 0.396026082619024;0.618590894117894 0.399332502794856 0.399332502794856;0.623412498939499 0.402560576611165 0.402560576611165;0.628234103761104 0.405788650427474 0.405788650427474;0.633055708582709 0.409016724243783 0.409016724243783;0.637843068763951 0.412221085706027 0.412221085706027;0.642520885206473 0.415349594716889 0.415349594716889;0.647198701648996 0.418478103727751 0.418478103727751;0.651876518091518 0.421606612738613 0.421606612738613;0.656529337246749 0.424717891980833 0.424717891980833;0.661075965322789 0.42775597737186 0.42775597737186;0.665622593398829 0.430794062762886 0.430794062762886;0.670169221474869 0.433832148153913 0.433832148153913;0.674698581908111 0.436858298037239 0.436858298037239;0.679124398098633 0.439812877462407 0.439812877462407;0.683550214289156 0.442767456887575 0.442767456887575;0.687976030479678 0.445722036312742 0.445722036312742;0.692391179229003 0.448669315722963 0.448669315722963;0.696705077660548 0.451547306836248 0.451547306836248;0.701018976092094 0.454425297949533 0.454425297949533;0.705332874523639 0.457303289062818 0.457303289062818;0.709641835158482 0.460177886177416 0.460177886177416;0.713852215839451 0.462984724278371 0.462984724278371;0.71806259652042 0.465791562379327 0.465791562379327;0.722272977201389 0.468598400480283 0.468598400480283;0.72648334967135 0.471405232953233 0.471405232953233;0.730597130255718 0.474145859223271 0.474145859223271;0.734710910840087 0.476886485493309 0.476886485493309;0.738824691424456 0.479627111763347 0.479627111763347;0.742938472008825 0.482367738033385 0.482367738033385;0.746966597440715 0.485049770531535 0.485049770531535;0.75099044852339 0.487728879092997 0.487728879092997;0.755014299606064 0.490407987654458 0.490407987654458;0.759038150688739 0.49308709621592 0.49308709621592;0.760971337525926 0.498753538643127 0.495714117013352;0.762684692180457 0.504734097564862 0.498335660811367;0.764398046834988 0.510714656486598 0.500957204609381;0.766111401489519 0.516695215408333 0.503578748407395;0.767811625231155 0.522446618721148 0.506153698643522;0.769509662223309 0.528159859728507 0.508720889446007;0.771207699215464 0.533873100735865 0.511288080248492;0.772905736207619 0.539586341743224 0.513855271050977;0.774591771687772 0.545109558810559 0.516381656712657;0.776274985135691 0.550588093700858 0.518898447464742;0.77795819858361 0.556066628591158 0.521415238216826;0.77964141203153 0.561545163481458 0.523932028968911;0.781313518051989 0.566865370465076 0.52641192047045;0.782982155014743 0.572136128677011 0.528880287644699;0.784650791977498 0.577406886888946 0.531348654818949;0.786319428940253 0.58267764510088 0.533817021993199;0.787977829032653 0.587815676993736 0.536253266574267;0.789632136569313 0.592900646784588 0.538676668997669;0.791286444105973 0.59798561657544 0.541100071421071;0.792940751642634 0.603070586366292 0.543523473844474;0.794585834072658 0.608043866473219 0.545918212543683;0.796226306301365 0.612961330214213 0.548298626688803;0.797866778530073 0.617878793955206 0.550679040833923;0.79950725075878 0.622796257696199 0.553059454979043;0.801139462589698 0.627619644684586 0.555414629019805;0.802766593628594 0.632385167097167 0.557754278418278;0.804393724667489 0.637150689509748 0.560093927816751;0.806020855706385 0.64191621192233 0.562433577215224;0.807640361588244 0.646602658632306 0.564751198382257;0.809254151437328 0.651229827965357 0.567052306565718;0.810867941286412 0.655856997298409 0.569353414749179;0.812481731135496 0.660484166631461 0.571654522932641;0.814088737113593 0.665044394915104 0.573936139955088;0.815689579037864 0.669543798305035 0.576200046651696;0.817290420962136 0.674043201694965 0.578463953348304;0.818891262886407 0.678542605084896 0.580727860044913;0.820486272014507 0.682986275737687 0.582975250760016;0.822074861838391 0.687368609531786 0.585204464753935;0.823663451662275 0.691750943325884 0.587433678747855;0.825252041486159 0.696133277119983 0.589662892741775;0.826835232834645 0.700469141684671 0.591877710801299;0.828411222645928 0.704743016546781 0.594073324761619;0.829987212457213 0.709016891408891 0.596268938721939;0.831563202268496 0.713290766271002 0.598464552682259;0.833134675820205 0.717526252926724 0.600647935106229;0.834698806796101 0.721699327688034 0.602811431387373;0.836262937771997 0.725872402449344 0.604974927668516;0.837827068747892 0.730045477210654 0.607138423949659;0.839387330447683 0.73418718613801 0.609291629602865;0.840939849647261 0.738266131393425 0.611424243500185;0.842492368846839 0.742345076648841 0.613556857397504;0.844044888046417 0.746424021904257 0.615689471294824;0.845594161425926 0.750477917896094 0.617813758958053;0.847135315908257 0.754469157181451 0.619917219885043;0.848676470390588 0.758460396466808 0.622020680812034;0.850217624872919 0.762451635752165 0.624124141739024;0.851756074666192 0.766423177845472 0.62622084094337;0.853285864431276 0.770331652342182 0.628295890077243;0.85481565419636 0.774240126838892 0.630370939211116;0.856345443961444 0.778148601335601 0.632445988344988;0.857873117202352 0.782042307196954 0.63451591078697;0.85939178930926 0.785873205145499 0.636564030482148;0.860910461416167 0.789704103094044 0.638612150177327;0.862429133523075 0.793535001042589 0.640660269872505;0.863946289013407 0.797355459025871 0.642704650931474;0.865454337580279 0.801113227489522 0.644726582365171;0.866962386147151 0.804870995953172 0.646748513798867;0.868470434714023 0.808628764416823 0.648770445232563;0.869977496010614 0.812379974585033 0.650789979009861;0.871475168096521 0.81606881356799 0.652786710418357;0.872972840182428 0.819757652550947 0.654783441826854;0.874470512268336 0.823446491533903 0.65678017323535;0.875967691160103 0.827132206953972 0.658775765600236;0.877454986765046 0.830755328224152 0.660748532278885;0.878942282369988 0.834378449494332 0.662721298957534;0.880429577974931 0.838001570764512 0.664694065636183;0.881916873579873 0.841624692034692 0.666666832314832;0.883394040623923 0.84518605378723 0.668615883338707;0.884871206806972 0.848747410289763 0.670564932346579;0.88634837299002 0.852308766792296 0.672513981354452;0.887825539173069 0.855870123294829 0.674463030362324;0.889293294382 0.859375249227014 0.676390904678434;0.890760578202225 0.862877558611676 0.678317718369954;0.89222786202245 0.866379867996339 0.680244532061473;0.893695145842675 0.869882177381001 0.682171345752993;0.895153712748124 0.87333352634082 0.684078490508608;0.896611361264597 0.876779506257388 0.685983563001916;0.898069009781069 0.880225486173957 0.687888635495224;0.899526658297541 0.883671466090525 0.689793707988531;0.900976260431143 0.887071708672885 0.691680570246923;0.902424520702932 0.890464323830206 0.69356439566016;0.903872780974722 0.893856938987527 0.695448221073397;0.905321041246512 0.897249554144848 0.697332046486635;0.906761702156702 0.900600772779773 0.699199473277473;0.90820057418381 0.903942246709482 0.701063039846922;0.909639446210917 0.907283720639191 0.702926606416371;0.911078318238024 0.9106251945689 0.70479017298582;0.912510226144285 0.912510226144285 0.709362029686618;0.913939956985781 0.913939956985781 0.714780529222765;0.915369687827276 0.915369687827276 0.720199028758911;0.916799418668772 0.916799418668772 0.725617528295058;0.918222620646974 0.918222620646974 0.730922566774508;0.919643210302857 0.919643210302857 0.736182207328266;0.921063799958741 0.921063799958741 0.741441847882024;0.922484389614625 0.922484389614625 0.746701488435783;0.923899215048862 0.923899215048862 0.751864290065878;0.925311157637275 0.925311157637275 0.756978659886131;0.926723100225688 0.926723100225688 0.762093029706383;0.928135042814102 0.928135042814102 0.767207399526635;0.929541632910986 0.929541632910986 0.772238729264023;0.930944928431928 0.930944928431928 0.777218946008946;0.932348223952871 0.932348223952871 0.782199162753869;0.933751519473814 0.933751519473814 0.787179379498791;0.935150015397957 0.935150015397957 0.792088590444002;0.936544910910499 0.936544910910499 0.796944536476419;0.937939806423042 0.937939806423042 0.801800482508836;0.939334701935584 0.939334701935584 0.806656428541252;0.940725197817727 0.940725197817727 0.811452203157909;0.94211169332187 0.94211169332187 0.816193266722502;0.943498188826012 0.943498188826012 0.820934330287095;0.944884684330155 0.944884684330155 0.825675393851688;0.946267297807474 0.946267297807474 0.830365167607344;0.947645640362287 0.947645640362287 0.834998513417161;0.949023982917101 0.949023982917101 0.839631859226977;0.950402325471914 0.950402325471914 0.844265205036793;0.951777174202586 0.951777174202586 0.848855566222331;0.95314736380807 0.95314736380807 0.853388606049488;0.954517553413553 0.954517553413553 0.857921645876646;0.955887743019037 0.955887743019037 0.862454685703803;0.957254921112804 0.957254921112804 0.866951963829317;0.958617204828028 0.958617204828028 0.871391121209651;0.959979488543253 0.959979488543253 0.875830278589985;0.961341772258478 0.961341772258478 0.880269435970318;0.962701503246974 0.962701503246974 0.884678948782184;0.96405612813101 0.96405612813101 0.889029164897106;0.965410753015047 0.965410753015047 0.893379381012028;0.966765377899084 0.966765377899084 0.89772959712695;0.968117814731638 0.968117814731638 0.902056097587098;0.969464780784487 0.969464780784487 0.906323301854302;0.970811746837335 0.970811746837335 0.910590506121506;0.972158712890183 0.972158712890183 0.91485771038871;0.973503914385385 0.973503914385385 0.919106092707681;0.974843468666116 0.974843468666116 0.923294238072297;0.976183022946846 0.976183022946846 0.927482383436913;0.977522577227577 0.977522577227577 0.931670528801529;0.97886071986219 0.97886071986219 0.935844463595228;0.980192862370803 0.980192862370803 0.939957997120527;0.981525004879417 0.981525004879417 0.944071530645825;0.98285714738803 0.98285714738803 0.948185064171123;0.984188231162055 0.984188231162055 0.952288504426681;0.98551296189855 0.98551296189855 0.956331379057791;0.986837692635046 0.986837692635046 0.960374253688901;0.988162423371541 0.988162423371541 0.964417128320011;0.989486495339848 0.989486495339848 0.968453603488721;0.990804308422367 0.990804308422367 0.972429278052631;0.992122121504886 0.992122121504886 0.976404952616541;0.993439934587405 0.993439934587405 0.980380627180451;0.994757406522112 0.994757406522112 0.98435325494149;0.996068054891584 0.996068054891584 0.988264941206118;0.997378703261056 0.997378703261056 0.992176627470745;0.998689351630528 0.998689351630528 0.996088313735373;1 1 1];

num = size(raw,1);

vec = linspace(0,num+1,N+2);
map = interp1(1:num,raw,vec(2:N+1),'linear','extrap');

map = max(0,min(1,map));
%
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%inferno