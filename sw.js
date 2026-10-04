const CACHE_NAME = "elresalah-v2";
const ASSETS_TO_CACHE = [
    "./",
    "./index.html",
    "./manifest.json",
    "./logo.png",
    "./share-thumb.jpg",
    "https://fonts.googleapis.com/css2?family=Cairo:wght@400;600;700;800&display=swap",
    "https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
];

// تثبيت الـ Service Worker وتخزين الملفات
self.addEventListener("install", (event) => {
    event.waitUntil(
        caches.open(CACHE_NAME).then((cache) => {
            return cache.addAll(ASSETS_TO_CACHE);
        }).then(() => self.skipWaiting())
    );
});

// تنشيط الـ Service Worker وحذف الكاش القديم
self.addEventListener("activate", (event) => {
    event.waitUntil(
        caches.keys().then((keys) => {
            return Promise.all(
                keys.map((key) => {
                    if (key !== CACHE_NAME) {
                        return caches.delete(key);
                    }
                })
            );
        }).then(() => self.clients.claim())
    );
});

// تقديم الملفات من الكاش أثناء انقطاع الإنترنت
self.addEventListener("fetch", (event) => {
    event.respondWith(
        caches.match(event.request).then((cachedResponse) => {
            if (cachedResponse) {
                return cachedResponse;
            }
            return fetch(event.request).then((networkResponse) => {
                return networkResponse;
            }).catch(() => {
                if (event.request.mode === 'navigate') {
                    return caches.match('./index.html');
                }
            });
        })
    );
});

// استقبال تنبيهات الأذان والإقامة في الخلفية
self.addEventListener("push", (event) => {
    const data = event.data ? event.data.json() : {};
    const title = data.title || "تطبيق الرسالة";
    const options = {
        body: data.body || "حان الآن موعد الصلاة",
        icon: "./logo.png",
        badge: "./logo.png",
        vibrate: [200, 100, 200, 100, 200],
        tag: "prayer-notification",
        renotify: true
    };
    event.waitUntil(self.registration.showNotification(title, options));
});

// عند النقر على الإشعار فتح التطبيق
self.addEventListener("notificationclick", (event) => {
    event.notification.close();
    event.waitUntil(
        clients.matchAll({ type: "window", includeUncontrolled: true }).then((clientList) => {
            if (clientList.length > 0) {
                return clientList[0].focus();
            }
            return clients.openWindow("./");
        })
    );
});
