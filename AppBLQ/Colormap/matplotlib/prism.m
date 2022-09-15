function map = prism(N)

if nargin<1 || isnumeric(N)&&isequal(N,[])

N=256;
else
	assert(isscalar(N)&&isfinite(N)&&isreal(N),...
		'SC:inferno:N:NotRealFiniteScalarNumeric',...
		'First argument <N> must be a real finite numeric scalar.')
end

raw = [1 0 0;1 0 0;1 0.129645418368863 0;1 0.320298293272216 0;1 0.511590843066198 0;1 0.690910334311134 0;1 0.846433468368128 0;1 0.967905941890417 0;0.888984218883981 1 0;0.699098626637802 1 0;0.507294437866885 1 0;0.326218120550174 0.996568840677349 0;0.167808808360219 0.887049375764319 0;0.0425111026741564 0.740801270364147 0.224724559288294;0 0.567467285637455 0.491524941400927;0 0.378476070257433 0.725916988366595;0 0.18628862087343 0.912446233129778;0 0.00357667547075452 1;0.100145835635956 0 1;0.243103664620042 0 1;0.414208589193159 0 0.996460764643704;0.602178932122292 0 0.844967279032232;0.794621007231569 0 0.637761497948941;0.978846287975942 0 0.38850538202313;1 0 0.113633449754165;1 0 0;1 0.0560556703098125 0;1 0.242879328493592 0;1 0.435447224014261 0;1 0.621062534450578 0;1 0.787486850960292 0;1 0.923747108757149 0;0.961913892177322 1 0;0.776361963534425 1 0;0.58379713713035 1 0;0.396916033026401 1 0;0.228040519238415 0.935947041716477 0;0.0883052784405993 0.803425021423595 0.112285417439157;0 0.639688070882156 0.387237229237612;0 0.455532065381757 0.636656839413203;0 0.263099195568047 0.844098949593566;0 0.0750773810416918 0.995886016964381;0.0528226711158416 0 1;0.181685523197884 0 1;0.342745030807137 0 1;0.525381853882585 0 0.913202433897107;0.717553967953337 0 0.726934639800281;0.906590646156668 0 0.492736945402894;1 0 0.226051003266959;1 0 0;1 0 0;1 0.166392568952592 0;1 0.358175302656803 0;1 0.548100318523203 0;1 0.72364505045485 0;1 0.873235085789158 0;1 0.987007315675655 0;0.852487210265113 1 0;0.661222220930989 1 0;0.470535987997511 1 0;0.293001267848535 0.978360976583407 0;0.140323681554706 0.860983048390662 0;0.0225699133659357 0.708595143815934 0.278806016260342;0 0.531244847158254 0.540584359585753;0 0.340625619661142 0.766719671144093;0 0.149305799754334 0.942301885650247;0.0121034035650875 0 1;0.125492425442315 0 1;0.274783153377491 0 1;0.450132213133149 0 0.971666175420326;0.639978093547582 0 0.808329463751673;0.831803446261603 0 0.591696143988699;1 0 0.336049774582916;1 0 0.0582462106923429;1 0 0;1 0.0916564353135711 0;1 0.280601901016261 0;1 0.472804394008194 0;1 0.655591184414851 0;1 0.816910359779757 0;1 0.946125459039601 0;0.926659814410898 1 0;0.738741228383513 1 0;0.546290240070462 1 0;0.361995963702328 1 0;0.198009706712624 0.912859471092729 0;0.0651437822280699 0.77345118764373 0.16739153393786;0 0.604804276609496 0.438727539914835;0 0.418038347909959 0.681136368541993;0 0.22546767555546 0.878634972166977;0 0.0397892650557446 1;0.0751256465632316 0 1;0.211050159954927 0 1;0.377235193167717 0 1;0.562723458383378 0 0.88107503205791;0.755284923392744 0 0.684324098393621;0.942223189765602 0 0.442452759106229;1 0 0.171408622884165;1 0 0;1 0.0194706162613588 0;1 0.203557067002723 0;1 0.395980439443038 0;1 0.584053440183968 0;1 0.75537561438239 0;1 0.89865096061119 0;0.998086117143421 1 0;0.815524693604423 1 0;0.623368206528965 1 0;0.434286352425354 1 0;0.260746104140445 0.958499203439254 0;0.114189710183277 0.833562232235353 0.0541859352020972;0.00428025849352531 0.675423255975265 0.332176264800362;0 0.494509051635606 0.588264796929643;0 0.302748064089144 0.80556652275827;0 0.11278391287388 0.969753812972877;0.0311241192187666 0 1;0.152228003849151 0 1;0.307470803858165 0 1;0.486616699518111 0 0.944392955404293;0.67785383808718 0 0.769629674564707;0.868573139624028 0 0.54412142773976;1 0 0.282736935163023;1 0 0.00271039091933876;1 0 0;1 0.127865192767421 0;1 0.318450483533242 0;1 0.509797283164459 0;1 0.68928928129832 0;1 0.845091805181208 0;1 0.966932130103878 0;0.890751021130725 1 0;0.700945140699287 1 0;0.509098915197889 1 0;0.327861584266342 0.997413892932461 0;0.169182897891361 0.888285079717796 0;0.043525218438651 0.742346150785552 0.222070650072706;0 0.569219481973554 0.489098697103415;0 0.380320052732792 0.723878381618696;0 0.188102807861078 0.910929677966579;0 0.00524144988728448 1;0.0989460916184807 0 1;0.241585535423054 0 1;0.412472171547605 0 0.997605721797887;0.600338715447267 0 0.846700089077182;0.792798324858761 0 0.639967909330044;0.977161317125729 0 0.391039916630353;1 0 0.116328994914125;1 0 0;1 0.0543361935737159 0;1 0.24104410931257 0;1 0.433617266213909 0;1 0.619358494951234 0;1 0.786021084351817 0;1 0.922616259281765 0;0.963615277123925 1 0;0.778190956872698 1 0;0.585633145531044 1 0;0.398638000627302 1 0;0.229534909373484 0.93703418679624 0;0.0894735595964603 0.804856875271268 0.109588843569425;0 0.641370225268437 0.384699162326883;0 0.457353608695604 0.634444625034692;0 0.264940025692092 0.842358448473674;0 0.076816124196937 0.994731987763078;0.0517745483181108 0 1;0.18028437086189 0 1;0.341083232880612 0 1;0.523568979788389 0 0.914710676064352;0.715709548210216 0 0.728966631064096;0.90483629122251 0 0.495158707915262;1 0 0.228702859899546;1 0 0;1 0 0;1 0.164589577470781 0;1 0.356328527801473 0;1 0.546331526034832 0;1 0.722070864363958 0;1 0.871959298896722 0;1 0.986114046051183 0;0.854279112356435 1 0;0.66307011481534 1 0;0.472318034152059 1 0;0.294599968372038 0.979287930161747 0;0.141633627305121 0.862286554597481 0;0.0235047340346013 0.710189256929132 0.276183284461729;0 0.533024460503319 0.538222208627305;0 0.342473395742327 0.764773847710227;0 0.151099906816071 0.94090068617655;0.0112181170701054 0 1;0.124223242523316 0 1;0.273213756675857 0 1;0.448366079665002 0 0.972933711275402;0.638131672022896 0 0.810165292263914;0.82999847912427 0 0.593979221156694;1 0 0.338629567394412;1 0 0.0609526224075777;1 0 0;1 0.0899049638306424 0;1 0.278758069894781 0;1 0.470989774895718 0;1 0.653925422886624 0;1 0.815503286595801 0;1 0.945069848534398 0;0.928395451613852 1 0;0.740581234988888 1 0;0.548113296597361 1 0;0.363681868260792 1 0;0.199447300426768 0.914020681932023 0;0.066238278414721 0.774940202216411 0.16471220090465;0 0.606522917835935 0.436240727772728;0 0.419873298446163 0.679006043418769;0 0.227297949288737 0.877001595481275;0 0.0414941842349568 1;0.0740020135231768 0 1;0.209589957276033 0 1;0.375534698238607 0 1;0.560894792085282 0 0.882695054157369;0.75344865749175 0 0.686444060923281;0.940500397102015 0 0.444932883897437;1 0 0.17408538473469;1 0 0;1 0.0177894058046989 0;1 0.201735908905515 0;1 0.394139410423672 0;1 0.582313927135454 0;1 0.753852310816938 0;1 0.897444304427925 0;0.999746917859993 1 0;0.817337124563358 1 0;0.625212766429317 1 0;0.43604142156807 1 0;0.262295963333697 0.95950569376774 0;0.115432170602179 0.83493021557141 0.0514786702299138;0.00513339942505919 0.677062535344746 0.329591400765624;0 0.496311542360132 0.585972764939485;0 0.304594920269798 0.803718446254554;0 0.114553363408061 0.968471543519314;0.0301580591124265 0 1;0.150892619597191 0 1;0.305854143038116 0 1;0.484825355470944 0 0.945779836593213;0.676005921763849 0 0.771563838515023;0.866790492026859 0 0.546475346775361;1 0 0.285355405365266;1 0 0.00542076538317725;1 0 0;1 0.126086194379865 0;1 0.316602743914437 0;1 0.508002631665852 0;1 0.687666046945236 0;1 0.84374701473568 0;1 0.965954451333888 0;0.892516483139608 1 0;0.702791466884631 1 0;0.510904369401936 1 0;0.329507125195342 0.99825489314128 0];

num = size(raw,1);

vec = linspace(0,num+1,N+2);
map = interp1(1:num,raw,vec(2:N+1),'linear','extrap');

map = max(0,min(1,map));
%
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%inferno