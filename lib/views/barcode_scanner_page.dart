import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:web_app/config.dart';

class BarcodeScannerPage extends StatefulWidget {
  const BarcodeScannerPage({super.key});

  @override
  State<BarcodeScannerPage> createState() => _BarcodeScannerPageState();
}

class _BarcodeScannerPageState extends State<BarcodeScannerPage> {
  bool _isFetching = false;
  String? _error;
  Map<String, dynamic>? _product;

  void _onDetect(BarcodeCapture capture) async {
    if (_isFetching) return;

    final Barcode? barcode = capture.barcodes.first;
    final String? code = barcode?.rawValue;

    if (code == null) return;

    setState(() {
      _isFetching = true;
      _error = null;
    });

    try {
      final response = await http.get(Uri.parse('$apiBaseUrl/products/$code'));

      if (response.statusCode == 200) {
        setState(() {
          _product = jsonDecode(response.body);
        });
      } else {
        setState(() {
          _error = 'Produit non trouvé';
        });
      }
    } catch (e) {
      setState(() {
        _error = 'Erreur serveur : $e';
      });
    } finally {
      setState(() {
        _isFetching = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scanner un produit')),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: MobileScanner(
              onDetect: _onDetect,
            ),
          ),
          if (_isFetching)
            const Padding(
              padding: EdgeInsets.all(20),
              child: CircularProgressIndicator(),
            )
          else if (_error != null)
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(_error!, style: const TextStyle(color: Colors.red)),
            )
          else if (_product != null)
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: ListView(
                  children: [
                    Text("Nom : ${_product!['name'] ?? 'N/A'}", style: const TextStyle(fontSize: 18)),
                    Text("Prix : ${_product!['price'] ?? 'N/A'} €"),
                    Text("Composition : ${_product!['composition'] ?? 'N/A'}"),
                    Text("Description :\n${_product!['description'] ?? 'N/A'}"),
                    Text("Image :\n${_product!['image'] ?? 'N/A'}"),
                    Text("Code :\n${_product!['code'] ?? 'N/A'}"),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}