/* eslint-disable max-len */
// The Cloud Functions for Firebase SDK to set up triggers and logging.
import {onSchedule} from "firebase-functions/v2/scheduler";

import * as admin from "firebase-admin";

admin.initializeApp();


export const dailyCronJob = onSchedule("every day 05:00", async (event) => {
  try {
    console.log(event.jobName?.toString());
    console.log(event.scheduleTime?.toString());
    const barbersCollection = admin.firestore().collection("barbers");
    const snapshot = await barbersCollection.get();

    const updatePromises: unknown[] = [];
    snapshot.forEach((doc) => {
      updatePromises.push(doc.ref.update({available: false}));
    });

    await Promise.all(updatePromises);

    console.log("All barbers have been updated to unavailable.");
  } catch (error) {
    console.error("Error updating barbers: ", error);
  }

  try {
    const bookingsCollection = admin.firestore().collection("bookings");
    const snapshot = await bookingsCollection.where("status", "==", "waiting").get();

    if (snapshot.empty) {
      console.log("No bookings with status \"waiting\" found.");
      return;
    }

    const deletePromises: unknown[] = [];
    snapshot.forEach((doc) => {
      deletePromises.push(doc.ref.delete());
    });

    await Promise.all(deletePromises);

    console.log("All \"waiting\" bookings have been deleted.");
  } catch (error) {
    console.error("Error deleting bookings: ", error);
  }
});
