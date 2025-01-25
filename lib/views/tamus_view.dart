import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/tamus_controller.dart';
import 'tamus_form_view.dart';

class TamusView extends StatefulWidget {
  @override
  _TamusViewState createState() => _TamusViewState();
}

class _TamusViewState extends State<TamusView> {
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final tamusController =
          Provider.of<TamusController>(context, listen: false);
      tamusController.fetchTamus();
    });
  }

  void _showDeleteConfirmationDialog(BuildContext context, int tamuId) {
    showDialog(
      context: context,
      builder: (context) {
        final tamusController =
            Provider.of<TamusController>(context, listen: false);
        return AlertDialog(
          backgroundColor: Colors.black,
          title: Text(
            'Konfirmasi Hapus',
            style: TextStyle(color: Colors.white),
          ),
          content: Text(
            'Anda yakin ingin menghapus data tamu ini?',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Tidak',
                style: TextStyle(color: Colors.red),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
              ),
              onPressed: () {
                tamusController.deleteTamu(tamuId);
                Navigator.pop(context);
                tamusController.fetchTamus();
              },
              child: Text(
                'Ya',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final tamusController = Provider.of<TamusController>(context);

    final filteredTamus = _searchQuery.isEmpty
        ? tamusController.tamusList
        : tamusController.tamusList
            .where((tamu) => tamu.kodeTamu
                .toLowerCase()
                .contains(_searchQuery.toLowerCase()))
            .toList();

    filteredTamus.sort((a, b) => a.kodeTamu.compareTo(b.kodeTamu));

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          'Daftar Tamu',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red[800],
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: () {
              showSearchDialog(context);
            },
          ),
        ],
      ),
      body: tamusController.isLoading
          ? Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: () async {
                await tamusController.fetchTamus();
              },
              child: ListView.builder(
                padding: EdgeInsets.all(10.0),
                itemCount: filteredTamus.length,
                itemBuilder: (context, index) {
                  final tamu = filteredTamus[index];
                  return Card(
                    elevation: 4,
                    margin: EdgeInsets.symmetric(vertical: 8),
                    color: Colors.black,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () => showGuestDetails(context, tamu),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  ' ${tamu.kodeTamu}  ${tamu.namaTamu}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit, color: Colors.blue),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        backgroundColor: Colors.black,
                                        title: Text(
                                          'Konfirmasi Update',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        content: Text(
                                          'Anda yakin ingin mengubah data tamu ini?',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              'Tidak',
                                              style:
                                                  TextStyle(color: Colors.red),
                                            ),
                                          ),
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.white,
                                            ),
                                            onPressed: () {
                                              Navigator.pop(context);
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      TamusFormView(tamu: tamu),
                                                ),
                                              ).then((_) =>
                                                  tamusController.fetchTamus());
                                            },
                                            child: Text(
                                              'Ya',
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () => _showDeleteConfirmationDialog(
                                    context, tamu.id),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (_searchQuery.isNotEmpty)
            FloatingActionButton.extended(
              onPressed: () {
                setState(() {
                  _searchQuery = '';
                });
              },
              label: Text('Daftar Tamu'),
              icon: Icon(Icons.arrow_back),
              backgroundColor: Colors.orange,
              heroTag: 'back',
            ),
          SizedBox(width: 10),
          FloatingActionButton.extended(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TamusFormView()),
              ).then((_) => tamusController.fetchTamus());
            },
            label: Text('Tambah', style: TextStyle(color: Colors.white)),
            icon: Icon(Icons.add, color: Colors.white),
            backgroundColor: Colors.red[800],
            heroTag: 'add',
          ),
        ],
      ),
    );
  }

  void showSearchDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        String searchInput = _searchQuery;
        return AlertDialog(
          backgroundColor: Colors.black,
          title: Text(
            'Cari Tamu',
            style: TextStyle(color: Colors.white),
          ),
          content: TextField(
            onChanged: (value) {
              searchInput = value;
            },
            decoration: InputDecoration(
              labelText: 'Masukkan Kode Undangan',
              labelStyle: TextStyle(color: Colors.white),
              prefixIcon: Icon(Icons.search, color: Colors.white),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
            ),
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Batal',
                style: TextStyle(color: Colors.red),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  _searchQuery = searchInput;
                });
                Navigator.pop(context);
              },
              child: Text(
                'Cari',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        );
      },
    );
  }

  void showGuestDetails(BuildContext context, tamu) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Detail Tamu', style: TextStyle(color: Colors.red)),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Nomor Tamu: ${tamu.kodeTamu}',
                  style: TextStyle(color: Colors.black)),
              SizedBox(height: 8),
              Text('Nama: ${tamu.namaTamu}',
                  style: TextStyle(color: Colors.black)),
              SizedBox(height: 8),
              Text('Alamat: ${tamu.alamatTamu}',
                  style: TextStyle(color: Colors.black)),
              SizedBox(height: 8),
              Text('No HP: ${tamu.noTelpon}',
                  style: TextStyle(color: Colors.black)),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Tutup', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}
