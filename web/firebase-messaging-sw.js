importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-messaging.js");

firebase.initializeApp({
    apiKey: "AIzaSyBmuQgyJ3a9qHYdEwekEqvcuqlR2vxZCYc",
    authDomain: "med-x-a3e56.firebaseapp.com",
    projectId: "med-x-a3e56",
    storageBucket: "med-x-a3e56.appspot.com",
    messagingSenderId: "172675495639",
    appId: "1:172675495639:web:6419a49ad5300191fda292",
    measurementId: "G-4CYXVJYXE1"
});

const messaging = firebase.messaging();

// Optional:
messaging.onBackgroundMessage((message) => {
  console.log("onBackgroundMessage", message);
});