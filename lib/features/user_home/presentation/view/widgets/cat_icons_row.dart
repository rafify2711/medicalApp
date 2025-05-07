import 'package:flutter/material.dart';

import '../../../../../core/config/route_names.dart';
import 'cat_icon_widget.dart';

class CatIconsRow extends StatelessWidget {
  const CatIconsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
    Expanded(
    child:const CatIconWidget(label: 'Doctor', asset: 'lib/assets/icon/doctors.png',route: RouteNames.doctorList,),
    ),
    Expanded(
    child: const CatIconWidget(label: 'pharmacies', asset: 'lib/assets/icon/pharmacy.png',route: RouteNames.pharmacy ,),
    ),

    Expanded(
    child:const CatIconWidget(label: 'hospitals', asset: 'lib/assets/icon/hospital.png',route: RouteNames.hospital ,)
    ),

    Expanded(
    child: const CatIconWidget(label:  "specialties", asset: 'lib/assets/icon/Specialties.png',route: '' ,),
    ),
    ],
    );
  }
}
