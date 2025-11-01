// Minimal Service Worker with no caching behavior
// The original caching logic was removed to disable offline caching.

// Install - immediately take control (no cache operations)
self.addEventListener('install', (event) => {
    console.log('[Service Worker] Installed (no cache)');
    event.waitUntil(self.skipWaiting());
});

// Activate - claim clients (no cache cleanup)
self.addEventListener('activate', (event) => {
    console.log('[Service Worker] Activated (no cache)');
    event.waitUntil(self.clients.claim());
});

// No fetch listener - let browser handle all network requests (no caching)

// Keep notification handlers if needed in the future (they don't use cache)
self.addEventListener('push', (event) => {
    try {
        const data = event.data ? event.data.json() : { title: 'Reading Hub', body: 'You have a notification' };
        self.registration.showNotification(data.title, {
            body: data.body,
            icon: '/icon-192.png',
            badge: '/icon-192.png',
            vibrate: [200, 100, 200],
            tag: 'reading-hub-notification'
        });
    } catch (err) {
        console.log('[Service Worker] Push event error or empty payload', err);
    }
});

self.addEventListener('notificationclick', (event) => {
    event.notification.close();
    event.waitUntil(clients.openWindow('/'));
});

