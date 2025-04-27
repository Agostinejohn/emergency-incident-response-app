Emergency Incident Response App
A cross-platform mobile application developed using Flutter, designed to facilitate rapid reporting and management of emergency incidents. The app aims to enhance communication between users and emergency response teams, ensuring timely assistance during critical situations.​

Features
Real-Time Incident Reporting: Users can report emergencies with details and optional media attachments.

Geolocation Integration: Automatically captures and shares the user's location to assist responders.

Multi-Platform Support: Compatible with Android, iOS, Web, Windows, macOS, and Linux platforms.

User Authentication: Secure login and registration system to protect user data.

Notification System: Receive updates and alerts regarding reported incidents.​

Technologies Used
Framework: Flutter

Language: Dart

Backend Services: Firebase (Authentication, Firestore, Cloud Functions)

State Management: Provider / BLoC (based on implementation)

Maps & Location: Google Maps API, Geolocator​
GitHub
+2
GitHub
+2
GitHub
+2

Getting Started
Prerequisites
Flutter SDK: Install Flutter

Dart SDK (usually included with Flutter)

An IDE like Android Studio or VS Code​

Installation
Clone the Repository:

bash
Copy
Edit
git clone https://github.com/Agostinejohn/emergency-incident-response-app.git
cd emergency-incident-response-app
Install Dependencies:

bash
Copy
Edit
flutter pub get
Configure Firebase:

Create a Firebase project at Firebase Console.

Add Android and iOS apps to the project.

Download the google-services.json (for Android) and GoogleService-Info.plist (for iOS) files.

Place them in the respective platform directories:

android/app/google-services.json

ios/Runner/GoogleService-Info.plist

Run the App:

bash
Copy
Edit
flutter run
Project Structure
bash
Copy
Edit
emergency-incident-response-app/
├── android/
├── ios/
├── lib/
│   ├── main.dart
│   ├── screens/
│   ├── widgets/
│   └── services/
├── test/
├── web/
├── windows/
├── macos/
├── linux/
├── pubspec.yaml
└── README.md
Contributing
Contributions are welcome! Please follow these steps:​

Fork the repository.

Create a new branch: git checkout -b feature/YourFeature

Commit your changes: git commit -m 'Add YourFeature'

Push to the branch: git push origin feature/YourFeature

Open a pull request.​
GitHub
+2
GitHub
+2
GitHub
+2

License
This project is licensed under the MIT License.
