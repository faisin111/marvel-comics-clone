import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstants {
  static String get baseUrl => dotenv.env["BASE_UL"]!;
  static String get apiKey => dotenv.env["API_KEY"]!;
  static const String characters = "/characters/";
  static const String character = "/character/";
  static const String issues = "/issues/";
  static const String issue = "/issue/";
  static const String search = "/search/";
}
