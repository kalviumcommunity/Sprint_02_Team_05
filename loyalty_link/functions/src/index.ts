import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

admin.initializeApp();

/**
 * ✅ Callable Function
 */
export const sayHello = functions.https.onCall((data, context) => {
  const name = data.name || "User";

  return {
    message: `Hello, ${name}!`,
  };
});

/**
 * ✅ Firestore Trigger Function
 */
export const onUserCreate = functions.firestore
  .document("users/{userId}")
  .onCreate((snap, context) => {
    const userData = snap.data();

    console.log("New user created:", userData);

    return null;
  });