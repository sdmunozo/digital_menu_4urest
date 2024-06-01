'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "a877019f6dca746503cf4c52333d2a61",
"version.json": "8d834b906ddd963a181cad2c77beed16",
"index.html": "d48aae9d0e0bcee1e161c6826ea5e628",
"/": "d48aae9d0e0bcee1e161c6826ea5e628",
"vercel.json": "da8484efebd780414370117c48fcb6e4",
"main.dart.js": "44b694ac08c83372f10fbee4dd2c66ba",
"flutter.js": "383e55f7f3cce5be08fcf1f3881f585c",
"favicon.png": "7c26bd34cd01e7562d5b2553452ea57e",
"icons/Icon-192.png": "ff6e56e06e166ff0700a4b5c5909996f",
"icons/Icon-maskable-192.png": "ff6e56e06e166ff0700a4b5c5909996f",
"icons/Icon-maskable-512.png": "fd9dab010e4b962e6d3d383d37bfab55",
"icons/Icon-512.png": "fd9dab010e4b962e6d3d383d37bfab55",
"manifest.json": "c07feedb5c1b0b546c93a7624a6b4d12",
"assets/AssetManifest.json": "ac10cb18e6875fef4b2f5c8596689354",
"assets/NOTICES": "c5453de9bbf4638ba0bc667b1eaa6e1d",
"assets/FontManifest.json": "5a32d4310a6f5d9a6b651e75ba0d7372",
"assets/AssetManifest.bin.json": "4bde3b8197e4781bc34a987458e0befa",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "e986ebe42ef785b27164c36a9abc7818",
"assets/packages/font_awesome_flutter/lib/fonts/fa-solid-900.ttf": "0c5c1d8406da5886d380fedb38e91c52",
"assets/packages/font_awesome_flutter/lib/fonts/fa-regular-400.ttf": "f3307f62ddff94d2cd8b103daf8d1b0f",
"assets/packages/font_awesome_flutter/lib/fonts/fa-brands-400.ttf": "216b019b42c05e07ff7472b382efae72",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "2b726f6772fa2895162c05ec9f8a7fb3",
"assets/fonts/MaterialIcons-Regular.otf": "2601de3eb92d48a8540bc8860383f070",
"assets/assets/temp/McDonalds_Banner_1.jpeg": "6c492e8164828c22b91d6b725113667c",
"assets/assets/temp/McDonalds_Banner_4.jpeg": "a529879b6646a20f58ea3304ad8ca5a5",
"assets/assets/temp/HomeScreen3.PNG": "d5e0686052e75cb120fc16170005ea98",
"assets/assets/temp/McDonalds_Banner_3.jpeg": "ecd2da32ffd93d489dee1c59d293698c",
"assets/assets/temp/HomeScreen2.PNG": "fcf55b93cd1f0dee64a145cccd8beb13",
"assets/assets/temp/HomeScreen1.PNG": "0a1c21b310ab6a67af7f8998ed86c474",
"assets/assets/temp/McDonalds_Banner_2.jpeg": "06eca9fefc88d6682e0f3e84b990d679",
"assets/assets/temp/mcdonalds_logo.png": "d6550b5902b2eed02a23004f25d4a98a",
"assets/assets/tools/logos/4uRestFont-white.png": "0ec17f6c29969e366c8e7a9d24eb1fed",
"assets/assets/tools/logos/4uRest-DM-3.png": "d3f940bd85d48aeee63fc2988cd9d139",
"assets/assets/tools/logos/WBlue_4uRest.png": "3d99d2f95a3889fa9ee269ce072c6fde",
"assets/assets/tools/loading.gif": "a2dc9668f2cf170fe3efeb263128b0e7",
"assets/assets/tools/restaurant_background_op.png": "dd31897664b7e9c4e3260fb55e08a5ec",
"assets/assets/tools/restaurant_background.png": "4ebc8b66a0092bfc9e7c68951a305139",
"assets/assets/dev/product_modifiers.json": "3ba1d298861605d4743a0c19c3f42fa5",
"assets/assets/dev/dev_test.json": "6334ff10fde23b7613e8b48630821979",
"assets/assets/dev/structure.json": "d09bed2d2368231aabfbfbc2ffa9619d",
"assets/assets/dev/structure_dev.json": "a724a3147bdacde64bbafd92325e62d4",
"assets/assets/dev/response.json": "9023ba357b8aa2053a37387b246faeec",
"assets/assets/dev/branch_catalog.json": "a82dd13586ea3a0cf2c7c685caf8064c",
"assets/assets/dev/branch_catalog_updated.json": "4732152ba226a5ccdbcb298b67887a0d",
"canvaskit/skwasm.js": "5d4f9263ec93efeb022bb14a3881d240",
"canvaskit/skwasm.js.symbols": "c3c05bd50bdf59da8626bbe446ce65a3",
"canvaskit/canvaskit.js.symbols": "74a84c23f5ada42fe063514c587968c6",
"canvaskit/skwasm.wasm": "4051bfc27ba29bf420d17aa0c3a98bce",
"canvaskit/chromium/canvaskit.js.symbols": "ee7e331f7f5bbf5ec937737542112372",
"canvaskit/chromium/canvaskit.js": "901bb9e28fac643b7da75ecfd3339f3f",
"canvaskit/chromium/canvaskit.wasm": "399e2344480862e2dfa26f12fa5891d7",
"canvaskit/canvaskit.js": "738255d00768497e86aa4ca510cce1e1",
"canvaskit/canvaskit.wasm": "9251bb81ae8464c4df3b072f84aa969b",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03"};
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
