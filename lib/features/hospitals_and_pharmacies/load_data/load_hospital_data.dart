import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

import '../models/hospital_model.dart';

Future<List<Hospital>> loadHospitalData() async {
  final String jsonString = await rootBundle.loadString('lib/assets/data/hospitals.json');
  final List<dynamic> jsonResponse = json.decode(jsonString);
  return jsonResponse.map((data) => Hospital.fromJson(data)).toList();
}
