import 'dart:convert';
import 'package:flutter/services.dart';

import '../models/pharmacy_model.dart';

Future<List<Pharmacy>> loadPharmacies() async {
  final jsonString = await rootBundle.loadString('lib/assets/data/pharmacies.json');
  final jsonList = json.decode(jsonString) as List;
  return jsonList.map((e) => Pharmacy.fromJson(e)).toList();
}
