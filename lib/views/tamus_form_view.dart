import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/tamus_controller.dart';
import '../models/tamu.dart';

class TamusFormView extends StatefulWidget {
  final Tamus? tamu;

  const TamusFormView({Key? key, this.tamu}) : super(key: key);

  @override
  _TamusFormViewState createState() => _TamusFormViewState();
}

class _TamusFormViewState extends State<TamusFormView> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _kodeTamuController;
  late TextEditingController _namaTamuController;
  late TextEditingController _alamatTamuController;
  late TextEditingController _noTelponController;

  @override
  void initState() {
    super.initState();
    _kodeTamuController =
        TextEditingController(text: widget.tamu?.kodeTamu ?? '');
    _namaTamuController =
        TextEditingController(text: widget.tamu?.namaTamu ?? '');
    _alamatTamuController =
        TextEditingController(text: widget.tamu?.alamatTamu ?? '');
    _noTelponController =
        TextEditingController(text: widget.tamu?.noTelpon ?? '');
  }

  @override
  void dispose() {
    _kodeTamuController.dispose();
    _namaTamuController.dispose();
    _alamatTamuController.dispose();
    _noTelponController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tamusController =
        Provider.of<TamusController>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.black, // Set background color to black
      appBar: AppBar(
        title: Text(widget.tamu == null ? 'Tambah Tamu' : 'Edit Tamu'),
        backgroundColor: Colors.red[800], // Consistent with previous screens
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          color: Colors
              .black, // Match the card background with the page background
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.tamu == null ? 'Tambah Data Tamu' : 'Edit Data Tamu',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // White text for contrast
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _kodeTamuController,
                    decoration: InputDecoration(
                      labelText: 'Kode Tamu',
                      labelStyle:
                          TextStyle(color: Colors.white), // White label text
                      border: OutlineInputBorder(),
                      prefixIcon:
                          Icon(Icons.code, color: Colors.white), // White icons
                    ),
                    style: TextStyle(color: Colors.white), // White text color
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Kode Tamu tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _namaTamuController,
                    decoration: InputDecoration(
                      labelText: 'Nama Tamu',
                      labelStyle:
                          TextStyle(color: Colors.white), // White label text
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person,
                          color: Colors.white), // White icons
                    ),
                    style: TextStyle(color: Colors.white), // White text color
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Nama Tamu tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _alamatTamuController,
                    decoration: InputDecoration(
                      labelText: 'Alamat Tamu',
                      labelStyle:
                          TextStyle(color: Colors.white), // White label text
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.location_on,
                          color: Colors.white), // White icons
                    ),
                    style: TextStyle(color: Colors.white), // White text color
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Alamat Tamu tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _noTelponController,
                    decoration: InputDecoration(
                      labelText: 'No Telepon',
                      labelStyle:
                          TextStyle(color: Colors.white), // White label text
                      border: OutlineInputBorder(),
                      prefixIcon:
                          Icon(Icons.phone, color: Colors.white), // White icons
                    ),
                    keyboardType: TextInputType.phone,
                    style: TextStyle(color: Colors.white), // White text color
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'No Telepon tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red[
                            800], // Consistent with AppBar and other buttons
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final tamu = Tamus(
                            id: widget.tamu?.id ?? 0,
                            kodeTamu: _kodeTamuController.text,
                            namaTamu: _namaTamuController.text,
                            alamatTamu: _alamatTamuController.text,
                            noTelpon: _noTelponController.text,
                            createdAt: widget.tamu?.createdAt ?? DateTime.now(),
                            updatedAt: DateTime.now(),
                          );

                          if (widget.tamu == null) {
                            tamusController.addTamu(tamu);
                          } else {
                            tamusController.updateTamu(tamu);
                          }

                          Navigator.pop(context);
                        }
                      },
                      child: Text(
                        widget.tamu == null ? 'Tambah' : 'Simpan',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white), // White text on button
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
