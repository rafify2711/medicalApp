import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_medical_app/core/models/doctor_model/doctor_model.dart';
import 'package:injectable/injectable.dart';
import '../../../hospitals_and_pharmacies/models/hospital_model.dart';
import '../../../user_appointment/data/models/doctor_model/doctor_model.dart';
import '../../data/search_service.dart';

// Search States
abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchError extends SearchState {
  final String message;
  SearchError(this.message);
}

class SearchResults extends SearchState {
  final List<DoctorsModel> doctors;
  final List<Hospital> hospitals;
  final List<String> specialties;
  final String selectedSpecialty;

  SearchResults({
    required this.doctors,
    required this.hospitals,
    required this.specialties,
    this.selectedSpecialty = '',
  });

  SearchResults copyWith({
    List<DoctorsModel>? doctors,
    List<Hospital>? hospitals,
    List<String>? specialties,
    String? selectedSpecialty,
  }) {
    return SearchResults(
      doctors: doctors ?? this.doctors,
      hospitals: hospitals ?? this.hospitals,
      specialties: specialties ?? this.specialties,
      selectedSpecialty: selectedSpecialty ?? this.selectedSpecialty,
    );
  }
}

@injectable
class SearchCubit extends Cubit<SearchState> {
  final SearchService _searchService;
  
  SearchCubit(this._searchService) : super(SearchInitial());

  Future<void> initialize() async {
    emit(SearchLoading());
    try {
      await _searchService.initialize();
      emit(SearchResults(
        doctors: [], 
        hospitals: [], 
        specialties: _searchService.getAllSpecialties(),
        selectedSpecialty: '',
      ));
    } catch (e) {
      print('Error in SearchCubit.initialize: $e');
      emit(SearchError('Failed to initialize search: $e'));
    }
  }

  Future<void> search(String query) async {
    if (state is! SearchResults) {
      print('Search called before initialization');
      return;
    }
    
    final currentState = state as SearchResults;
    print('Searching with query: "$query"');

    if (query.isEmpty) {
      emit(SearchResults(
        doctors: [], 
        hospitals: [], 
        specialties: _searchService.getAllSpecialties(),
        selectedSpecialty: currentState.selectedSpecialty,
      ));
      return;
    }

    emit(SearchLoading());

    try {
      final doctors = _searchService.searchDoctors(query);
      final hospitals = _searchService.searchHospitals(query);
      final specialties = _searchService.searchSpecialties(query);

      print('Search results: ${doctors.length} doctors, ${hospitals.length} hospitals, ${specialties.length} specialties');

      emit(SearchResults(
        doctors: doctors,
        hospitals: hospitals,
        specialties: specialties,
        selectedSpecialty: currentState.selectedSpecialty,
      ));
    } catch (e) {
      print('Error in SearchCubit.search: $e');
      emit(SearchError('Search failed: $e'));
    }
  }

  void selectSpecialty(String specialty) {
    if (state is! SearchResults) {
      print('selectSpecialty called before initialization');
      return;
    }
    
    final currentState = state as SearchResults;
    print('Selecting specialty: "$specialty"');

    final List<DoctorsModel> doctors = specialty.isEmpty
        ? [] 
        : _searchService.getDoctorsBySpecialty(specialty);

    print('Found ${doctors.length} doctors for specialty "$specialty"');

    emit(currentState.copyWith(
      doctors: doctors,
      selectedSpecialty: specialty,
    ));
  }

  void clearSpecialtyFilter() {
    if (state is! SearchResults) {
      print('clearSpecialtyFilter called before initialization');
      return;
    }
    
    final currentState = state as SearchResults;
    print('Clearing specialty filter');

    emit(currentState.copyWith(
      doctors: [],
      selectedSpecialty: '',
    ));
  }
} 