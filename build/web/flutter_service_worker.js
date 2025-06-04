'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {".git/COMMIT_EDITMSG": "da931a77d06c822a4741046f6d123976",
".git/config": "8f0a01ebedfa2de97f0c7c57f9e8a664",
".git/description": "a0a7c3fff21f2aea3cfa1d0316dd816c",
".git/FETCH_HEAD": "b7f325fd8a95e6b1ab88ddb37898b552",
".git/HEAD": "cf7dd3ce51958c5f13fece957cc417fb",
".git/hooks/applypatch-msg.sample": "ce562e08d8098926a3862fc6e7905199",
".git/hooks/commit-msg.sample": "579a3c1e12a1e74a98169175fb913012",
".git/hooks/fsmonitor-watchman.sample": "a0b2633a2c8e97501610bd3f73da66fc",
".git/hooks/post-update.sample": "2b7ea5cee3c49ff53d41e00785eb974c",
".git/hooks/pre-applypatch.sample": "054f9ffb8bfe04a599751cc757226dda",
".git/hooks/pre-commit.sample": "305eadbbcd6f6d2567e033ad12aabbc4",
".git/hooks/pre-merge-commit.sample": "39cb268e2a85d436b9eb6f47614c3cbc",
".git/hooks/pre-push.sample": "2c642152299a94e05ea26eae11993b13",
".git/hooks/pre-rebase.sample": "56e45f2bcbc8226d2b4200f7c46371bf",
".git/hooks/pre-receive.sample": "2ad18ec82c20af7b5926ed9cea6aeedd",
".git/hooks/prepare-commit-msg.sample": "2b5c047bdb474555e1787db32b2d2fc5",
".git/hooks/push-to-checkout.sample": "c7ab00c7784efeadad3ae9b228d4b4db",
".git/hooks/update.sample": "647ae13c682f7827c22f5fc08a03674e",
".git/index": "45b4dd6c29d44afaf0ec8ee5ff332dfd",
".git/info/exclude": "036208b4a1ab4a235d75c181e685e5a3",
".git/logs/HEAD": "7cfc1083e15e91a57bb88f2a4b3e66de",
".git/logs/refs/heads/main": "7cfc1083e15e91a57bb88f2a4b3e66de",
".git/logs/refs/remotes/origin/main": "0a86079548f5c474fa93188afa178efc",
".git/objects/01/4a4c16f4c025355954653bbeb75558d62f02d1": "0a42c660b0fc57469924f33e482fc1f6",
".git/objects/03/eaddffb9c0e55fb7b5f9b378d9134d8d75dd37": "87850ce0a3dd72f458581004b58ac0d6",
".git/objects/06/fad99f272e84362b51c91ac4f12024259c9b60": "c01666fe10fe6947438438921a5ec629",
".git/objects/08/020a9a7e05d7da12e651d541f3094dc33fceef": "c473cef37408b91a497c0d2a358ae466",
".git/objects/09/5920b21350ef83c7f8405cb7728a689d3b3e53": "46faaa43d689187999bfde8534470dfb",
".git/objects/0c/7f8cdcb75b5a8b8a3a980b52562c2d116fcbe2": "2508df2dede1ff0144908a343d07ec67",
".git/objects/11/a53c009548c6531ecb666607818ed72f29e53b": "36594cdc9779ddd41556b80f559843dd",
".git/objects/14/e81df7c2fc84731376b12e1e346d929ec3a133": "447924105f07453ac2c9bbfeab6488a2",
".git/objects/16/01d6e0aeda5611eaaee529323b677e0b8c3c3f": "7f83ba8973313f5aa205c0d8fae8530a",
".git/objects/18/83e54743bec990c9f65e2f45b9f25d4e700dc0": "f4c63feff2fd434938ab876e6aa5715c",
".git/objects/1d/468b85698a60041b450286f31b3264b3bbd6f7": "5c8c497111befde32ac151f14cf92f85",
".git/objects/1e/62d2a946e20d867c6197985a20f303e0c47480": "29f8e85459d3557d76f2600a033a8c9b",
".git/objects/22/52843820212babc0f07ee0f9cd7dacdbe1014b": "2260ebc5b78d6b6ec5a4ec146da4c8b9",
".git/objects/22/ecd07ac5a3ec9bd57e0a22e2efc62d075ca1f6": "d8e726f4312a9c759cd2e4bad333199c",
".git/objects/26/1d4947718348b1144369a7a2424c36b2d74b40": "2b487051e5f719c346fbda80f049e3b6",
".git/objects/29/3fd2d83ad32f9ef61c6eaca2f161ab64aabaa2": "d9fe627baf82af80936d7d51138386df",
".git/objects/29/942f8344adc68935218cb871f5eb7da513a4ae": "0b717fb39524da7a64ba0d44286b72a4",
".git/objects/2f/a0cef390eb6c0475df776f8a3e65b862d5d707": "ce25683fd8eca9758bff99442c8cffb0",
".git/objects/34/a387b9315cba76c86b99b16fdef08c86a42eef": "a127f124ae8a8c37d549c99f009116c8",
".git/objects/35/96d08a5b8c249a9ff1eb36682aee2a23e61bac": "e931dda039902c600d4ba7d954ff090f",
".git/objects/36/04cd649440af84154cc4ee06169bc3170d95c6": "3454d9a67b79e711db6ffb5d46a83859",
".git/objects/38/be8810fee02e0e9404702b51b16719b46cd5fb": "602707b2719e49455f24a0115dc6c5be",
".git/objects/40/1184f2840fcfb39ffde5f2f82fe5957c37d6fa": "1ea653b99fd29cd15fcc068857a1dbb2",
".git/objects/46/4ab5882a2234c39b1a4dbad5feba0954478155": "2e52a767dc04391de7b4d0beb32e7fc4",
".git/objects/46/b16ef52310bb85b99eb0b6a45742bcf3c616cb": "9246ba8aab41375a07034e050289760f",
".git/objects/46/cf85bf4804f4e2024c33d2e6e9de7ed4f17483": "ba312d43bec9eae9a64cc4c81528e59e",
".git/objects/48/95abfb13b861bff37174cff3208429018bcdf4": "cf8e942de7f3e680e43c6d976d670b92",
".git/objects/49/249b707e46db66bbe153cdc5ad6b26717d65d8": "e4bc9c3aee0766d3e5c46c9710c295da",
".git/objects/4b/825dc642cb6eb9a060e54bf8d69288fbee4904": "75589287973d2772c2fc69d664e10822",
".git/objects/4e/d09bc87bc6354a366d5b7fd79dbf9ce711dadb": "72a4c99fbf66f44f3f6790dc582468f1",
".git/objects/4e/e308cc6df4da3602de2b5fa865ad31f0135211": "4bdeb4fdf2f2f8777c4c8ff7e739ced8",
".git/objects/50/ec5c1fcc9efb0bf3e437d8919fc10dae32e3d1": "ff75480b4a1177614f6f9a3c7d235144",
".git/objects/53/3402c75429e6feaa7b8f92878ae2313dbdf2de": "63ab067b0b447b461fa3e8f58a1f23a9",
".git/objects/57/7946daf6467a3f0a883583abfb8f1e57c86b54": "846aff8094feabe0db132052fd10f62a",
".git/objects/5c/a554d9ad26f339686d5fbb28049514be4f9816": "d0db4fcb620cdf8b032c3c6bc584cd98",
".git/objects/5f/bf1f5ee49ba64ffa8e24e19c0231e22add1631": "f19d414bb2afb15ab9eb762fd11311d6",
".git/objects/60/b6ff3c8de6a12d82e3002d87d6ac094c60a80d": "dd05c8e8d1fd15fb5216054cbe012e23",
".git/objects/65/8c2008d4c4627859cf2fadbd70f56eb0671b76": "3ea89bf624532ffd24062223747b0cb2",
".git/objects/69/dd618354fa4dade8a26e0fd18f5e87dd079236": "8cc17911af57a5f6dc0b9ee255bb1a93",
".git/objects/6b/9862a1351012dc0f337c9ee5067ed3dbfbb439": "85896cd5fba127825eb58df13dfac82b",
".git/objects/6e/489c791216c59449d0939d6135c7a79229df56": "e293ccf81e4a15abc8f35026ad32678f",
".git/objects/72/3d030bc89a4250e63d16b082affe1998618c3f": "e4299c419434fc51f64a5266659918fa",
".git/objects/76/51d67d76757c18450e695ed02fcbf2d0f781e4": "773157a3368c931c738af0be22baf221",
".git/objects/77/7cdd8d50914fc6b3ade63502eb5df2ff06deb9": "10202756acb319799c9c1262fd0b6d72",
".git/objects/78/7b17d9bc8b98f078bea50cba804451f544bf86": "7aa62f6734f1c68336bfd8ffb8d5794a",
".git/objects/87/26c008858796821630035f3e794582e51ace0f": "3d544a1f3311141aab6fc2a51dbf1284",
".git/objects/88/cfd48dff1169879ba46840804b412fe02fefd6": "e42aaae6a4cbfbc9f6326f1fa9e3380c",
".git/objects/89/45a466b6d64716c4c0a24a288a377f7f170d1f": "07cc27b20211cba0fc8c76f2551c17b2",
".git/objects/8a/51a9b155d31c44b148d7e287fc2872e0cafd42": "9f785032380d7569e69b3d17172f64e8",
".git/objects/8a/aa46ac1ae21512746f852a42ba87e4165dfdd1": "1d8820d345e38b30de033aa4b5a23e7b",
".git/objects/8e/9fb5a08d95cba2c3376a122df108078c5d42c7": "0bef2db4e72c3d8ab229f286f64867da",
".git/objects/8f/18bde991ba492f6913dcf404db656810ea32c3": "6fc3018e7b770634edc5cabd180a0d67",
".git/objects/8f/c8be62f202c40e7d3e2e16242fb065cfc4e1a7": "6fda1b80da67a8d96186cf8ab8b24087",
".git/objects/8f/e7af5a3e840b75b70e59c3ffda1b58e84a5a1c": "e3695ae5742d7e56a9c696f82745288d",
".git/objects/90/445c21f68c14205c98de1ee969dbefadb05109": "3cd9d734576123038fb880c581229c6a",
".git/objects/91/4a40ccb508c126fa995820d01ea15c69bb95f7": "8963a99a625c47f6cd41ba314ebd2488",
".git/objects/98/f3d10c1d9381d99a856db6f1c83aff749d5390": "1b5c4f5d92756b836111e972990d82be",
".git/objects/9e/aa7394d05f63fc6c545249b301dc6973a30103": "41ebe1cb558feb4436aae84f3fb78523",
".git/objects/a0/c26d9783f273e65b343712deb2eea5261d10d2": "ca821dc7a9b1c6d34acccbbcb26db9c4",
".git/objects/a2/2774afd98c233c68591a684fc2277a1b6fd7ac": "ff1dd984b1c9411c72d3df09230e618f",
".git/objects/a4/37ee2f2af7a3c9f850bebaa7ca3e411dd53bb8": "ef21b8b9622fa18666367f97a22aaaca",
".git/objects/a5/de584f4d25ef8aace1c5a0c190c3b31639895b": "9fbbb0db1824af504c56e5d959e1cdff",
".git/objects/a8/8c9340e408fca6e68e2d6cd8363dccc2bd8642": "11e9d76ebfeb0c92c8dff256819c0796",
".git/objects/ad/63eb2e18f2f07f847aee82a3dbf3dd97052478": "b6d06679f856e1779827ea24eebcecce",
".git/objects/ae/7c62b45337647dedbdf0ad7eeb77462e7cc880": "b59799d92b1279d57b1983af7caddf63",
".git/objects/b4/c22ae1eb1ca9f72fd80a4724160f49aae84808": "9242947b9e4767e75ede601ac6601c43",
".git/objects/b5/07ce97820af332be04f3b6cd592287e6f296e4": "f94b6e00e6de787f628acd13d998588b",
".git/objects/b5/e2c05ebf263186607d2f0c2a5e6cd8207a59b5": "54e517f17ca39636c420a455d6006128",
".git/objects/b7/49bfef07473333cf1dd31e9eed89862a5d52aa": "36b4020dca303986cad10924774fb5dc",
".git/objects/b9/2a0d854da9a8f73216c4a0ef07a0f0a44e4373": "f62d1eb7f51165e2a6d2ef1921f976f3",
".git/objects/b9/312b593fd1370a9cd2b3fe203499ce70a90994": "80b54bd45e816af0c3aeddbd512af1bf",
".git/objects/bb/544a9722948e447776275479a864b379637b78": "50c368448a5a00138424c4423d45648c",
".git/objects/be/60d20b66fe9cf75c35f501ed4537b8c86447b6": "1f6b6d2dd19f47ea2ae55088dce87ac9",
".git/objects/bf/e4231f220a9aa9f07457b4f8ef9c37172d7ac5": "b76fb8a5e198684586e5a1251e01e83c",
".git/objects/cd/3a35d051486bdedce458aa31f414bdd075e4ab": "8bb846aceef78cdb3b7b653502756430",
".git/objects/d2/9cbd5cec125500dd1fea7377ce38e2625e3f17": "1823065ed79e05d3a6e93c4738cbf3b8",
".git/objects/d3/8c6cc3c7a711241255fadef2aa143028039f1f": "2faf925c724c246d8aec3a1e13c2545d",
".git/objects/d4/3532a2348cc9c26053ddb5802f0e5d4b8abc05": "3dad9b209346b1723bb2cc68e7e42a44",
".git/objects/d5/1a2a57bcd66ef253ab2f1218004c3635b95c86": "70dc0c88301ada9ffce73a681a51e734",
".git/objects/d6/9c56691fbdb0b7efa65097c7cc1edac12a6d3e": "868ce37a3a78b0606713733248a2f579",
".git/objects/d7/7cfefdbe249b8bf90ce8244ed8fc1732fe8f73": "9c0876641083076714600718b0dab097",
".git/objects/d8/1958d7433c6a5aed4f6659961e02d466b80f69": "f01361b5e7db8b1552febf0519294104",
".git/objects/d9/3952e90f26e65356f31c60fc394efb26313167": "1401847c6f090e48e83740a00be1c303",
".git/objects/da/9069c80b5574ecb990e24f1d452ebbc4f1def4": "c20db9940906fe69f1258a0f27eaa7b2",
".git/objects/df/49c789ec5a697b6e412ececaf7cf79ef5de72b": "816360e86e64682fee45ccac38f304a8",
".git/objects/e1/c186cb19fc35fbe4d6242f8536c672119d54c0": "269c100be9e1f484e2486b1186e3e350",
".git/objects/e1/fc073f306a5fa861c83f846ecc359c5b20b29a": "f07128a8d8ba25f703edc5c40c38b5c2",
".git/objects/e9/94225c71c957162e2dcc06abe8295e482f93a2": "2eed33506ed70a5848a0b06f5b754f2c",
".git/objects/eb/9b4d76e525556d5d89141648c724331630325d": "37c0954235cbe27c4d93e74fe9a578ef",
".git/objects/ed/51ef0742347161dff33aa910993b26124b99ed": "64aa53bb6b7546374f949b6ba89f3ac7",
".git/objects/ee/8b72f51015219cecd5478a024d9511be2fc18d": "25d1fb7a0403804df9cd7dac17f434c5",
".git/objects/ef/b875788e4094f6091d9caa43e35c77640aaf21": "27e32738aea45acd66b98d36fc9fc9e0",
".git/objects/f2/04823a42f2d890f945f70d88b8e2d921c6ae26": "6b47f314ffc35cf6a1ced3208ecc857d",
".git/objects/f3/1a41eda18613b21fb3d69a16ddf66305efe035": "0cc3392b504d6ca13a4b1ae9ea00f3e3",
".git/objects/f3/709a83aedf1f03d6e04459831b12355a9b9ef1": "538d2edfa707ca92ed0b867d6c3903d1",
".git/objects/f5/72b90ef57ee79b82dd846c6871359a7cb10404": "e68f5265f0bb82d792ff536dcb99d803",
".git/objects/fb/c7ecee70ae152e84efb5d232ada82feaa39586": "90bc9e8aa764c94406384157c7ce97b4",
".git/objects/pack/pack-564b8380f74567847392d07b5b8ebdce52c67072.idx": "66ed8befdecbb1124a8c1f59d8ce5ef6",
".git/objects/pack/pack-564b8380f74567847392d07b5b8ebdce52c67072.pack": "e4e87749cede51f16476fab3acc81daf",
".git/ORIG_HEAD": "6f4cc009fa5ae044de24c4845c23eb29",
".git/refs/heads/main": "29085154220530ea893f9782f0234eea",
".git/refs/remotes/origin/main": "29085154220530ea893f9782f0234eea",
"assets/AssetManifest.bin": "693635b5258fe5f1cda720cf224f158c",
"assets/AssetManifest.bin.json": "69a99f98c8b1fb8111c5fb961769fcd8",
"assets/AssetManifest.json": "2efbb41d7877d10aac9d091f58ccd7b9",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/fonts/CaviarDreams.ttf": "fd2d0a4d699ed411275cb14ef35dec7d",
"assets/fonts/CaviarDreams_BoldItalic.ttf": "b2e51669a1c906b13af71f3eca401444",
"assets/fonts/CaviarDreams_Italic.ttf": "b0ee942b1bcb053fb13f4173d76c8fc3",
"assets/fonts/Caviar_Dreams_Bold.ttf": "c32e6db748bed398b70c105d50b52ec7",
"assets/fonts/MaterialIcons-Regular.otf": "1a25d23fef43695d6de8bfde25b599fe",
"assets/fonts/Nymphont%20License.txt": "004487f0a2487e786a4ca41c856a2d5e",
"assets/images/download_AppStore.png": "81ff693f69e69b3b46e67fb831cfe537",
"assets/images/download_GooglePlay.png": "d741357bf94bf2d0201e61faf77617a4",
"assets/images/inspiration1.png": "a181827170bfae83c27803aca5d61cee",
"assets/images/inspiration2.png": "5c8782493f8100b9f4b16899e682dd07",
"assets/images/inspiration3.png": "1572819543a01a5781e445b40e5aa091",
"assets/images/inspiration4.png": "77db405a69b6b72d9b1d8f03445013e4",
"assets/images/logo_insta_white.png": "00a6bc0f8fc304d4464b8e85f29fc68a",
"assets/images/logo_ohmytag.png": "ffebcafef60746c9a660d27fb86b1ac5",
"assets/images/logo_ohMyTag_footer.png": "1f660f3b0251162bec1b4577f2dd2ef0",
"assets/images/logo_ohMyTag_white.png": "9e76cd60c2c4bc83ca9ad97d0163f7c8",
"assets/images/main.png": "8c543cb2ba0cb943f1e80009b3dab88c",
"assets/images/promo.png": "7ca52c313a4dc62fbd5f79abe14ab952",
"assets/NOTICES": "0c9e7dd8284ecd41729adbbee9207c7e",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "6cfe36b4647fbfa15683e09e7dd366bc",
"canvaskit/canvaskit.js.symbols": "68eb703b9a609baef8ee0e413b442f33",
"canvaskit/canvaskit.wasm": "efeeba7dcc952dae57870d4df3111fad",
"canvaskit/chromium/canvaskit.js": "ba4a8ae1a65ff3ad81c6818fd47e348b",
"canvaskit/chromium/canvaskit.js.symbols": "5a23598a2a8efd18ec3b60de5d28af8f",
"canvaskit/chromium/canvaskit.wasm": "64a386c87532ae52ae041d18a32a3635",
"canvaskit/skwasm.js": "f2ad9363618c5f62e813740099a80e63",
"canvaskit/skwasm.js.symbols": "80806576fa1056b43dd6d0b445b4b6f7",
"canvaskit/skwasm.wasm": "f0dfd99007f989368db17c9abeed5a49",
"canvaskit/skwasm_st.js": "d1326ceef381ad382ab492ba5d96f04d",
"canvaskit/skwasm_st.js.symbols": "c7e7aac7cd8b612defd62b43e3050bdd",
"canvaskit/skwasm_st.wasm": "56c3973560dfcbf28ce47cebe40f3206",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "76f08d47ff9f5715220992f993002504",
"flutter_bootstrap.js": "246a0983ca2b1bb32db91ce6b18dd002",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "c766173d8757ef15c24e550d4c528730",
"/": "c766173d8757ef15c24e550d4c528730",
"main.dart.js": "f8edf6508dd0ade5b8c15b163f34a387",
"manifest.json": "3f9f46d43b9a25da68f5dd4800d5ed6d",
"version.json": "c2a08cda2a1e690bfed5ce9fc4d9e5b1"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
