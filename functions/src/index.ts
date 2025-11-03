
import {onSchedule} from "firebase-functions/v2/scheduler";
import * as logger from "firebase-functions/logger";
import * as admin from "firebase-admin";

// Initialize the Firebase Admin SDK.
admin.initializeApp();

/**
* A scheduled function that runs every 1 minute for testing purposes.
* It sends a push notification with a sample horoscope to the
* 'daily_horoscope' topic.
*/
export const sendDailyHoroscope = onSchedule("every 1 minutes", async () => {
  logger.info("Cron job started: Sending daily horoscope notification.");

  const payload = {
    notification: {
      title: "Tử vi hàng ngày của bạn đã đến!",
      body: "Hãy mở ứng dụng để khám phá những điều các vì sao nói về bạn hôm nay.",
    },
    topic: "daily_horoscope",
  };

  try {
    const response = await admin.messaging().send(payload);
    logger.info("Successfully sent daily horoscope notification:", response);
  } catch (error) {
    logger.error("Error sending daily horoscope notification:", error);
  }
});
