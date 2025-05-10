import 'package:flutter/material.dart';


class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  static final Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'appName': 'Medical App',
      'save': 'Save',
      'cancel': 'Cancel',
      'edit': 'Edit',
      'delete': 'Delete',
      'loading': 'Loading...',
      'error': 'Error',
      'success': 'Success',
      'back': 'Back',
      'next': 'Next',
      'done': 'Done',
      'and': 'and',
      'login': 'Login',
      'signup': 'Sign Up',
      'email': 'Email',
      'password': 'Password',
      'confirmPassword': 'Confirm Password',
      'username': 'Username',
      'forgotPassword': 'Forgot Password?',
      'dontHaveAccount': "Don't have an account?",
      'haveAccount': 'Already have an account?',
      'welcomeBack': 'Welcome Back',
      'loginToContinue': 'Login to continue',
      'enterUsername': 'Enter your username',
      'pleaseEnterUsername': 'Please enter your username',
      'pleaseEnterEmail': 'Please enter your email',
      'invalidEmail': 'Please enter a valid email address',
      'pleaseEnterPassword': 'Please enter your password',
      'passwordTooShort': 'Password must be at least 6 characters',
      'pleaseConfirmPassword': 'Please confirm your password',
      'passwordsDoNotMatch': 'Passwords do not match',
      'termsAndPrivacy': 'By signing up, you agree to our',
      'termsOfUse': 'Terms of Use',
      'privacyPolicy': 'Privacy Policy',
      'welcome': 'Welcome',
      'welcomeDr': 'Welcome Dr.',
      'doctorHome': 'Doctor Home',
      'todayAppointments': "Today's Appointments",
      'availableSlots': 'Available Slots',
      'patientReviews': 'Patient Reviews',
      'addAppointment': 'Add Appointment',
      'viewPatients': 'View Patients',
      'chatBot': 'Chat Bot',
      'quickActions': 'Quick Actions',
      'features': 'Features',
      'appointments': 'Appointments',
      'upcomingAppointments': 'Upcoming Appointments',
      'pastAppointments': 'Past Appointments',
      'bookAppointment': 'Book Appointment',
      'cancelAppointment': 'Cancel Appointment',
      'rescheduleAppointment': 'Reschedule Appointment',
      'appointmentDetails': 'Appointment Details',
      'appointmentDate': 'Date',
      'appointmentTime': 'Time',
      'appointmentStatus': 'Status',
      'appointmentDoctor': 'Doctor',
      'appointmentPatient': 'Patient',
      'appointmentNotes': 'Notes',
      'settings': 'Settings',
      'language': 'Language',
      'notifications': 'Notifications',
      'theme': 'Theme',
      'about': 'About',
      'logout': 'Logout',
      'english': 'English',
      'arabic': 'Arabic',
      'darkMode': 'Dark Mode',
      'lightMode': 'Light Mode',
      'systemDefault': 'System Default',
      'profile': 'Profile',
      'personalInfo': 'Personal Information',
      'medicalInfo': 'Medical Information',
      'name': 'Name',
      'phone': 'Phone',
      'specialty': 'Specialty',
      'experience': 'Experience',
      'qualifications': 'Qualifications',
      'selectSpecialty': 'Select Specialty',
      'pleaseSelectSpecialty': 'Please select a specialty',
      'chat': 'Chat',
      'typeMessage': 'Type a message...',
      'send': 'Send',
      'attach': 'Attach',
      'noMessages': 'No messages yet',
      'online': 'Online',
      'offline': 'Offline',
      'typing': 'typing...',
      'patient': 'Patient',
      'doctor': 'Doctor',
      'role': 'Role',
      'categories': 'Categories',
      'diagnosis': 'Diagnosis',
      'doctors': 'Doctors',
      'drugs': 'Drugs',
      'schedule': 'Schedule',
      'prescriptions': 'Prescriptions',
      'upcomingSchedule': 'Upcoming Schedule',
      'noAppointmentsToday': 'You have no appointments today',
      'noData': 'No data',
      'pharmacies': 'Pharmacies',
      'hospitals': 'Hospitals',
      'specialties': 'Specialties',
      'favorites': 'Favorites',
      'paymentMethod': 'Payment Method',
      'help': 'Help',
      'doctorProfile': 'Doctor Profile',
      'professionalInfo': 'Professional Information',
      'notProvided': 'Not provided',
      'education': 'Education',
      'editProfile': 'Edit Profile',
      'fullName': 'Full Name',
      'address': 'Address',
      'experienceYears': 'Experience (years)',
      'workingHours': 'Working Hours',
      'workingDays': 'Working Days',
      'workingDaysHint': 'e.g., Monday - Friday',
      'workingHoursHint': 'e.g., 9:00 AM - 5:00 PM',
      'diseasePrediction': 'Disease Prediction',
      'selectDisease': 'Select a Disease',
      'chooseDisease': 'Choose a disease to analyze and get predictions',
      'uploadMedicalImage': 'Upload Medical Image',
      'uploadClearImage': 'Please upload a clear image for accurate prediction',
      'noImageSelected': 'No image selected',
      'gallery': 'Gallery',
      'camera': 'Camera',
      'analyzeImage': 'Analyze Image',
      'analyzingImage': 'Analyzing image...',
      'analysisResults': 'Analysis Results',
      'prediction': 'Prediction',
      'confidence': 'Confidence',
      'predictionHistory': 'Prediction History',
      'noPredictions': 'No predictions yet',
      'predictionDeleted': 'Prediction deleted',
      'failedToLoadImage': 'Failed to load image',
      'pleaseSelectImage': 'Please select an image first',
      'failedToLoadHistory': 'Failed to load prediction history',
      'failedToDelete': 'Failed to delete prediction',
      'covid19': 'COVID-19',
      'covid19Description': 'Predict COVID-19 from chest X-ray images',
      'brainTumor': 'Brain Tumor',
      'brainTumorDescription': 'Detect brain tumors from MRI scans',
      'kidneyStone': 'Kidney Stone',
      'kidneyStoneDescription': 'Identify kidney stones from ultrasound images',
      'skinCancer': 'Skin Cancer',
      'skinCancerDescription': 'Analyze skin lesions for cancer detection',
      'tuberculosis': 'Tuberculosis',
      'tuberculosisDescription': 'Detect tuberculosis from chest X-rays',
      'boneFracture': 'Bone Fracture',
      'boneFractureDescription': 'Identify bone fractures from X-ray images',
      'alzheimer': 'Alzheimer',
      'alzheimerDescription': 'Analyze brain scans for Alzheimer detection',
      'eyeDiseases': 'Eye Diseases',
      'eyeDiseasesDescription': 'Detect various eye conditions from retinal images',
      'male': 'Male',
      'female': 'Female',
      'other': 'Other',
      'describeProblem': 'Describe your problem',
      'enterProblem': 'Enter Your Problem Here...',
      'searchHint': 'Search doctors, specialties, hospitals...',
      'drugInteractionInfo': 'Select a disease and a drug to check their interaction',
      'unknown': 'Unknown',
      'hospitalType': 'Hospital Type',
      'pharmacyType': 'Pharmacy Type',
      'location': 'Location',
      'contact': 'Contact',
      'website': 'Website',
      'rating': 'Rating',
      'reviews': 'Reviews',
      'openNow': 'Open Now',
      'closed': 'Closed',
      'services': 'Services',
      'amenities': 'Amenities',
      'insurance': 'Insurance',
      'paymentMethods': 'Payment Methods',
      'emergency': 'Emergency',
      'nonEmergency': 'Non-Emergency',
      'specialized': 'Specialized',
      'general': 'General',
      'private': 'Private',
      'public': 'Public',
      'clinic': 'Clinic',
      'medicalCenter': 'Medical Center',
      'hospital': 'Hospital',
      'pharmacy': 'Pharmacy',
      'drugstore': 'Drugstore',
      'medicalStore': 'Medical Store',
      'viewOnMap': 'View on Map',
      'getDirections': 'Get Directions',
      'callNow': 'Call Now',
      'share': 'Share',
      'report': 'Report',
      'confirm': 'Confirm',
      'submit': 'Submit',
      'reset': 'Reset',
      'filter': 'Filter',
      'sort': 'Sort',
      'viewAll': 'View All',
      'showMore': 'Show More',
      'showLess': 'Show Less',
      'noResults': 'No Results Found',
      'tryAgain': 'Try Again',
      'errorOccurred': 'An Error Occurred',
      'checkConnection': 'Please check your internet connection',
      'retry': 'Retry',
      'close': 'Close',
      'ok': 'OK',
      'yes': 'Yes',
      'no': 'No',
      'maybe': 'Maybe',
      'later': 'Later',
      'skip': 'Skip',
      'continue': 'Continue',
      'finish': 'Finish',
      'start': 'Start',
      'stop': 'Stop',
      'pause': 'Pause',
      'resume': 'Resume',
      'refresh': 'Refresh',
      'update': 'Update',
      'install': 'Install',
      'uninstall': 'Uninstall',
      'download': 'Download',
      'upload': 'Upload',
      'sync': 'Sync',
      'backup': 'Backup',
      'restore': 'Restore',
      'preferences': 'Preferences',
      'account': 'Account',
      'security': 'Security',
      'privacy': 'Privacy',
      'support': 'Support',
      'feedback': 'Feedback',
      'version': 'Version',
      'terms': 'Terms',
      'conditions': 'Conditions',
      'licenses': 'Licenses',
      'credits': 'Credits',
      'attributions': 'Attributions',
      'copyright': 'Copyright',
      'allRightsReserved': 'All Rights Reserved',
      'checkDiseaseDrugInteraction': 'Check Disease-Drug Interaction',
      'disease': 'Disease',
      'drug': 'Drug',
      'checkInteraction': 'Check Interaction',
      'interactionResult': 'Interaction Result',
      'checkingInteraction': 'Checking interaction...',
      'drugInteraction': 'Drug Interaction',
      'drugDisease': 'Drug-Disease',
      'substitutions': 'Substitutions',
      'findDrugSubstitutions': 'Find Drug Substitutions',
      'selectDrugForAlternatives': 'Select a drug to find suitable alternatives',
      'alternativeDrugs': 'Alternative Drugs',
      'findingAlternatives': 'Finding alternatives...',
      'checkDrugInteractions': 'Check Drug Interactions',
      'selectTwoDrugs': 'Select two drugs to check their interaction',
      'firstDrug': 'First Drug',
      'secondDrug': 'Second Drug',
      'pleaseSelectDrug': 'Please select a drug',
      'pleaseSelectBothDrugs': 'Please select both drugs',
      'pleaseSelectDiseaseAndDrug': 'Please select both disease and drug',
      'appointmentBooked': 'Appointment Booked Successfully',
      'appointmentCancelled': 'Appointment Cancelled',
      'appointmentRescheduled': 'Appointment Rescheduled',
      'selectDate': 'Select Date',
      'selectTime': 'Select Time',
      'appointmentDuration': 'Duration',
      'appointmentType': 'Type',
      'appointmentReason': 'Reason',
      'appointmentLocation': 'Location',
      'appointmentConfirmation': 'Appointment Confirmation',
      'appointmentReminder': 'Appointment Reminder',
      'appointmentHistory': 'Appointment History',
      'appointmentSummary': 'Appointment Summary',
      'appointmentFeedback': 'Appointment Feedback',
      'appointmentRating': 'Rate Your Experience',
      'appointmentReview': 'Write a Review',
      'appointmentFollowUp': 'Follow-up Appointment',
      'appointmentEmergency': 'Emergency Appointment',
      'appointmentRegular': 'Regular Appointment',
      'appointmentConsultation': 'Consultation',
      'appointmentCheckup': 'Check-up',
      'hospitalDetails': 'Hospital Details',
      'pharmacyDetails': 'Pharmacy Details',
      'hospitalName': 'Hospital Name',
      'pharmacyName': 'Pharmacy Name',
      'hospitalLocation': 'Location',
      'pharmacyLocation': 'Location',
      'hospitalContact': 'Contact',
      'pharmacyContact': 'Contact',
      'hospitalWebsite': 'Website',
      'pharmacyWebsite': 'Website',
      'hospitalRating': 'Rating',
      'pharmacyRating': 'Rating',
      'hospitalReviews': 'Reviews',
      'pharmacyReviews': 'Reviews',
      'hospitalServices': 'Services',
      'pharmacyServices': 'Services',
      'hospitalAmenities': 'Amenities',
      'pharmacyAmenities': 'Amenities',
      'hospitalInsurance': 'Insurance',
      'pharmacyInsurance': 'Insurance',
      'hospitalPaymentMethods': 'Payment Methods',
      'pharmacyPaymentMethods': 'Payment Methods',
      'hospitalEmergency': 'Emergency',
      'pharmacyEmergency': 'Emergency',
      'hospitalNonEmergency': 'Non-Emergency',
      'pharmacyNonEmergency': 'Non-Emergency',
      'hospitalSpecialized': 'Specialized',
      'pharmacySpecialized': 'Specialized',
      'hospitalGeneral': 'General',
      'pharmacyGeneral': 'General',
      'hospitalPrivate': 'Private',
      'pharmacyPrivate': 'Private',
      'hospitalPublic': 'Public',
      'pharmacyPublic': 'Public',
      'hospitalClinic': 'Clinic',
      'pharmacyClinic': 'Clinic',
      'hospitalMedicalCenter': 'Medical Center',
      'pharmacyMedicalCenter': 'Medical Center',
      'doctorList': 'Doctor List',
      'doctorName': 'Doctor Name',
      'doctorSpecialty': 'Specialty',
      'doctorExperience': 'Experience',
      'doctorQualifications': 'Qualifications',
      'doctorEducation': 'Education',
      'doctorLanguages': 'Languages',
      'doctorAvailability': 'Availability',
      'doctorSchedule': 'Schedule',
      'doctorFees': 'Fees',
      'doctorRating': 'Rating',
      'doctorReviews': 'Reviews',
      'doctorContact': 'Contact',
      'doctorLocation': 'Location',
      'doctorWebsite': 'Website',
      'doctorSocialMedia': 'Social Media',
      'doctorBio': 'Biography',
      'doctorServices': 'Services',
      'doctorTreatments': 'Treatments',
      'doctorSpecializations': 'Specializations',
      'doctorCertifications': 'Certifications',
      'doctorMemberships': 'Memberships',
      'doctorPublications': 'Publications',
      'doctorAwards': 'Awards',
      'doctorResearch': 'Research',
      'doctorTeaching': 'Teaching',
      'doctorConsultation': 'Consultation',
      'doctorFollowUp': 'Follow-up',
      'doctorEmergency': 'Emergency',
      'doctorRegular': 'Regular',
      'doctorOnline': 'Online',
      'doctorOffline': 'Offline',
      'doctorAvailable': 'Available',
      'doctorUnavailable': 'Unavailable',
      'doctorBusy': 'Busy',
      'doctorOnLeave': 'On Leave',
      'doctorOnCall': 'On Call',
      'doctorOnDuty': 'On Duty',
      'doctorOnVacation': 'On Vacation',
      'doctorOnSickLeave': 'On Sick Leave',
      'doctorOnTraining': 'On Training',
      'doctorOnConference': 'On Conference',
      'doctorOnResearch': 'On Research',
      'doctorOnTeaching': 'On Teaching',
      'doctorOnConsultation': 'On Consultation',
      'doctorOnFollowUp': 'On Follow-up',
      'doctorOnEmergency': 'On Emergency',
      'doctorOnRegular': 'On Regular',
      'doctorOnOnline': 'On Online',
      'doctorOnOffline': 'On Offline',
      'drugInteractionTitle': 'Drug Interaction',
      'drugInteractionSubtitle': 'Check interactions between drugs',
      'drugDiseaseTitle': 'Drug-Disease Interaction',
      'drugDiseaseSubtitle': 'Check interactions between drugs and diseases',
      'drugSubstitutionsTitle': 'Drug Substitutions',
      'drugSubstitutionsSubtitle': 'Find alternative drugs',
      'drugInteractionResult': 'Interaction Result',
      'drugDiseaseResult': 'Disease-Drug Interaction Result',
      'drugSubstitutionsResult': 'Alternative Drugs Result',
      'drugInteractionLoading': 'Checking drug interaction...',
      'drugDiseaseLoading': 'Checking disease-drug interaction...',
      'drugSubstitutionsLoading': 'Finding alternative drugs...',
      'drugInteractionError': 'Error checking drug interaction',
      'drugDiseaseError': 'Error checking disease-drug interaction',
      'drugSubstitutionsError': 'Error finding alternative drugs',
      'drugInteractionSuccess': 'Drug interaction checked successfully',
      'drugDiseaseSuccess': 'Disease-drug interaction checked successfully',
      'drugSubstitutionsSuccess': 'Alternative drugs found successfully',
      'drugDiseaseInfo': 'Select a disease and a drug to check their interaction',
      'drugSubstitutionsInfo': 'Select a drug to find suitable alternatives',
      'drugInteractionWarning': 'Warning: This is not medical advice. Please consult your doctor.',
      'drugDiseaseWarning': 'Warning: This is not medical advice. Please consult your doctor.',
      'drugSubstitutionsWarning': 'Warning: This is not medical advice. Please consult your doctor.',
      'drugInteractionDisclaimer': 'The information provided is for educational purposes only.',
      'drugDiseaseDisclaimer': 'The information provided is for educational purposes only.',
      'drugSubstitutionsDisclaimer': 'The information provided is for educational purposes only.',
      'drugInteractionNote': 'Note: Always consult your healthcare provider before taking any medications.',
      'drugDiseaseNote': 'Note: Always consult your healthcare provider before taking any medications.',
      'drugSubstitutionsNote': 'Note: Always consult your healthcare provider before taking any medications.',
      'diseaseDrugInteraction': 'Disease-Drug Interaction',
      'diseaseDrugInteractionInfo': 'Select a disease and a drug to check their interaction',
      'diseaseDrugInteractionResult': 'Disease-Drug Interaction Result',
      'diseaseDrugInteractionLoading': 'Checking disease-drug interaction...',
      'diseaseDrugInteractionError': 'Error checking disease-drug interaction',
      'diseaseDrugInteractionSuccess': 'Disease-drug interaction checked successfully',
      'diseaseDrugInteractionWarning': 'Warning: This is not medical advice. Please consult your doctor.',
      'diseaseDrugInteractionDisclaimer': 'The information provided is for educational purposes only.',
      'diseaseDrugInteractionNote': 'Note: Always consult your healthcare provider before taking any medications.',
      'home': 'Home',
      'homeScreen': 'Home Screen',
      'doctorsScreen': 'Doctors Screen',
      'cleanerScreen': 'Cleaner Screen',
      'recordScreen': 'Record Screen',
      'cleaner': 'Cleaner',
      'record': 'Record',
      'addSchedule': 'Add Schedule',
      'noScheduleAvailable': 'No Schedule Available',
      'noPharmaciesAvailable': 'No Pharmacies Available',
      'noPharmaciesFound': 'No Pharmacies Found',
      'branch': 'Branch',
      'viewWebsite': 'View Website',
      'noHospitalsAvailable': 'No Hospitals Available',
      'mySchedule': 'My Schedule',
      'addMoreSlots': 'Add More Slots',
      'search': 'Search',
      'searchDoctors': 'Search Doctors',
      'searchHospitals': 'Search Hospitals',
      'searchPharmacies': 'Search Pharmacies',
      'searchSpecialties': 'Search Specialties',
      'noResultsFound': 'No Results Found',
      'startSearching': 'Start Searching...',
      'noSpecialtiesFound': 'No Specialties Found',
      'noDoctorsFound': 'No Doctors Found',
      'noHospitalsFound': 'No Hospitals Found',
      'findYourDoctor': 'Find Your Doctor',
      'browseAndBookAppointments': 'Browse and book appointments with top doctors',
      'branches': 'Branches',
      'visitWebsite': 'Visit Website',
      'noAppointmentsFound': 'No Appointments Found',
      'viewProfile': 'View Profile',
      'app': 'App',
      'welcomeDescription': 'Your comprehensive medical companion for better healthcare',
      'signUp': 'Sign Up',
      'makeReservation': 'Make Reservation',
      'selectedDate': 'Selected Date',
      'noDateSelected': 'No date selected',
      'availableTime': 'Available Time',
      'noAvailableSlots': 'No available slots',
      'patientDetails': 'Patient Details',
      'yourself': 'Yourself',
      'anotherPerson': 'Another Person',
      'age': 'Age',
      'gender': 'Gender',
      'confirmReservation': 'Confirm Reservation',
      'missingInfo': 'Missing required information',
      'selectTimeSlot': 'Please select a time slot',
      'userNotFound': 'User not found',
      'reservationSuccess': 'Reservation created successfully',
      // Chatbot
      'chatbot': 'Medical Assistant',
      'chatbotGreeting': 'Hello! How can I help you today?',
      'chatbotPlaceholder': 'Type your message here...',
      'chatbotSend': 'Send',
      'chatbotTyping': 'Typing...',
      'chatbotError': 'Sorry, I encountered an error. Please try again.',
      'chatbotNoResponse': 'No response received. Please try again.',
      
      // Prescription
      'prescriptionDetails': 'Prescription Details',
      'prescriptionDate': 'Prescription Date',
      'prescriptionDoctor': 'Prescribed By',
      'prescriptionMedicines': 'Medicines',
      'prescriptionDosage': 'Dosage',
      'prescriptionDuration': 'Duration',
      'prescriptionNotes': 'Notes',
      'noPrescriptions': 'No prescriptions found',
      'addPrescription': 'Add Prescription',
      'editPrescription': 'Edit Prescription',
      'deletePrescription': 'Delete Prescription',
      'readPrescription': 'Read Prescription',
      'selectImageFirst': 'Please select an image first',
      'uploadImage': 'Upload Image',
      'takePhoto': 'Take a Photo',
      'read': 'Read',
      'processingImage': 'Processing image...',
      'detectedText': 'Detected Text',
      
      // Appointment List
      'appointmentList': 'Appointments',
      'date': 'Date',
      'status': 'Status',
      'noAppointments': 'No appointments found',
      'noUpcomingAppointments': 'No upcoming appointments',
      'noPastAppointments': 'No past appointments',
      'noCancelledAppointments': 'No cancelled appointments',
      'noCompletedAppointments': 'No completed appointments',
      'noAppointmentsThisWeek': 'No appointments this week',
      'noAppointmentsThisMonth': 'No appointments this month',
      'appointmentConfirmed': 'Confirmed',
      'appointmentPending': 'Pending',
      'appointmentCompleted': 'Completed',
      'cancelled': 'Cancelled',
      'upcoming': 'Upcoming',
      'completed': 'Completed',
      'dateStatus': 'Date Status',
      'today': 'Today',
      'tomorrow': 'Tomorrow',
      'thisWeek': 'This Week',
      'nextWeek': 'Next Week',
      'thisMonth': 'This Month',
      'nextMonth': 'Next Month',
      'past': 'Past',
      'future': 'Future',
      'dateRange': 'Date Range',
      'startDate': 'Start Date',
      'endDate': 'End Date',
      'selectDateRange': 'Select Date Range',
      'invalidDateRange': 'Invalid Date Range',
      'dateFormat': 'Date Format',
      'timeFormat': 'Time Format',
      
      // Edit Profile
      'personalInformation': 'Personal Information',
      'medicalInformation': 'Medical Information',
      'saveChanges': 'Save Changes',
      'cancelChanges': 'Cancel Changes',
      'profileUpdated': 'Profile updated successfully',
      'profileUpdateError': 'Failed to update profile',
      'uploadPhoto': 'Upload Photo',
      'removePhoto': 'Remove Photo',
      'changePassword': 'Change Password',
      'currentPassword': 'Current Password',
      'newPassword': 'New Password',
      'confirmNewPassword': 'Confirm New Password',
      'passwordMismatch': 'Passwords do not match',
      'passwordUpdated': 'Password updated successfully',
      'passwordUpdateError': 'Failed to update password',
      'medicationHistory': 'Medication History',
      'noProfileData': 'No profile data available',
      'selectDateOfBirth': 'Select Date of Birth',
      'dob': 'Date of Birth',
    },
    'ar': {
      'appName': 'تطبيق طبي',
      'save': 'حفظ',
      'cancel': 'إلغاء',
      'edit': 'تعديل',
      'delete': 'حذف',
      'loading': 'جاري التحميل...',
      'error': 'خطأ',
      'success': 'نجاح',
      'back': 'رجوع',
      'next': 'التالي',
      'done': 'تم',
      'and': 'و',
      'login': 'تسجيل الدخول',
      'signup': 'إنشاء حساب',
      'email': 'البريد الإلكتروني',
      'password': 'كلمة المرور',
      'confirmPassword': 'تأكيد كلمة المرور',
      'username': 'اسم المستخدم',
      'forgotPassword': 'نسيت كلمة المرور؟',
      'dontHaveAccount': 'ليس لديك حساب؟',
      'haveAccount': 'لديك حساب بالفعل؟',
      'welcomeBack': 'مرحباً بعودتك',
      'loginToContinue': 'سجل دخولك للمتابعة',
      'enterUsername': 'أدخل اسم المستخدم',
      'pleaseEnterUsername': 'الرجاء إدخال اسم المستخدم',
      'pleaseEnterEmail': 'الرجاء إدخال البريد الإلكتروني',
      'invalidEmail': 'الرجاء إدخال بريد إلكتروني صحيح',
      'pleaseEnterPassword': 'الرجاء إدخال كلمة المرور',
      'passwordTooShort': 'يجب أن تكون كلمة المرور 6 أحرف على الأقل',
      'pleaseConfirmPassword': 'الرجاء تأكيد كلمة المرور',
      'passwordsDoNotMatch': 'كلمات المرور غير متطابقة',
      'termsAndPrivacy': 'بالتسجيل، أنت توافق على',
      'termsOfUse': 'شروط الاستخدام',
      'privacyPolicy': 'سياسة الخصوصية',
      'welcome': 'مرحباً',
      'welcomeDr': 'مرحباً د.',
      'doctorHome': 'الصفحة الرئيسية للطبيب',
      'todayAppointments': 'مواعيد اليوم',
      'availableSlots': 'المواعيد المتاحة',
      'patientReviews': 'تقييمات المرضى',
      'addAppointment': 'إضافة موعد',
      'viewPatients': 'عرض المرضى',
      'chatBot': 'المساعد الطبي',
      'quickActions': 'إجراءات سريعة',
      'features': 'المميزات',
      'appointments': 'المواعيد',
      'upcomingAppointments': 'المواعيد القادمة',
      'pastAppointments': 'المواعيد السابقة',
      'bookAppointment': 'حجز موعد',
      'cancelAppointment': 'إلغاء الموعد',
      'rescheduleAppointment': 'إعادة جدولة الموعد',
      'appointmentDetails': 'تفاصيل الموعد',
      'appointmentDate': 'التاريخ',
      'appointmentTime': 'الوقت',
      'appointmentStatus': 'الحالة',
      'appointmentDoctor': 'الطبيب',
      'appointmentPatient': 'المريض',
      'appointmentNotes': 'ملاحظات',
      'settings': 'الإعدادات',
      'language': 'اللغة',
      'notifications': 'الإشعارات',
      'theme': 'المظهر',
      'about': 'حول التطبيق',
      'logout': 'تسجيل الخروج',
      'english': 'الإنجليزية',
      'arabic': 'العربية',
      'darkMode': 'الوضع الداكن',
      'lightMode': 'الوضع الفاتح',
      'systemDefault': 'إعدادات النظام',
      'profile': 'الملف الشخصي',
      'personalInfo': 'المعلومات الشخصية',
      'medicalInfo': 'المعلومات الطبية',
      'name': 'الاسم',
      'phone': 'الهاتف',
      'specialty': 'التخصص',
      'experience': 'الخبرة',
      'qualifications': 'المؤهلات',
      'selectSpecialty': 'اختر التخصص',
      'pleaseSelectSpecialty': 'الرجاء اختيار التخصص',
      'chat': 'المحادثة',
      'typeMessage': 'اكتب رسالة...',
      'send': 'إرسال',
      'attach': 'إرفاق',
      'noMessages': 'لا توجد رسائل بعد',
      'online': 'متصل',
      'offline': 'غير متصل',
      'typing': 'يكتب...',
      'patient': 'مريض',
      'doctor': 'طبيب',
      'role': 'الدور',
      'categories': 'التصنيفات',
      'diagnosis': 'التشخيص',
      'doctors': 'الأطباء',
      'drugs': 'الأدوية',
      'schedule': 'الجدول',
      'prescriptions': 'الوصفات الطبية',
      'upcomingSchedule': 'الجدول القادم',
      'noAppointmentsToday': 'ليس لديك مواعيد اليوم',
      'noData': 'لا توجد بيانات',
      'pharmacies': 'الصيدليات',
      'hospitals': 'المستشفيات',
      'specialties': 'التخصصات',
      'favorites': 'المفضلة',
      'paymentMethod': 'طريقة الدفع',
      'help': 'المساعدة',
      'doctorProfile': 'الملف الشخصي للطبيب',
      'professionalInfo': 'المعلومات المهنية',
      'notProvided': 'غير متوفر',
      'education': 'التعليم',
      'editProfile': 'تعديل الملف الشخصي',
      'fullName': 'الاسم الكامل',
      'address': 'العنوان',
      'experienceYears': 'الخبرة (سنوات)',
      'workingHours': 'ساعات العمل',
      'workingDays': 'أيام العمل',
      'workingDaysHint': 'مثال: الاثنين - الجمعة',
      'workingHoursHint': 'مثال: 9:00 صباحاً - 5:00 مساءً',
      'diseasePrediction': 'التشخيص الطبي',
      'selectDisease': 'اختر المرض',
      'chooseDisease': 'اختر مرضاً للتحليل والحصول على التوقعات',
      'uploadMedicalImage': 'رفع صورة طبية',
      'uploadClearImage': 'يرجى رفع صورة واضحة للحصول على توقع دقيق',
      'noImageSelected': 'لم يتم اختيار صورة',
      'gallery': 'المعرض',
      'camera': 'الكاميرا',
      'analyzeImage': 'تحليل الصورة',
      'analyzingImage': 'جاري تحليل الصورة...',
      'analysisResults': 'نتائج التحليل',
      'prediction': 'التوقع',
      'confidence': 'مستوى الثقة',
      'predictionHistory': 'سجل التوقعات',
      'noPredictions': 'لا توجد توقعات حتى الآن',
      'predictionDeleted': 'تم حذف التوقع',
      'failedToLoadImage': 'فشل تحميل الصورة',
      'pleaseSelectImage': 'يرجى اختيار صورة أولاً',
      'failedToLoadHistory': 'فشل تحميل سجل التوقعات',
      'failedToDelete': 'فشل حذف التوقع',
      'covid19': 'كوفيد-19',
      'covid19Description': 'التنبؤ بكوفيد-19 من صور الأشعة السينية للصدر',
      'brainTumor': 'ورم الدماغ',
      'brainTumorDescription': 'كشف أورام الدماغ من صور الرنين المغناطيسي',
      'kidneyStone': 'حصى الكلى',
      'kidneyStoneDescription': 'تحديد حصى الكلى من صور الموجات فوق الصوتية',
      'skinCancer': 'سرطان الجلد',
      'skinCancerDescription': 'تحليل آفات الجلد للكشف عن السرطان',
      'tuberculosis': 'السل',
      'tuberculosisDescription': 'كشف السل من صور الأشعة السينية للصدر',
      'boneFracture': 'كسر العظام',
      'boneFractureDescription': 'تحديد كسور العظام من صور الأشعة السينية',
      'alzheimer': 'الزهايمر',
      'alzheimerDescription': 'تحليل صور الدماغ للكشف عن الزهايمر',
      'eyeDiseases': 'أمراض العين',
      'eyeDiseasesDescription': 'كشف مختلف حالات العين من صور الشبكية',
      'male': 'ذكر',
      'female': 'أنثى',
      'other': 'آخر',
      'describeProblem': 'صف مشكلتك',
      'enterProblem': 'أدخل مشكلتك هنا...',
      'searchHint': 'ابحث عن أطباء، تخصصات، مستشفيات...',
      'drugInteractionInfo': 'اختر مرضاً ودواءً للتحقق من تفاعلهما',
      'unknown': 'غير معروف',
      'hospitalType': 'نوع المستشفى',
      'pharmacyType': 'نوع الصيدلية',
      'location': 'الموقع',
      'contact': 'اتصل بنا',
      'website': 'الموقع الإلكتروني',
      'rating': 'التقييم',
      'reviews': 'المراجعات',
      'openNow': 'مفتوح الآن',
      'closed': 'مغلق',
      'services': 'الخدمات',
      'amenities': 'المرافق',
      'insurance': 'التأمين',
      'paymentMethods': 'طرق الدفع',
      'emergency': 'طوارئ',
      'nonEmergency': 'غير طارئ',
      'specialized': 'متخصص',
      'general': 'عام',
      'private': 'خاص',
      'public': 'حكومي',
      'clinic': 'عيادة',
      'medicalCenter': 'مركز طبي',
      'hospital': 'مستشفى',
      'pharmacy': 'صيدلية',
      'drugstore': 'صيدلية',
      'medicalStore': 'متجر طبي',
      'viewOnMap': 'عرض على الخريطة',
      'getDirections': 'الحصول على الاتجاهات',
      'callNow': 'اتصل الآن',
      'share': 'مشاركة',
      'report': 'تقرير',
      'confirm': 'تأكيد',
      'submit': 'إرسال',
      'reset': 'إعادة تعيين',
      'filter': 'تصفية',
      'sort': 'ترتيب',
      'viewAll': 'عرض الكل',
      'showMore': 'عرض المزيد',
      'showLess': 'عرض أقل',
      'noResults': 'لم يتم العثور على نتائج',
      'tryAgain': 'حاول مرة أخرى',
      'errorOccurred': 'حدث خطأ',
      'checkConnection': 'يرجى التحقق من اتصال الإنترنت',
      'retry': 'إعادة المحاولة',
      'close': 'إغلاق',
      'ok': 'موافق',
      'yes': 'نعم',
      'no': 'لا',
      'maybe': 'ربما',
      'later': 'لاحقاً',
      'skip': 'تخطي',
      'continue': 'متابعة',
      'finish': 'إنهاء',
      'start': 'بدء',
      'stop': 'إيقاف',
      'pause': 'إيقاف مؤقت',
      'resume': 'استئناف',
      'refresh': 'تحديث',
      'update': 'تحديث',
      'install': 'تثبيت',
      'uninstall': 'إلغاء التثبيت',
      'download': 'تحميل',
      'upload': 'رفع',
      'sync': 'مزامنة',
      'backup': 'نسخ احتياطي',
      'restore': 'استعادة',
      'preferences': 'التفضيلات',
      'account': 'الحساب',
      'security': 'الأمان',
      'support': 'الدعم',
      'feedback': 'الملاحظات',
      'version': 'الإصدار',
      'terms': 'الشروط',
      'conditions': 'الأحكام',
      'licenses': 'التراخيص',
      'credits': 'الاعتمادات',
      'attributions': 'الإسناد',
      'copyright': 'حقوق النشر',
      'allRightsReserved': 'جميع الحقوق محفوظة',
      'checkDiseaseDrugInteraction': 'فحص تفاعل المرض مع الدواء',
      'disease': 'المرض',
      'drug': 'الدواء',
      'checkInteraction': 'فحص التفاعل',
      'interactionResult': 'نتيجة التفاعل',
      'checkingInteraction': 'جاري فحص التفاعل...',
      'drugInteraction': 'تفاعل الأدوية',
      'drugDisease': 'تفاعل الدواء مع المرض',
      'substitutions': 'البدائل',
      'findDrugSubstitutions': 'البحث عن بدائل الأدوية',
      'selectDrugForAlternatives': 'اختر دواءً للعثور على بدائل مناسبة',
      'alternativeDrugs': 'الأدوية البديلة',
      'findingAlternatives': 'جاري البحث عن البدائل...',
      'checkDrugInteractions': 'فحص تفاعلات الأدوية',
      'selectTwoDrugs': 'اختر دواءين للتحقق من تفاعلهما',
      'firstDrug': 'الدواء الأول',
      'secondDrug': 'الدواء الثاني',
      'pleaseSelectDrug': 'الرجاء اختيار دواء',
      'pleaseSelectBothDrugs': 'الرجاء اختيار الدواءين',
      'pleaseSelectDiseaseAndDrug': 'الرجاء اختيار المرض والدواء',
      'appointmentBooked': 'تم حجز الموعد بنجاح',
      'appointmentCancelled': 'تم إلغاء الموعد',
      'appointmentRescheduled': 'تم إعادة جدولة الموعد',
      'selectDate': 'اختر التاريخ',
      'selectTime': 'اختر الوقت',
      'appointmentDuration': 'المدة',
      'appointmentType': 'النوع',
      'appointmentReason': 'السبب',
      'appointmentLocation': 'الموقع',
      'appointmentConfirmation': 'تأكيد الموعد',
      'appointmentReminder': 'تذكير بالموعد',
      'appointmentHistory': 'سجل المواعيد',
      'appointmentSummary': 'ملخص الموعد',
      'appointmentFeedback': 'تقييم الموعد',
      'appointmentRating': 'قيم تجربتك',
      'appointmentReview': 'اكتب تقييماً',
      'appointmentFollowUp': 'موعد متابعة',
      'appointmentEmergency': 'موعد طوارئ',
      'appointmentRegular': 'موعد عادي',
      'appointmentConsultation': 'استشارة',
      'appointmentCheckup': 'فحص دوري',
      'hospitalDetails': 'تفاصيل المستشفى',
      'pharmacyDetails': 'تفاصيل الصيدلية',
      'hospitalName': 'اسم المستشفى',
      'pharmacyName': 'اسم الصيدلية',
      'hospitalLocation': 'الموقع',
      'pharmacyLocation': 'الموقع',
      'hospitalContact': 'اتصل بنا',
      'pharmacyContact': 'اتصل بنا',
      'hospitalWebsite': 'الموقع الإلكتروني',
      'pharmacyWebsite': 'الموقع الإلكتروني',
      'hospitalRating': 'التقييم',
      'pharmacyRating': 'التقييم',
      'hospitalReviews': 'المراجعات',
      'pharmacyReviews': 'المراجعات',
      'hospitalServices': 'الخدمات',
      'pharmacyServices': 'الخدمات',
      'hospitalAmenities': 'المرافق',
      'pharmacyAmenities': 'المرافق',
      'hospitalInsurance': 'التأمين',
      'pharmacyInsurance': 'التأمين',
      'hospitalPaymentMethods': 'طرق الدفع',
      'pharmacyPaymentMethods': 'طرق الدفع',
      'hospitalEmergency': 'طوارئ',
      'pharmacyEmergency': 'طوارئ',
      'hospitalNonEmergency': 'غير طارئ',
      'pharmacyNonEmergency': 'غير طارئ',
      'hospitalSpecialized': 'متخصص',
      'pharmacySpecialized': 'متخصص',
      'hospitalGeneral': 'عام',
      'pharmacyGeneral': 'عام',
      'hospitalPrivate': 'خاص',
      'pharmacyPrivate': 'خاص',
      'hospitalPublic': 'حكومي',
      'pharmacyPublic': 'حكومي',
      'hospitalClinic': 'عيادة',
      'pharmacyClinic': 'عيادة',
      'hospitalMedicalCenter': 'مركز طبي',
      'pharmacyMedicalCenter': 'مركز طبي',
      'doctorList': 'قائمة الأطباء',
      'doctorName': 'اسم الطبيب',
      'doctorSpecialty': 'التخصص',
      'doctorExperience': 'الخبرة',
      'doctorQualifications': 'المؤهلات',
      'doctorEducation': 'التعليم',
      'doctorLanguages': 'اللغات',
      'doctorAvailability': 'التوفر',
      'doctorSchedule': 'الجدول',
      'doctorFees': 'الرسوم',
      'doctorRating': 'التقييم',
      'doctorReviews': 'المراجعات',
      'doctorContact': 'اتصل بنا',
      'doctorLocation': 'الموقع',
      'doctorWebsite': 'الموقع الإلكتروني',
      'doctorSocialMedia': 'وسائل التواصل الاجتماعي',
      'doctorBio': 'السيرة الذاتية',
      'doctorServices': 'الخدمات',
      'doctorTreatments': 'العلاجات',
      'doctorSpecializations': 'التخصصات',
      'doctorCertifications': 'الشهادات',
      'doctorMemberships': 'العضويات',
      'doctorPublications': 'المنشورات',
      'doctorAwards': 'الجوائز',
      'doctorResearch': 'البحث',
      'doctorTeaching': 'التدريس',
      'doctorConsultation': 'استشارة',
      'doctorFollowUp': 'متابعة',
      'doctorEmergency': 'طوارئ',
      'doctorRegular': 'عادي',
      'doctorOnline': 'متصل',
      'doctorOffline': 'غير متصل',
      'doctorAvailable': 'متاح',
      'doctorUnavailable': 'غير متاح',
      'doctorBusy': 'مشغول',
      'doctorOnLeave': 'في إجازة',
      'doctorOnCall': 'في الخدمة',
      'doctorOnDuty': 'في الخدمة',
      'doctorOnVacation': 'في إجازة',
      'doctorOnSickLeave': 'في إجازة مرضية',
      'doctorOnTraining': 'في تدريب',
      'doctorOnConference': 'في مؤتمر',
      'doctorOnResearch': 'في بحث',
      'doctorOnTeaching': 'في تدريس',
      'doctorOnConsultation': 'في استشارة',
      'doctorOnFollowUp': 'في متابعة',
      'doctorOnEmergency': 'في طوارئ',
      'doctorOnRegular': 'في عيادة عادية',
      'doctorOnOnline': 'متصل',
      'doctorOnOffline': 'غير متصل',
      'drugInteractionTitle': 'تفاعل الأدوية',
      'drugInteractionSubtitle': 'تحقق من التفاعلات بين الأدوية',
      'drugDiseaseTitle': 'تفاعل الدواء مع المرض',
      'drugDiseaseSubtitle': 'تحقق من التفاعلات بين الأدوية والأمراض',
      'drugSubstitutionsTitle': 'بدائل الأدوية',
      'drugSubstitutionsSubtitle': 'البحث عن بدائل للأدوية',
      'drugInteractionResult': 'نتيجة التفاعل',
      'drugDiseaseResult': 'نتيجة تفاعل الدواء مع المرض',
      'drugSubstitutionsResult': 'نتيجة البدائل',
      'drugInteractionLoading': 'جاري فحص تفاعل الأدوية...',
      'drugDiseaseLoading': 'جاري فحص تفاعل الدواء مع المرض...',
      'drugSubstitutionsLoading': 'جاري البحث عن البدائل...',
      'drugInteractionError': 'خطأ في فحص تفاعل الأدوية',
      'drugDiseaseError': 'خطأ في فحص تفاعل الدواء مع المرض',
      'drugSubstitutionsError': 'خطأ في البحث عن البدائل',
      'drugInteractionSuccess': 'تم فحص تفاعل الأدوية بنجاح',
      'drugDiseaseSuccess': 'تم فحص تفاعل الدواء مع المرض بنجاح',
      'drugSubstitutionsSuccess': 'تم العثور على البدائل بنجاح',
      'drugDiseaseInfo': 'اختر مرضاً ودواءً للتحقق من تفاعلهما',
      'drugSubstitutionsInfo': 'اختر دواءً للعثور على بدائل مناسبة',
      'drugInteractionWarning': 'تحذير: هذه ليست نصيحة طبية. يرجى استشارة طبيبك.',
      'drugDiseaseWarning': 'تحذير: هذه ليست نصيحة طبية. يرجى استشارة طبيبك.',
      'drugSubstitutionsWarning': 'تحذير: هذه ليست نصيحة طبية. يرجى استشارة طبيبك.',
      'drugInteractionDisclaimer': 'المعلومات المقدمة هي لأغراض تعليمية فقط.',
      'drugDiseaseDisclaimer': 'المعلومات المقدمة هي لأغراض تعليمية فقط.',
      'drugSubstitutionsDisclaimer': 'المعلومات المقدمة هي لأغراض تعليمية فقط.',
      'drugInteractionNote': 'ملاحظة: استشر مقدم الرعاية الصحية قبل تناول أي أدوية.',
      'drugDiseaseNote': 'ملاحظة: استشر مقدم الرعاية الصحية قبل تناول أي أدوية.',
      'drugSubstitutionsNote': 'ملاحظة: استشر مقدم الرعاية الصحية قبل تناول أي أدوية.',
      'diseaseDrugInteraction': 'تفاعل المرض مع الدواء',
      'diseaseDrugInteractionInfo': 'اختر مرضاً ودواءً للتحقق من تفاعلهما',
      'diseaseDrugInteractionResult': 'نتيجة تفاعل المرض مع الدواء',
      'diseaseDrugInteractionLoading': 'جاري فحص تفاعل المرض مع الدواء...',
      'diseaseDrugInteractionError': 'خطأ في فحص تفاعل المرض مع الدواء',
      'diseaseDrugInteractionSuccess': 'تم فحص تفاعل المرض مع الدواء بنجاح',
      'diseaseDrugInteractionWarning': 'تحذير: هذه ليست نصيحة طبية. يرجى استشارة طبيبك.',
      'diseaseDrugInteractionDisclaimer': 'المعلومات المقدمة هي لأغراض تعليمية فقط.',
      'diseaseDrugInteractionNote': 'ملاحظة: استشر مقدم الرعاية الصحية قبل تناول أي أدوية.',
      'home': 'الرئيسية',
      'homeScreen': 'الشاشة الرئيسية',
      'doctorsScreen': 'شاشة الأطباء',
      'cleanerScreen': 'شاشة المنظف',
      'recordScreen': 'شاشة السجل',
      'cleaner': 'المنظف',
      'record': 'السجل',
      'addSchedule': 'إضافة جدول',
      'noScheduleAvailable': 'لا يوجد جدول متاح',
      'noPharmaciesAvailable': 'لا توجد صيدليات متاحة',
      'noPharmaciesFound': 'لم يتم العثور على صيدليات',
      'branch': 'الفرع',
      'viewWebsite': 'عرض الموقع',
      'noHospitalsAvailable': 'لا توجد مستشفيات متاحة',
      'mySchedule': 'جدولي',
      'addMoreSlots': 'إضافة مواعيد أكثر',
      'search': 'بحث',
      'searchDoctors': 'البحث عن الأطباء',
      'searchHospitals': 'البحث عن المستشفيات',
      'searchPharmacies': 'البحث عن الصيدليات',
      'searchSpecialties': 'البحث عن التخصصات',
      'noResultsFound': 'لم يتم العثور على نتائج',
      'startSearching': 'ابدأ البحث...',
      'noSpecialtiesFound': 'لم يتم العثور على تخصصات',
      'noDoctorsFound': 'لم يتم العثور على أطباء',
      'noHospitalsFound': 'لم يتم العثور على مستشفيات',
      'findYourDoctor': 'ابحث عن طبيبك',
      'browseAndBookAppointments': 'تصفح واحجز المواعيد مع أفضل الأطباء',
      'branches': 'الفروع',
      'visitWebsite': 'زيارة الموقع',
      'noAppointmentsFound': 'لم يتم العثور على مواعيد',
      'viewProfile': 'عرض الملف الشخصي',
      'app': 'التطبيق',
      'welcomeDescription': 'رفيقك الطبي الشامل لرعاية صحية أفضل',
      'signUp': 'إنشاء حساب',
      'makeReservation': 'حجز موعد',
      'selectedDate': 'التاريخ المختار',
      'noDateSelected': 'لم يتم اختيار تاريخ',
      'availableTime': 'الوقت المتاح',
      'noAvailableSlots': 'لا توجد مواعيد متاحة',
      'patientDetails': 'تفاصيل المريض',
      'yourself': 'نفسك',
      'anotherPerson': 'شخص آخر',
      'age': 'العمر',
      'gender': 'الجنس',
      'confirmReservation': 'تأكيد الحجز',
      'missingInfo': 'معلومات مطلوبة مفقودة',
      'selectTimeSlot': 'الرجاء اختيار موعد',
      'userNotFound': 'لم يتم العثور على المستخدم',
      'reservationSuccess': 'تم إنشاء الحجز بنجاح',
      // Chatbot
      'chatbot': 'المساعد الطبي',
      'chatbotGreeting': 'مرحباً! كيف يمكنني مساعدتك اليوم؟',
      'chatbotPlaceholder': 'اكتب رسالتك هنا...',
      'chatbotSend': 'إرسال',
      'chatbotTyping': 'جاري الكتابة...',
      'chatbotError': 'عذراً، حدث خطأ. يرجى المحاولة مرة أخرى.',
      'chatbotNoResponse': 'لم يتم استلام رد. يرجى المحاولة مرة أخرى.',
      
      // Prescription
      'prescriptionDetails': 'تفاصيل الوصفة',
      'prescriptionDate': 'تاريخ الوصفة',
      'prescriptionDoctor': 'وصف بواسطة',
      'prescriptionMedicines': 'الأدوية',
      'prescriptionDosage': 'الجرعة',
      'prescriptionDuration': 'المدة',
      'prescriptionNotes': 'ملاحظات',
      'noPrescriptions': 'لم يتم العثور على وصفات طبية',
      'addPrescription': 'إضافة وصفة طبية',
      'editPrescription': 'تعديل الوصفة الطبية',
      'deletePrescription': 'حذف الوصفة الطبية',
      'readPrescription': 'قراءة الوصفة',
      'selectImageFirst': 'يرجى اختيار صورة أولاً',
      'uploadImage': 'رفع صورة',
      'takePhoto': 'إلتقاط صورة',
      'read': 'قراءة',
      'processingImage': 'جاري معالجة الصورة...',
      'detectedText': 'النص المكتشف',
      
      // Appointment List
      'appointmentList': 'المواعيد',
      'date': 'التاريخ',
      'status': 'الحالة',
      'noAppointments': 'لم يتم العثور على مواعيد',
      'noUpcomingAppointments': 'لا توجد مواعيد قادمة',
      'noPastAppointments': 'لا توجد مواعيد سابقة',
      'noCancelledAppointments': 'لا توجد مواعيد ملغاة',
      'noCompletedAppointments': 'لا توجد مواعيد مكتملة',
      'noAppointmentsThisWeek': 'لا توجد مواعيد هذا الأسبوع',
      'noAppointmentsThisMonth': 'لا توجد مواعيد هذا الشهر',
      'appointmentConfirmed': 'مؤكد',
      'appointmentPending': 'قيد الانتظار',
      'appointmentCompleted': 'مكتمل',
      'cancelled': 'ملغي',
      'upcoming': 'قادم',
      'completed': 'مكتمل',
      'dateStatus': 'حالة التاريخ',
      'today': 'اليوم',
      'tomorrow': 'غداً',
      'thisWeek': 'هذا الأسبوع',
      'nextWeek': 'الأسبوع القادم',
      'thisMonth': 'هذا الشهر',
      'nextMonth': 'الشهر القادم',
      'past': 'الماضي',
      'future': 'المستقبل',
      'dateRange': 'نطاق التاريخ',
      'startDate': 'تاريخ البداية',
      'endDate': 'تاريخ النهاية',
      'selectDateRange': 'اختر نطاق التاريخ',
      'invalidDateRange': 'نطاق تاريخ غير صالح',
      'dateFormat': 'تنسيق التاريخ',
      'timeFormat': 'تنسيق الوقت',
      
      // Edit Profile
      'personalInformation': 'المعلومات الشخصية',
      'medicalInformation': 'المعلومات الطبية',
      'saveChanges': 'حفظ التغييرات',
      'cancelChanges': 'إلغاء التغييرات',
      'profileUpdated': 'تم تحديث الملف الشخصي بنجاح',
      'profileUpdateError': 'فشل تحديث الملف الشخصي',
      'uploadPhoto': 'رفع صورة',
      'removePhoto': 'حذف الصورة',
      'changePassword': 'تغيير كلمة المرور',
      'currentPassword': 'كلمة المرور الحالية',
      'newPassword': 'كلمة المرور الجديدة',
      'confirmNewPassword': 'تأكيد كلمة المرور الجديدة',
      'passwordMismatch': 'كلمات المرور غير متطابقة',
      'passwordUpdated': 'تم تحديث كلمة المرور بنجاح',
      'passwordUpdateError': 'فشل تحديث كلمة المرور',
      'medicationHistory': 'التاريخ الطبي',
      'noProfileData': 'لا توجد بيانات الملف الشخصي',
      'selectDateOfBirth': 'اختر تاريخ الميلاد',
      'dob': 'تاريخ الميلاد',
    },
  };

  String get(String key) {
    return _localizedValues[locale.languageCode]?[key] ?? key;
  }

  String get appName => get('appName');
  String get save => get('save');
  String get cancel => get('cancel');
  String get edit => get('edit');
  String get delete => get('delete');
  String get loading => get('loading');
  String get error => get('error');
  String get success => get('success');
  String get back => get('back');
  String get next => get('next');
  String get done => get('done');
  String get and => get('and');

  String get login => get('login');
  String get signup => get('signup');
  String get email => get('email');
  String get password => get('password');
  String get confirmPassword => get('confirmPassword');
  String get username => get('username');
  String get forgotPassword => get('forgotPassword');
  String get dontHaveAccount => get('dontHaveAccount');
  String get haveAccount => get('haveAccount');
  String get welcomeBack => get('welcomeBack');
  String get loginToContinue => get('loginToContinue');
  String get enterUsername => get('enterUsername');
  String get pleaseEnterUsername => get('pleaseEnterUsername');
  String get pleaseEnterEmail => get('pleaseEnterEmail');
  String get invalidEmail => get('invalidEmail');
  String get pleaseEnterPassword => get('pleaseEnterPassword');
  String get passwordTooShort => get('passwordTooShort');
  String get pleaseConfirmPassword => get('pleaseConfirmPassword');
  String get passwordsDoNotMatch => get('passwordsDoNotMatch');
  String get termsAndPrivacy => get('termsAndPrivacy');
  String get termsOfUse => get('termsOfUse');
  String get privacyPolicy => get('privacyPolicy');
  String get welcome => get('welcome');
  String get welcomeDr => get('welcomeDr');

  String get doctorHome => get('doctorHome');
  String get todayAppointments => get('todayAppointments');
  String get availableSlots => get('availableSlots');
  String get patientReviews => get('patientReviews');
  String get addAppointment => get('addAppointment');
  String get viewPatients => get('viewPatients');
  String get chatBot => get('chatBot');
  String get quickActions => get('quickActions');
  String get features => get('features');

  String get appointments => get('appointments');
  String get upcomingAppointments => get('upcomingAppointments');
  String get pastAppointments => get('pastAppointments');
  String get bookAppointment => get('bookAppointment');
  String get cancelAppointment => get('cancelAppointment');
  String get rescheduleAppointment => get('rescheduleAppointment');
  String get appointmentDetails => get('appointmentDetails');
  String get appointmentDate => get('appointmentDate');
  String get appointmentTime => get('appointmentTime');
  String get appointmentStatus => get('appointmentStatus');
  String get appointmentDoctor => get('appointmentDoctor');
  String get appointmentPatient => get('appointmentPatient');
  String get appointmentNotes => get('appointmentNotes');

  String get settings => get('settings');
  String get language => get('language');
  String get notifications => get('notifications');
  String get theme => get('theme');
  String get about => get('about');
  String get logout => get('logout');
  String get english => get('english');
  String get arabic => get('arabic');
  String get darkMode => get('darkMode');
  String get lightMode => get('lightMode');
  String get systemDefault => get('systemDefault');

  String get profile => get('profile');
  String get personalInfo => get('personalInfo');
  String get medicalInfo => get('medicalInfo');
  String get name => get('name');
  String get phone => get('phone');
  String get specialty => get('specialty');
  String get experience => get('experience');
  String get qualifications => get('qualifications');
  String get selectSpecialty => get('selectSpecialty');
  String get pleaseSelectSpecialty => get('pleaseSelectSpecialty');

  String get chat => get('chat');
  String get typeMessage => get('typeMessage');
  String get send => get('send');
  String get attach => get('attach');
  String get noMessages => get('noMessages');
  String get online => get('online');
  String get offline => get('offline');
  String get typing => get('typing');

  String get patient => get('patient');
  String get doctor => get('doctor');
  String get role => get('role');

  String get categories => get('categories');
  String get diagnosis => get('diagnosis');
  String get doctors => get('doctors');
  String get drugs => get('drugs');
  String get schedule => get('schedule');
  String get prescriptions => get('prescriptions');
  String get upcomingSchedule => get('upcomingSchedule');
  String get noAppointmentsToday => get('noAppointmentsToday');
  String get noData => get('noData');
  String get pharmacies => get('pharmacies');
  String get hospitals => get('hospitals');
  String get specialties => get('specialties');

  String get favorites => get('favorites');
  String get paymentMethod => get('paymentMethod');
  String get help => get('help');

  String get doctorProfile => get('doctorProfile');
  String get professionalInfo => get('professionalInfo');
  String get notProvided => get('notProvided');
  String get education => get('education');

  String get editProfile => get('editProfile');
  String get fullName => get('fullName');
  String get address => get('address');
  String get experienceYears => get('experienceYears');
  String get workingHours => get('workingHours');
  String get workingDays => get('workingDays');
  String get workingDaysHint => get('workingDaysHint');
  String get workingHoursHint => get('workingHoursHint');

  String get diseasePrediction => get('diseasePrediction');
  String get selectDisease => get('selectDisease');
  String get chooseDisease => get('chooseDisease');
  String get uploadMedicalImage => get('uploadMedicalImage');
  String get uploadClearImage => get('uploadClearImage');
  String get noImageSelected => get('noImageSelected');
  String get gallery => get('gallery');
  String get camera => get('camera');
  String get analyzeImage => get('analyzeImage');
  String get analyzingImage => get('analyzingImage');
  String get analysisResults => get('analysisResults');
  String get prediction => get('prediction');
  String get confidence => get('confidence');
  String get predictionHistory => get('predictionHistory');
  String get noPredictions => get('noPredictions');
  String get predictionDeleted => get('predictionDeleted');
  String get failedToLoadImage => get('failedToLoadImage');
  String get pleaseSelectImage => get('pleaseSelectImage');
  String get failedToLoadHistory => get('failedToLoadHistory');
  String get failedToDelete => get('failedToDelete');

  String get covid19 => get('covid19');
  String get covid19Description => get('covid19Description');
  String get brainTumor => get('brainTumor');
  String get brainTumorDescription => get('brainTumorDescription');
  String get kidneyStone => get('kidneyStone');
  String get kidneyStoneDescription => get('kidneyStoneDescription');
  String get skinCancer => get('skinCancer');
  String get skinCancerDescription => get('skinCancerDescription');
  String get tuberculosis => get('tuberculosis');
  String get tuberculosisDescription => get('tuberculosisDescription');
  String get boneFracture => get('boneFracture');
  String get boneFractureDescription => get('boneFractureDescription');
  String get alzheimer => get('alzheimer');
  String get alzheimerDescription => get('alzheimerDescription');
  String get eyeDiseases => get('eyeDiseases');
  String get eyeDiseasesDescription => get('eyeDiseasesDescription');

  String get male => get('male');
  String get female => get('female');
  String get other => get('other');
  String get describeProblem => get('describeProblem');
  String get enterProblem => get('enterProblem');
  String get searchHint => get('searchHint');
  String get drugInteractionInfo => get('drugInteractionInfo');
  String get unknown => get('unknown');
  String get hospitalType => get('hospitalType');
  String get pharmacyType => get('pharmacyType');
  String get location => get('location');
  String get contact => get('contact');
  String get website => get('website');
  String get rating => get('rating');
  String get reviews => get('reviews');
  String get openNow => get('openNow');
  String get closed => get('closed');
  String get services => get('services');
  String get amenities => get('amenities');
  String get insurance => get('insurance');
  String get paymentMethods => get('paymentMethods');
  String get emergency => get('emergency');
  String get nonEmergency => get('nonEmergency');
  String get specialized => get('specialized');
  String get general => get('general');
  String get private => get('private');
  String get public => get('public');
  String get clinic => get('clinic');
  String get medicalCenter => get('medicalCenter');
  String get hospital => get('hospital');
  String get pharmacy => get('pharmacy');
  String get drugstore => get('drugstore');
  String get medicalStore => get('medicalStore');
  String get viewOnMap => get('viewOnMap');
  String get getDirections => get('getDirections');
  String get callNow => get('callNow');
  String get share => get('share');
  String get report => get('report');
  String get confirm => get('confirm');
  String get submit => get('submit');
  String get reset => get('reset');
  String get filter => get('filter');
  String get sort => get('sort');
  String get viewAll => get('viewAll');
  String get showMore => get('showMore');
  String get showLess => get('showLess');
  String get noResults => get('noResults');
  String get tryAgain => get('tryAgain');
  String get errorOccurred => get('errorOccurred');
  String get checkConnection => get('checkConnection');
  String get retry => get('retry');
  String get close => get('close');
  String get ok => get('ok');
  String get yes => get('yes');
  String get no => get('no');
  String get maybe => get('maybe');
  String get later => get('later');
  String get skip => get('skip');
  String get finish => get('finish');
  String get start => get('start');
  String get stop => get('stop');
  String get pause => get('pause');
  String get resume => get('resume');
  String get refresh => get('refresh');
  String get update => get('update');
  String get install => get('install');
  String get uninstall => get('uninstall');
  String get download => get('download');
  String get upload => get('upload');
  String get sync => get('sync');
  String get backup => get('backup');
  String get restore => get('restore');
  String get preferences => get('preferences');
  String get account => get('account');
  String get security => get('security');
  String get privacy => get('privacy');
  String get support => get('support');
  String get feedback => get('feedback');
  String get version => get('version');
  String get terms => get('terms');
  String get conditions => get('conditions');
  String get licenses => get('licenses');
  String get credits => get('credits');
  String get attributions => get('attributions');
  String get copyright => get('copyright');
  String get allRightsReserved => get('allRightsReserved');
  String get drugInteraction => get('drugInteraction');
  String get drugDisease => get('drugDisease');
  String get substitutions => get('substitutions');
  String get findDrugSubstitutions => get('findDrugSubstitutions');
  String get selectDrugForAlternatives => get('selectDrugForAlternatives');
  String get alternativeDrugs => get('alternativeDrugs');
  String get findingAlternatives => get('findingAlternatives');
  String get checkDrugInteractions => get('checkDrugInteractions');
  String get selectTwoDrugs => get('selectTwoDrugs');
  String get firstDrug => get('firstDrug');
  String get secondDrug => get('secondDrug');
  String get checkInteraction => get('checkInteraction');
  String get checkingInteraction => get('checkingInteraction');
  String get interactionResult => get('interactionResult');
  String get pleaseSelectDrug => get('pleaseSelectDrug');
  String get pleaseSelectBothDrugs => get('pleaseSelectBothDrugs');
  String get pleaseSelectDiseaseAndDrug => get('pleaseSelectDiseaseAndDrug');
  String get appointmentBooked => get('appointmentBooked');
  String get appointmentCancelled => get('appointmentCancelled');
  String get appointmentRescheduled => get('appointmentRescheduled');
  String get selectDate => get('selectDate');
  String get selectTime => get('selectTime');
  String get appointmentDuration => get('appointmentDuration');
  String get appointmentType => get('appointmentType');
  String get appointmentReason => get('appointmentReason');
  String get appointmentLocation => get('appointmentLocation');
  String get appointmentConfirmation => get('appointmentConfirmation');
  String get appointmentReminder => get('appointmentReminder');
  String get appointmentHistory => get('appointmentHistory');
  String get appointmentSummary => get('appointmentSummary');
  String get appointmentFeedback => get('appointmentFeedback');
  String get appointmentRating => get('appointmentRating');
  String get appointmentReview => get('appointmentReview');
  String get appointmentFollowUp => get('appointmentFollowUp');
  String get appointmentEmergency => get('appointmentEmergency');
  String get appointmentRegular => get('appointmentRegular');
  String get appointmentConsultation => get('appointmentConsultation');
  String get appointmentCheckup => get('appointmentCheckup');
  String get hospitalDetails => get('hospitalDetails');
  String get pharmacyDetails => get('pharmacyDetails');
  String get hospitalName => get('hospitalName');
  String get pharmacyName => get('pharmacyName');
  String get hospitalLocation => get('hospitalLocation');
  String get pharmacyLocation => get('pharmacyLocation');
  String get hospitalContact => get('hospitalContact');
  String get pharmacyContact => get('pharmacyContact');
  String get hospitalWebsite => get('hospitalWebsite');
  String get pharmacyWebsite => get('pharmacyWebsite');
  String get hospitalRating => get('hospitalRating');
  String get pharmacyRating => get('pharmacyRating');
  String get hospitalReviews => get('hospitalReviews');
  String get pharmacyReviews => get('pharmacyReviews');
  String get hospitalServices => get('hospitalServices');
  String get pharmacyServices => get('pharmacyServices');
  String get hospitalAmenities => get('hospitalAmenities');
  String get pharmacyAmenities => get('pharmacyAmenities');
  String get hospitalInsurance => get('hospitalInsurance');
  String get pharmacyInsurance => get('pharmacyInsurance');
  String get hospitalPaymentMethods => get('hospitalPaymentMethods');
  String get pharmacyPaymentMethods => get('pharmacyPaymentMethods');
  String get hospitalEmergency => get('hospitalEmergency');
  String get pharmacyEmergency => get('pharmacyEmergency');
  String get hospitalNonEmergency => get('hospitalNonEmergency');
  String get pharmacyNonEmergency => get('pharmacyNonEmergency');
  String get hospitalSpecialized => get('hospitalSpecialized');
  String get pharmacySpecialized => get('pharmacySpecialized');
  String get hospitalGeneral => get('hospitalGeneral');
  String get pharmacyGeneral => get('pharmacyGeneral');
  String get hospitalPrivate => get('hospitalPrivate');
  String get pharmacyPrivate => get('pharmacyPrivate');
  String get hospitalPublic => get('hospitalPublic');
  String get pharmacyPublic => get('pharmacyPublic');
  String get hospitalClinic => get('hospitalClinic');
  String get pharmacyClinic => get('pharmacyClinic');
  String get hospitalMedicalCenter => get('hospitalMedicalCenter');
  String get pharmacyMedicalCenter => get('pharmacyMedicalCenter');
  String get doctorList => get('doctorList');
  String get doctorName => get('doctorName');
  String get doctorSpecialty => get('doctorSpecialty');
  String get doctorExperience => get('doctorExperience');
  String get doctorQualifications => get('doctorQualifications');
  String get doctorEducation => get('doctorEducation');
  String get doctorLanguages => get('doctorLanguages');
  String get doctorAvailability => get('doctorAvailability');
  String get doctorSchedule => get('doctorSchedule');
  String get doctorFees => get('doctorFees');
  String get doctorRating => get('doctorRating');
  String get doctorReviews => get('doctorReviews');
  String get doctorContact => get('doctorContact');
  String get doctorLocation => get('doctorLocation');
  String get doctorWebsite => get('doctorWebsite');
  String get doctorSocialMedia => get('doctorSocialMedia');
  String get doctorBio => get('doctorBio');
  String get doctorServices => get('doctorServices');
  String get doctorTreatments => get('doctorTreatments');
  String get doctorSpecializations => get('doctorSpecializations');
  String get doctorCertifications => get('doctorCertifications');
  String get doctorMemberships => get('doctorMemberships');
  String get doctorPublications => get('doctorPublications');
  String get doctorAwards => get('doctorAwards');
  String get doctorResearch => get('doctorResearch');
  String get doctorTeaching => get('doctorTeaching');
  String get doctorConsultation => get('doctorConsultation');
  String get doctorFollowUp => get('doctorFollowUp');
  String get doctorEmergency => get('doctorEmergency');
  String get doctorRegular => get('doctorRegular');
  String get doctorOnline => get('doctorOnline');
  String get doctorOffline => get('doctorOffline');
  String get doctorAvailable => get('doctorAvailable');
  String get doctorUnavailable => get('doctorUnavailable');
  String get doctorBusy => get('doctorBusy');
  String get doctorOnLeave => get('doctorOnLeave');
  String get doctorOnCall => get('doctorOnCall');
  String get doctorOnDuty => get('doctorOnDuty');
  String get doctorOnVacation => get('doctorOnVacation');
  String get doctorOnSickLeave => get('doctorOnSickLeave');
  String get doctorOnTraining => get('doctorOnTraining');
  String get doctorOnConference => get('doctorOnConference');
  String get doctorOnResearch => get('doctorOnResearch');
  String get doctorOnTeaching => get('doctorOnTeaching');
  String get doctorOnConsultation => get('doctorOnConsultation');
  String get doctorOnFollowUp => get('doctorOnFollowUp');
  String get doctorOnEmergency => get('doctorOnEmergency');
  String get doctorOnRegular => get('doctorOnRegular');
  String get doctorOnOnline => get('doctorOnOnline');
  String get doctorOnOffline => get('doctorOnOffline');
  String get drugInteractionTitle => get('drugInteractionTitle');
  String get drugInteractionSubtitle => get('drugInteractionSubtitle');
  String get drugDiseaseTitle => get('drugDiseaseTitle');
  String get drugDiseaseSubtitle => get('drugDiseaseSubtitle');
  String get drugSubstitutionsTitle => get('drugSubstitutionsTitle');
  String get drugSubstitutionsSubtitle => get('drugSubstitutionsSubtitle');
  String get drugInteractionResult => get('drugInteractionResult');
  String get drugDiseaseResult => get('drugDiseaseResult');
  String get drugSubstitutionsResult => get('drugSubstitutionsResult');
  String get drugInteractionLoading => get('drugInteractionLoading');
  String get drugDiseaseLoading => get('drugDiseaseLoading');
  String get drugSubstitutionsLoading => get('drugSubstitutionsLoading');
  String get drugInteractionError => get('drugInteractionError');
  String get drugDiseaseError => get('drugDiseaseError');
  String get drugSubstitutionsError => get('drugSubstitutionsError');
  String get drugInteractionSuccess => get('drugInteractionSuccess');
  String get drugDiseaseSuccess => get('drugDiseaseSuccess');
  String get drugSubstitutionsSuccess => get('drugSubstitutionsSuccess');
  String get drugDiseaseInfo => get('drugDiseaseInfo');
  String get drugSubstitutionsInfo => get('drugSubstitutionsInfo');
  String get drugInteractionWarning => get('drugInteractionWarning');
  String get drugDiseaseWarning => get('drugDiseaseWarning');
  String get drugSubstitutionsWarning => get('drugSubstitutionsWarning');
  String get drugInteractionDisclaimer => get('drugInteractionDisclaimer');
  String get drugDiseaseDisclaimer => get('drugDiseaseDisclaimer');
  String get drugSubstitutionsDisclaimer => get('drugSubstitutionsDisclaimer');
  String get drugInteractionNote => get('drugInteractionNote');
  String get drugDiseaseNote => get('drugDiseaseNote');
  String get drugSubstitutionsNote => get('drugSubstitutionsNote');
  String get disease => get('disease');
  String get checkDiseaseDrugInteraction => get('checkDiseaseDrugInteraction');
  String get diseaseDrugInteraction => get('diseaseDrugInteraction');
  String get diseaseDrugInteractionInfo => get('diseaseDrugInteractionInfo');
  String get diseaseDrugInteractionResult => get('diseaseDrugInteractionResult');
  String get diseaseDrugInteractionLoading => get('diseaseDrugInteractionLoading');
  String get diseaseDrugInteractionError => get('diseaseDrugInteractionError');
  String get diseaseDrugInteractionSuccess => get('diseaseDrugInteractionSuccess');
  String get diseaseDrugInteractionWarning => get('diseaseDrugInteractionWarning');
  String get diseaseDrugInteractionDisclaimer => get('diseaseDrugInteractionDisclaimer');
  String get diseaseDrugInteractionNote => get('diseaseDrugInteractionNote');
  String get home => get('home');
  String get homeScreen => get('homeScreen');
  String get doctorsScreen => get('doctorsScreen');
  String get cleanerScreen => get('cleanerScreen');
  String get recordScreen => get('recordScreen');
  String get cleaner => get('cleaner');
  String get record => get('record');
  String get addSchedule => get('addSchedule');
  String get noScheduleAvailable => get('noScheduleAvailable');
  String get noPharmaciesAvailable => get('noPharmaciesAvailable');
  String get noPharmaciesFound => get('noPharmaciesFound');
  String get branch => get('branch');
  String get viewWebsite => get('viewWebsite');
  String get noHospitalsAvailable => get('noHospitalsAvailable');
  String get mySchedule => get('mySchedule');
  String get addMoreSlots => get('addMoreSlots');
  String get search => get('search');
  String get searchDoctors => get('searchDoctors');
  String get searchHospitals => get('searchHospitals');
  String get searchPharmacies => get('searchPharmacies');
  String get searchSpecialties => get('searchSpecialties');
  String get noResultsFound => get('noResultsFound');
  String get startSearching => get('startSearching');
  String get branches => get('branches');
  String get visitWebsite => get('visitWebsite');
  String get noAppointmentsFound => get('noAppointmentsFound');
  String get viewProfile => get('viewProfile');
  String get app => get('app');
  String get welcomeDescription => get('welcomeDescription');
  String get signUp => get('signUp');
  String get noHospitalsFound => _localizedValues[locale.languageCode]!['noHospitalsFound']!;
  String get noSpecialtiesFound => _localizedValues[locale.languageCode]!['noSpecialtiesFound']!;
  String get noDoctorsFound => _localizedValues[locale.languageCode]!['noDoctorsFound']!;
  String get findYourDoctor => get('findYourDoctor');
  String get browseAndBookAppointments => get('browseAndBookAppointments');
  String get makeReservation => get('makeReservation');
  String get selectedDate => get('selectedDate');
  String get noDateSelected => get('noDateSelected');
  String get availableTime => get('availableTime');
  String get noAvailableSlots => get('noAvailableSlots');
  String get patientDetails => get('patientDetails');
  String get yourself => get('yourself');
  String get anotherPerson => get('anotherPerson');
  String get age => get('age');
  String get gender => get('gender');
  String get confirmReservation => get('confirmReservation');
  String get missingInfo => get('missingInfo');
  String get selectTimeSlot => get('selectTimeSlot');
  String get userNotFound => get('userNotFound');
  String get reservationSuccess => get('reservationSuccess');
  // Chatbot
  String get chatbot => get('chatbot');
  String get chatbotGreeting => get('chatbotGreeting');
  String get chatbotPlaceholder => get('chatbotPlaceholder');
  String get chatbotSend => get('chatbotSend');
  String get chatbotTyping => get('chatbotTyping');
  String get chatbotError => get('chatbotError');
  String get chatbotNoResponse => get('chatbotNoResponse');
  
  // Prescription
  String get prescriptionDetails => get('prescriptionDetails');
  String get prescriptionDate => get('prescriptionDate');
  String get prescriptionDoctor => get('prescriptionDoctor');
  String get prescriptionMedicines => get('prescriptionMedicines');
  String get prescriptionDosage => get('prescriptionDosage');
  String get prescriptionDuration => get('prescriptionDuration');
  String get prescriptionNotes => get('prescriptionNotes');
  String get noPrescriptions => get('noPrescriptions');
  String get addPrescription => get('addPrescription');
  String get editPrescription => get('editPrescription');
  String get deletePrescription => get('deletePrescription');
  String get readPrescription => get('readPrescription');
  String get selectImageFirst => get('selectImageFirst');
  String get uploadImage => get('uploadImage');
  String get takePhoto => get('takePhoto');
  String get read => get('read');
  String get processingImage => get('processingImage');
  String get detectedText => get('detectedText');

  String get cancelled => get('cancelled');
  String get upcoming => get('upcoming');
  String get completed => get('completed');
  
  // Edit Profile
  String get personalInformation => get('personalInformation');
  String get medicalInformation => get('medicalInformation');
  String get saveChanges => get('saveChanges');
  String get cancelChanges => get('cancelChanges');
  String get profileUpdated => get('profileUpdated');
  String get profileUpdateError => get('profileUpdateError');
  String get uploadPhoto => get('uploadPhoto');
  String get removePhoto => get('removePhoto');
  String get changePassword => get('changePassword');
  String get currentPassword => get('currentPassword');
  String get newPassword => get('newPassword');
  String get confirmNewPassword => get('confirmNewPassword');
  String get passwordMismatch => get('passwordMismatch');
  String get passwordUpdated => get('passwordUpdated');
  String get passwordUpdateError => get('passwordUpdateError');
  String get medicationHistory => _localizedValues[locale.languageCode]!['medicationHistory']!;
  String get noProfileData => _localizedValues[locale.languageCode]!['noProfileData']!;
  String get selectDateOfBirth => _localizedValues[locale.languageCode]!['selectDateOfBirth']!;
  String get dob => _localizedValues[locale.languageCode]!['dob']!;
  String get dateStatus => get('dateStatus');
  String get today => get('today');
  String get tomorrow => get('tomorrow');
  String get thisWeek => get('thisWeek');
  String get nextWeek => get('nextWeek');
  String get thisMonth => get('thisMonth');
  String get nextMonth => get('nextMonth');
  String get past => get('past');
  String get future => get('future');
  String get dateRange => get('dateRange');
  String get startDate => get('startDate');
  String get endDate => get('endDate');
  String get selectDateRange => get('selectDateRange');
  String get invalidDateRange => get('invalidDateRange');
  String get dateFormat => get('dateFormat');
  String get timeFormat => get('timeFormat');
  String get noAppointments => get('noAppointments');
  String get noUpcomingAppointments => get('noUpcomingAppointments');
  String get noPastAppointments => get('noPastAppointments');
  String get noCancelledAppointments => get('noCancelledAppointments');
  String get noCompletedAppointments => get('noCompletedAppointments');
  String get date => get('date');
  String get status => get('status');
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'ar'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
} 