import 'package:flutter/material.dart';
import '../models/tamu.dart';
import '../services/tamus_service.dart';

class TamusController with ChangeNotifier {
  final TamusService _tamusService = TamusService();
  List<Tamus> _tamusList = [];
  bool _isLoading = false;
  List<Tamus> get tamusList => _tamusList;
  bool get isLoading => _isLoading;

  Future<void> fetchTamus() async {
    _isLoading = true;
    notifyListeners();

    try {
      _tamusList = await _tamusService.getTamus();
    } catch (e) {
      print(e);
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> addTamu(Tamus tamu) async {
    try {
      await _tamusService.addTamu(tamu);
      await fetchTamus();
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateTamu(Tamus tamu) async {
    try {
      await _tamusService.updateTamu(tamu);
      await fetchTamus();
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteTamu(int id) async {
    try {
      // Hapus dari list lokal
      _tamusList.removeWhere((tamu) => tamu.id == id);
      notifyListeners();

      // Panggil API untuk menghapus data di server
      await _tamusService.deleteTamu(id);
    } catch (e) {
      print(e);
    }
  }
}
