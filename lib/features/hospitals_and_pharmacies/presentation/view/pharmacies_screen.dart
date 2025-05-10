import 'package:flutter/material.dart';
import 'dart:async';
import '../../../../core/utils/app_colors.dart';
import '../../load_data/load_pharmacies_data.dart';
import '../../models/pharmacy_model.dart';
import '../../../../core/localization/app_localizations.dart';

class PharmacyListScreen extends StatefulWidget {
  @override
  _PharmacyListScreenState createState() => _PharmacyListScreenState();
}

class _PharmacyListScreenState extends State<PharmacyListScreen> {
  late Future<List<Pharmacy>> _pharmaciesFuture;
  List<Pharmacy> _allPharmacies = [];
  List<Pharmacy> _filteredPharmacies = [];
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;
  bool _isSearching = false;
  String _searchError = '';

  @override
  void initState() {
    super.initState();
    _pharmaciesFuture = loadPharmacies().then((pharmacies) {
      _allPharmacies = pharmacies;
      _filteredPharmacies = pharmacies;
      return pharmacies;
    });
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    setState(() => _isSearching = true);

    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (_searchController.text.isEmpty) {
        setState(() {
          _filteredPharmacies = _allPharmacies;
          _isSearching = false;
          _searchError = '';
        });
        return;
      }

      try {
        final query = _searchController.text.toLowerCase().trim();
        final filtered = _allPharmacies.where((pharmacy) {
          final nameMatch = pharmacy.name.toLowerCase().contains(query);
          final branchMatch = pharmacy.branches.any((branch) =>
          branch.name.toLowerCase().contains(query) ||
              branch.address.toLowerCase().contains(query));
          return nameMatch || branchMatch;
        }).toList();

        setState(() {
          _filteredPharmacies = filtered;
          _isSearching = false;
          _searchError = filtered.isEmpty ? 'No pharmacies found matching "$query"' : '';
        });
      } catch (e) {
        setState(() {
          _filteredPharmacies = _allPharmacies;
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
          AppLocalizations.of(context).pharmacies,
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
        child: FutureBuilder<List<Pharmacy>>(
          future: _pharmaciesFuture,
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
                  child: _filteredPharmacies.isEmpty && !_isSearching
                      ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.local_pharmacy_outlined,
                          size: 64,
                          color: Colors.grey[400],
                        ),
                        SizedBox(height: 16),
                        Text(
                          _searchController.text.isEmpty
                              ? AppLocalizations.of(context).noPharmaciesAvailable
                              : AppLocalizations.of(context).noPharmaciesFound,
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
                    itemCount: _filteredPharmacies.length,
                    itemBuilder: (context, index) {
                      final pharmacy = _filteredPharmacies[index];
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
                        child: Theme(
                          data: Theme.of(context).copyWith(
                            dividerColor: Colors.transparent,
                            colorScheme: ColorScheme.light(
                              primary: Color(0xFF30948F),
                            ),
                          ),
                          child: ExpansionTile(
                            leading: Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Center(
                                child: Text(
                                  pharmacy.name[0].toUpperCase(),
                                  style: TextStyle(
                                    color: Color(0xFF30948F),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24,
                                  ),
                                ),
                              ),
                            ),
                            title: Text(
                              pharmacy.name,
                              style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                            subtitle: Text(
                              '${pharmacy.branches.length} ${pharmacy.branches.length == 1 ? AppLocalizations.of(context).branch : AppLocalizations.of(context).branches}',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 14,
                              ),
                            ),
                            children: pharmacy.branches.map((branch) {
                              return Container(
                                margin: EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                padding: EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.grey[50],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      branch.name,
                                      style: TextStyle(
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Icon(Icons.location_on,
                                            color: Colors.grey[400], size: 16),
                                        SizedBox(width: 4),
                                        Expanded(
                                          child: Text(
                                            branch.address,
                                            style: TextStyle(
                                              color: Colors.grey[600],
                                              fontSize: 14,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 4),
                                    Row(
                                      children: [
                                        Icon(Icons.phone,
                                            color: Colors.grey[400], size: 16),
                                        SizedBox(width: 4),
                                        Text(
                                          branch.phone,
                                          style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                    if (branch.website != "Not specified")
                                      Padding(
                                        padding: const EdgeInsets.only(top: 4),
                                        child: Row(
                                          children: [
                                            Icon(Icons.language,
                                                color: Colors.grey[400], size: 16),
                                            SizedBox(width: 4),
                                            Text(
                                              AppLocalizations.of(context).visitWebsite,
                                              style: TextStyle(
                                                color: Color(0xFF30948F),
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                  ],
                                ),
                              );
                            }).toList(),
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
