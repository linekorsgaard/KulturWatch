self.addEventListener('install', function (e) {
    e.waitUntil(
      caches.open('kulturwatch').then(function (cache) {
          return cache.addAll([
              '/',
              'index.html',
              'Offline.html',
              'SavedArticles.html',
              'css/bootstrap.css',
              'css/styles.css',
              'img/logo-inverted.png',
              'img/logo.png',
              'js/bootstrap.js'
          ]);
      })
    );
});

self.addEventListener('fetch', function (event) {
    console.log(event.request.url);
    event.respondWith(
        caches.match(event.request).then(
        function (response) {
            return response || fetch(event.request);
        })
    );
});