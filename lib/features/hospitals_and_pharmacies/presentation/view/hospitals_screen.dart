import 'package:flutter/material.dart';
import 'dart:async';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_style.dart';
import '../../load_data/load_hospital_data.dart';
import '../../models/hospital_model.dart';
import '../../../../core/localization/app_localizations.dart';

class HospitalScreen extends StatefulWidget {
  const HospitalScreen({Key? key}) : super(key: key);

  @override
  State<HospitalScreen> createState() => _HospitalScreenState();
}

class _HospitalScreenState extends State<HospitalScreen> {
  late Future<List<Hospital>> _hospitalsFuture;
  List<Hospital> _allHospitals = [];
  List<Hospital> _filteredHospitals = [];
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;
  bool _isSearching = false;
  String _searchError = '';

  @override
  void initState() {
    super.initState();
    _hospitalsFuture = loadHospitalData().then((hospitals) {
      _allHospitals = hospitals;
      _filteredHospitals = hospitals;
      return hospitals;
    });
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    setState(() => _isSearching = true);

    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (_searchController.text.isEmpty) {
    setState(() {
          _filteredHospitals = _allHospitals;
          _isSearching = false;
          _searchError = '';
        });
        return;
      }

      try {
        final query = _searchController.text.toLowerCase().trim();
        final filtered = _allHospitals.where((hospital) {
          final name = hospital.name.toLowerCase();
          final location = hospital.location.toLowerCase();
          final type = hospital.type.toLowerCase();

          final queryWords = query.split(' ');
          return queryWords.every((word) =>
          name.contains(word) ||
              location.contains(word) ||
              type.contains(word));
      }).toList();

        setState(() {
          _filteredHospitals = filtered;
          _isSearching = false;
          _searchError = filtered.isEmpty ? 'No hospitals found matching "$query"' : '';
        });
      } catch (e) {
        setState(() {
          _filteredHospitals = _allHospitals;
          _isSearching = false;
          _searchError = 'Error occurred while searching. Please try again.';
        });
      }
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          AppLocalizations.of(context).hospitals,
          style: TextStyle(
            color: Colors.black87,
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list, color: Colors.black54),
            onPressed: () {
              // Add filter functionality
            },
          ),
        ],
      ),
      body: Container(
        color: Colors.grey[50],
        child: FutureBuilder<List<Hospital>>(
        future: _hospitalsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
              return Center(
                child: CircularProgressIndicator(
                  color: Color(0xFF30948F),
                ),
              );

          if (snapshot.hasError)
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline, size: 60, color: Colors.grey),
                    SizedBox(height: 16),
                    Text(
                      AppLocalizations.of(context).errorOccurred,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              );

          return Column(
            children: [
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context).searchHint,
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                      icon: Icon(Icons.clear, color: Colors.grey[400]),
                      onPressed: () {
                        _searchController.clear();
                      },
                    )
                        : null,
                    filled: true,
                    fillColor: Colors.grey[100],
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Color(0xFF30948F), width: 1),
                      ),
                    ),
                  ),
                ),
                if (_isSearching)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF30948F)),
                ),
              ),
              Expanded(
                  child: _filteredHospitals.isEmpty && !_isSearching
                      ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.local_hospital_outlined,
                          size: 64,
                          color: Colors.grey[400],
                        ),
                        SizedBox(height: 16),
                        Text(
                          _searchController.text.isEmpty
                              ? AppLocalizations.of(context).noHospitalsAvailable
                              : AppLocalizations.of(context).noHospitalsFound,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  )
                    : ListView.builder(
                    padding: EdgeInsets.all(16),
                  itemCount: _filteredHospitals.length,
                  itemBuilder: (context, index) {
                    final hospital = _filteredHospitals[index];
                      return Container(
                        margin: EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              spreadRadius: 0,
                              blurRadius: 10,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              // Navigate to hospital details
                            },
                            borderRadius: BorderRadius.circular(12),
                            child: Padding(
                              padding: EdgeInsets.all(16),
                              child: Row(
                                children: [
                                  Container(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[100],
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Center(
                                      child: Text(
                                        hospital.name[0].toUpperCase(),
                                        style: TextStyle(
                                          color: Color(0xFF30948F),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 24,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          hospital.name,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                            color: Colors.black87,
                                          ),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          AppLocalizations.of(context).hospitalType + ': ' + hospital.type,
                                          style: TextStyle(
                                            color: Color(0xFF30948F),
                                            fontSize: 14,
                                          ),
                                        ),
                                        SizedBox(height: 4),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.location_on,
                                              size: 16,
                                              color: Colors.grey[400],
                                            ),
                                            SizedBox(width: 4),
                                            Expanded(
                                              child: Text(
                                                hospital.location,
                                                style: TextStyle(
                                                  color: Colors.grey[600],
                                                  fontSize: 14,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.calendar_today_outlined,
                                            color: Colors.grey[400]),
                                        onPressed: () {
                                          // Book appointment
                                        },
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.favorite_border,
                                            color: Colors.grey[400]),
                          onPressed: () {
                                          // Add to favorites
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
        ),
      ),
    );
  }
}
