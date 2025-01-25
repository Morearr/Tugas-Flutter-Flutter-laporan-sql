import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/tamu.dart';

class TamusService {
  final String apiUrl = "http://192.168.1.11:8000/api/tamu";

  Future<List<Tamus>> getTamus() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      return tamusFromJson(response.body);
    } else {
      throw Exception('Failed to load Tamus');
    }
  }

  Future<void> addTamu(Tamus tamu) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {"Content-Type": "application/json"},
      body: json.encode(tamu.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to add Tamu');
    }
  }

  Future<void> updateTamu(Tamus tamu) async {
    final url = "$apiUrl/${tamu.id}";
    final response = await http.put(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: json.encode(tamu.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update Tamu');
    }
  }

  Future<void> deleteTamu(int id) async {
    final url = "$apiUrl/$id";
    final response = await http.delete(Uri.parse(url));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete Tamu');
    }
  }
}
