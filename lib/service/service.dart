import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/event.dart';

class EventService {
  final String apiUrl;

  EventService({required this.apiUrl});

  Future<List<Event>> fetchEvents() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData =
          json.decode(response.body)['content']['data'];
      return jsonData.map((json) => Event.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load events');
    }
  }

  Future<List<Event>> searchEvents(String query) async {
    final response = await http.get(Uri.parse('$apiUrl?search=$query'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData =
          json.decode(response.body)['content']['data'];
      return jsonData.map((json) => Event.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load events');
    }
  }
}
