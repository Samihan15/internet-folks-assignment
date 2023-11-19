import 'package:flutter/material.dart';
import '../model/event.dart';
import '../service/service.dart';

class EventProvider extends ChangeNotifier {
  final String url;
  final EventService _eventService;
  List<Event> _events = [];
  List<Event> get events => _events;

  EventProvider({required this.url})
      : _eventService = EventService(apiUrl: url);

  Future<List<Event>> fetchEvents() async {
    try {
      _events = await _eventService.fetchEvents();
      return _events;
    } catch (error) {
      print('Error fetching events: $error');
      rethrow;
    }
  }

  Future<List<Event>> searchEvents(String query) async {
    try {
      final events = await _eventService.searchEvents(query);
      _events = events;
      return events;
    } catch (error) {
      print('Error searching events: $error');
      rethrow;
    }
  }
}
