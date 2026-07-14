import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstants {
  static String get baseUrl=> dotenv.env["BASE_UL"]!;
  static String get apiKey=>dotenv.env["API_KEY"]!;

}