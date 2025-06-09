import 'package:flutter/material.dart';
import 'package:graduation_medical_app/core/config/route_names.dart';
import 'package:graduation_medical_app/features/search/presentation/view/global_search_screen.dart';
import 'package:graduation_medical_app/features/hospitals_and_pharmacies/presentation/view/hospitals_screen.dart';
import 'package:graduation_medical_app/features/hospitals_and_pharmacies/presentation/view/pharmacies_screen.dart';
import 'package:graduation_medical_app/features/hospitals_and_pharmacies/models/hospital_model.dart';
import 'package:graduation_medical_app/features/hospitals_and_pharmacies/models/pharmacy_model.dart';


class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.globalSearch:
        return MaterialPageRoute(
          builder: (_) => GlobalSearchScreen(),
        );
      

      case RouteNames.hospital:
        final hospital = settings.arguments as Hospital;
        return MaterialPageRoute(
          builder: (_) => HospitalScreen(),
        );
      
      case RouteNames.pharmacy:
        final pharmacy = settings.arguments as Pharmacy;
        return MaterialPageRoute(
          builder: (_) => PharmacyListScreen(),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
} 