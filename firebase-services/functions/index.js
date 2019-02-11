const functions = require('firebase-functions');
var admin = require("firebase-admin");
var serviceAccount = require("./serviceAccountKey.json");

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: "https://estimator-81966.firebaseio.com"
});

// admin.initializeApp(functions.config().firebase)

// Create and Deploy Your First Cloud Functions
// https://firebase.google.com/docs/functions/write-firebase-functions

exports.helloWorld = functions.https.onRequest((request, response) => {
 response.send("Hello from Firebase!");
});

exports.answered = functions.https.onRequest((req, res) => {
  // console.log(req)
  // console.log(req.body)
  // console.log(req.body.data.question);
  let questionId = req.body.data.question;
  const store = admin.firestore()
  store.collection('questions').doc(questionId).get().then(doc => {
      if (doc.exists) {
          console.log(doc.data())
          res.send(doc.data())
      }
      else {
          res.send("Nothing")
      }
      return "hello bitches"
    }).catch(reason => {
        console.log(reason)
        res.send(reason)
  })
})
  // var ref = db.ref("questions/test");
  // ref.once("value", function(snapshot) {
  //   console.log(snapshot.val());
  // });

