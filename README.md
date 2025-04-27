🚨 Emergency Incident Response App

Save Lives, Fast.
A smart cross-platform app for real-time emergency incident reporting — ensuring help gets where it's needed, when it’s needed.

✨ Features
📍 Location-Based Incident Reporting — capture emergencies with live geolocation.

🆘 Multi-Type Emergency Support — fire, medical, police, and more.

📊 Incident Monitoring Dashboard — real-time updates and status tracking.

🔒 Secure Authentication — protected user and responder access.

🌎 Cross-Platform Deployment — Android, iOS, Web, Windows, macOS, Linux.

🎯 Smooth and Fast UX — designed for critical moments where speed matters.

🚀 Tech Stack

Technology	Usage
Flutter	Cross-platform frontend
Dart	Programming language
Firebase Auth	User authentication
Firestore	Real-time database
C++ / CMake / Swift	Native support for extended platforms
🛠️ Installation Guide
Prerequisites
Flutter SDK (>=3.19.2)

Dart

Firebase Project (for Authentication and Firestore)

Setup Instructions
Clone the Repository

bash
Copy
Edit
git clone https://github.com/Agostinejohn/emergency-incident-response-app.git
cd emergency-incident-response-app
Install Packages

bash
Copy
Edit
flutter pub get
Configure Firebase

Create a project on Firebase Console.

Enable Authentication and Firestore Database.

Download the google-services.json (for Android) and GoogleService-Info.plist (for iOS) files.

Place them inside the appropriate platform folders (android/app/ and ios/Runner/ respectively).

Run the App

bash
Copy
Edit
flutter run
Web Setup
bash
Copy
Edit
flutter build web
flutter run -d chrome
📂 Project Structure
css
Copy
Edit
emergency-incident-response-app/
├── lib/
│   ├── authentication/
│   ├── models/
│   ├── screens/
│   ├── services/
│   ├── theme/
│   └── main.dart
├── android/
├── ios/
├── web/
├── windows/
├── macos/
├── linux/
├── pubspec.yaml
└── README.md


🤝 Contribution
We welcome contributions to make this app even better!

Fork the repository

Create a feature branch (git checkout -b feature/AmazingFeature)

Commit your changes (git commit -m 'Add some AmazingFeature')

Push to your branch (git push origin feature/AmazingFeature)

Open a Pull Request

📄 License
This project is licensed under the MIT License.

