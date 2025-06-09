import 'package:flutter/material.dart';
import 'package:graduation_medical_app/core/config/route_names.dart';
import 'package:graduation_medical_app/core/localization/app_localizations.dart';
import 'cat_icon_widget.dart';

class CatIconsRow extends StatelessWidget {
  const CatIconsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: CatIconWidget(
            label: AppLocalizations.of(context).doctor,
            asset: 'lib/assets/icon/doctors.png',
            route: RouteNames.doctorList,
          ),
        ),
        Expanded(
          child: CatIconWidget(
            label: AppLocalizations.of(context).pharmacies,
            asset: 'lib/assets/icon/pharmacy.png',
            route: RouteNames.pharmacy,
          ),
        ),
        Expanded(
          child: CatIconWidget(
            label: AppLocalizations.of(context).hospitals,
            asset: 'lib/assets/icon/hospital.png',
            route: RouteNames.hospital,
          ),
        ),
        Expanded(
          child: CatIconWidget(
            label: AppLocalizations.of(context).specialties,
            asset: 'lib/assets/icon/Specialties.png',
            route: RouteNames.specialties,
          ),
        ),
      ],
    );
  }
}
