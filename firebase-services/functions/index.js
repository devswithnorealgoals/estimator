const functions = require('firebase-functions');

// Create and Deploy Your First Cloud Functions
// https://firebase.google.com/docs/functions/write-firebase-functions

exports.helloWorld = functions.https.onRequest((request, response) => {
 response.send("Hello from Firebase!");
});

// Saves a message to the Firebase Realtime Database but sanitizes the text by removing swearwords.
exports.answered = functions.https.onCall((data, context) => {
    console.log(data);
    console.log(context);
  });
