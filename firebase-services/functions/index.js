/* eslint-disable promise/always-return */
/* eslint-disable promise/no-nesting */
/* eslint-disable promise/catch-or-return */
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

  let questionId = req.body.data.question;
  let answer = req.body.data.answer
  const store = admin.firestore()
  store.collection('questions').doc(questionId).get().then(doc => {
      if (doc.exists) {
          console.log("Document exists, sending: ", {data: doc.data()})
          store.collection('questions').doc(questionId).collection('answers').limit(1).get().then(snapshot => {
            var realAnswer = snapshot.docs[0]
            var timeTaken = Date.now()/1000 - doc.updateTime._seconds
            var score = computeScore(answer, realAnswer.data().answer, timeTaken)
            res.send({data: {score}})
          })
      }
      else {
          res.send("Nothing")
      }
      return { data: doc.data() }
    }).catch(reason => {
        console.log(reason)
        res.send({reason})
  })
})

function computeScore(answer, real, timeTaken) {
  var score = 1000/(1 + Math.abs(answer - real) + Math.sqrt(timeTaken))
  return score
}


