import 'package:graduation_medical_app/features/user_appointment/data/data_source/all_doctors_data_source/all_doctors_data_source.dart';
import 'package:graduation_medical_app/core/models/doctor_model/doctor_model.dart';
import 'package:injectable/injectable.dart';
import '../../../core/di/di.dart';
import '../../hospitals_and_pharmacies/models/hospital_model.dart';
import '../../hospitals_and_pharmacies/models/pharmacy_model.dart';
import '../../hospitals_and_pharmacies/load_data/load_hospital_data.dart';
import '../../hospitals_and_pharmacies/load_data/load_pharmacies_data.dart';
import '../../user_appointment/data/models/doctor_model/doctor_model.dart';
import '../../user_appointment/data/repository/all_doctor_repo_impl.dart';
import 'package:shared_preferences/shared_preferences.dart';

@injectable
class SearchService {
  final List<DoctorsModel> _doctors = [];
  final List<Hospital> _hospitals = [];
  final List<String> _specialties = [];
  final DoctorRepository _doctorRepository;

  SearchService(this._doctorRepository);

  bool _isInitialized = false;

  Future<void> initialize() async {
    if (_isInitialized) {
      print('SearchService already initialized');
      return;
    }

    try {
      print('Initializing SearchService...');
      
      // Load hospitals
      _hospitals.clear();
      _hospitals.addAll(await loadHospitalData());
      print('Loaded ${_hospitals.length} hospitals');
      
      // Load doctors and extract specialties
      _doctors.clear();
      final doctorsResponse = await _doctorRepository.getAllDoctors();
      _doctors.addAll(doctorsResponse);
      print('Loaded ${_doctors.length} doctors');
      
      // Extract unique specialties
      _specialties.clear();
      _specialties.addAll(
        _doctors
          .map((doctor) => doctor.specialty ?? '')
          .where((specialty) => specialty.isNotEmpty)
          .toSet()
          .toList()
      );
      print('Extracted ${_specialties.length} unique specialties');
      
      _isInitialized = true;
    } catch (e) {
      print('Error initializing search service: $e');
      rethrow; // Rethrow to handle in the cubit
    }
  }

  List<DoctorsModel> searchDoctors(String query) {
    if (!_isInitialized) {
      print('Warning: SearchService not initialized');
      return [];
    }

    query = query.toLowerCase().trim();
    if (query.isEmpty) return [];

    final results = _doctors.where((doctor) {
      final name = doctor.username?.toLowerCase() ?? '';
      final specialty = doctor.specialty?.toLowerCase() ?? '';
      final email = doctor.email?.toLowerCase() ?? '';
      
      final queryWords = query.split(' ');
      return queryWords.every((word) =>
        name.contains(word) || 
        specialty.contains(word) ||
        email.contains(word));
    }).toList();

    print('Found ${results.length} doctors matching "$query"');
    return results;
  }

  List<Hospital> searchHospitals(String query) {
    if (!_isInitialized) {
      print('Warning: SearchService not initialized');
      return [];
    }

    query = query.toLowerCase().trim();
    if (query.isEmpty) return [];

    final results = _hospitals.where((hospital) {
      final name = hospital.name.toLowerCase();
      final location = hospital.location.toLowerCase();
      final type = hospital.type.toLowerCase();

      final queryWords = query.split(' ');
      return queryWords.every((word) =>
        name.contains(word) ||
        location.contains(word) ||
        type.contains(word));
    }).toList();

    print('Found ${results.length} hospitals matching "$query"');
    return results;
  }

  List<String> searchSpecialties(String query) {
    if (!_isInitialized) {
      print('Warning: SearchService not initialized');
      return [];
    }

    query = query.toLowerCase().trim();
    if (query.isEmpty) return _specialties;

    final results = _specialties.where((specialty) {
      return specialty.toLowerCase().contains(query);
    }).toList();

    print('Found ${results.length} specialties matching "$query"');
    return results;
  }

  List<String> getAllSpecialties() {
    if (!_isInitialized) {
      print('Warning: SearchService not initialized');
      return [];
    }
    return List<String>.from(_specialties);
  }

  List<DoctorsModel> getDoctorsBySpecialty(String specialty) {
    if (!_isInitialized) {
      print('Warning: SearchService not initialized');
      return [];
    }

    final results = _doctors.where((doctor) => 
      (doctor.specialty ?? '').toLowerCase() == specialty.toLowerCase()
    ).toList();

    print('Found ${results.length} doctors with specialty "$specialty"');
    return results;
  }
} 