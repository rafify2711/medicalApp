# MedicalApp

MedicalApp is a Flutter-based mobile application designed to streamline interactions between doctors and patients. The app provides medical services such as AI-based diagnosis, chat, appointment booking, and drug interaction checks.

## 📱 Features

### 👨‍⚕️ Doctor
- AI Diagnosis Support
- Manage Appointments
- View Patient History

### 🧑‍⚕️ Patient
- Book Appointments
- View Prescriptions
- Drug Interaction Checker
- Access Medical Reports

## 🧱 Architecture

The app follows **Clean Architecture** principles:
- **Presentation Layer**: Flutter UI + Cubit (Bloc)
- **Domain Layer**: Use Cases, Entities
- **Data Layer**: Repositories, Data Sources, Models

## 🔧 Technologies Used

- **Flutter**
- **Cubit (Bloc)** for state management
- **Retrofit** for API integration
- **Injectable & GetIt** for dependency injection
- **Firestore** (for appointment booking)
- **Custom Auth Backend**

## 🚀 Getting Started

### Prerequisites
- Flutter SDK
- Dart SDK
- Android Studio or VS Code

### Installation

```bash
git clone https://github.com/rafify2711/medicalApp.git
cd medicalApp
flutter pub get
flutter run
