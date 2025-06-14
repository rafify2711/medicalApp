# Medical Application

A comprehensive medical application built with Flutter that provides various healthcare services and features for both doctors and patients.

## Features

### For Patients
- Book appointments with doctors
- View and manage appointments
- Access medical diagnosis
- Chat with medical chatbot
- View medical history
- Find nearby hospitals and pharmacies
- Receive notifications for appointments

### For Doctors
- Manage patient appointments
- View patient medical history
- Schedule management
- Chat with medical chatbot
- Medical diagnosis tools
- Patient records management

## Technical Features
- Multi-language support (English & Arabic)
- Light/Dark theme support
- Secure authentication
- Responsive design

## Getting Started

### Prerequisites
- Flutter SDK (latest version)
- Dart SDK (latest version)
- Android Studio / VS Code

### Installation

1. Clone the repository:
```bash
git clone https://github.com/yourusername/medicalApp.git
```

2. Navigate to the project directory:
```bash
cd medicalApp
```

3. Install dependencies:
```bash
flutter pub get
```

4. Run the app:
```bash
flutter run
```

## Project Structure

```
lib/
├── core/
│   ├── config/
│   ├── di/
│   ├── localization/
│   ├── theme/
│   └── utils/
├── features/
│   ├── auth/
│   ├── chat/
│   ├── hospitals_and_pharmacies/
│   ├── medical_diagnosis/
│   ├── reservation/
│   └── user_appointment/
└── main.dart
```

## Dependencies

- flutter_bloc: State management
- firebase_core: Firebase integration
- shared_preferences: Local storage
- flutter_localizations: Localization support
- get_it: Dependency injection
- injectable: Dependency injection code generation

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Contact

Your Name - your.email@example.com

Project Link: [https://github.com/yourusername/medicalApp](https://github.com/yourusername/medicalApp)
