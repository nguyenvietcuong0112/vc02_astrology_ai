# Blueprint

## Overview

This is a Flutter application that provides personalized horoscopes to users based on their birth information. The application uses the Gemini API to generate the horoscopes.

## Features

-   Users can enter their date, time, and place of birth.
-   **The application saves the user's birth information for future use.**
-   The application generates a personalized horoscope using the Gemini API.
-   The application supports both a standard and a premium horoscope.
-   The application has a dark and a light theme.
-   Users can share their generated horoscope with other apps.
-   **User Authentication:** Users can sign in to the app to have their birth information saved to their account.
-   **Push Notifications:** Users will receive daily horoscope notifications.

## Project Structure

-   `lib/main.dart`: Entry point of the application.
-   `lib/src/app/app.dart`: Contains the `AstrologyApp` widget, which is the root of the application.
-   `lib/src/core/theme/app_theme.dart`: Contains the `ThemeProvider` and the `AppTheme` class, which defines the light and dark themes.
-   `lib/src/features/horoscope/services/ai_horoscope_service.dart`: Contains the `getHoroscopeFromAI` function, which calls the Gemini API.
-   `lib/src/features/horoscope/ui/horoscope_home_page.dart`: The main screen of the app, which now handles saving and loading user birth information.
-   `lib/src/features/horoscope/ui/horoscope_result_card.dart`: Displays the horoscope result and includes the share button.
-   `lib/src/features/horoscope/ui/widgets/input_field.dart`: A custom text field widget.
-   `lib/src/features/horoscope/ui/widgets/result_section.dart`: A widget to display a section of the horoscope result.

## Current Task: Implement Push Notifications and User Authentication

I have added the following features:
1.  **Push Notifications:**
    -   Added the `firebase_messaging` package.
    -   Configured the Android and iOS projects to support push notifications.
    -   Implemented logic in `lib/main.dart` to request permission, handle incoming messages, and retrieve the FCM token.
2.  **User Authentication:**
    -   I will be using Firebase Authentication to allow users to sign in.
    -   The user's birth information will be stored in Cloud Firestore and linked to their account.