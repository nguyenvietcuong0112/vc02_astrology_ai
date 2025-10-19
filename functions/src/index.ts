
import {onSchedule} from "firebase-functions/v2/scheduler";
import * as logger from "firebase-functions/logger";
import * as admin from "firebase-admin";

// Initialize the Firebase Admin SDK.
admin.initializeApp();

/**
 * A scheduled function that runs every day at 9:00 AM.
 * It sends a push notification with a sample horoscope to the
 * 'daily_horoscope' topic.
 */
export const sendDailyHoroscope = onSchedule("every 1 minutes", async () => {
  logger.info("Cron job started: Sending daily horoscope notification.");

  // The topic all apps are subscribed to.
  const topic = "daily_horoscope";

  // --- Get today's horoscope data (replace with your actual logic) ---
  // In a real app, you would fetch this from an API, a database,
  // or use a generative AI model. For now, we'll use a sample message.
  const horoscopeMessage = "Hôm nay là một ngày tuyệt vời để bắt đầu " +
    "những dự án mới. Năng lượng của bạn đang ở mức cao nhất!";
  // ---

  const message = {
    notification: {
      title: "✨ Tử Vi Hàng Ngày Của Bạn ✨",
      body: horoscopeMessage,
    },
    topic: topic,
  };

  try {
    // Send the message to the topic.
    const response = await admin.messaging().send(message);
    logger.info("Successfully sent message:", response);
  } catch (error) {
    logger.error("Error sending message:", error);
  }
});
