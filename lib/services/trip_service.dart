import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/trip_model.dart';

class TripService {
  static const String baseUrl = 'http://172.29.240.1:4000/api';

  Future<List<Trip>> fetchAllTrips() async {
    final response = await http.get(Uri.parse('$baseUrl/trips'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Trip.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load trips');
    }
  }

  // Fetch trips for a specific user
  Future<List<Trip>> fetchUserTrips(int userId) async {
    final response = await http.get(Uri.parse('$baseUrl/users/$userId/trips'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Trip.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load user trips');
    }
  }

  Future<Trip> fetchTripById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/trips/$id'));

    if (response.statusCode == 200) {
      return Trip.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load trip');
    }
  }

  Future<bool> deleteTrip(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/trips/$id'));
    return response.statusCode == 200;
  }
}
