import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:web_app/config.dart';
import 'product_detail_page.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class BarcodeScannerPage extends StatefulWidget {
  const BarcodeScannerPage({super.key});

  @override
  State<BarcodeScannerPage> createState() => _BarcodeScannerPageState();
}

class _BarcodeScannerPageState extends State<BarcodeScannerPage> {
  late final MobileScannerController _controller;
  bool _isFetching = false;
  String? codeError;

  @override
  void initState() {
    super.initState();
    _controller = MobileScannerController(
      facing: CameraFacing.back,
      torchEnabled: false,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onDetect(BarcodeCapture capture) async {
    if (_isFetching || capture.barcodes.isEmpty) return;
    final code = capture.barcodes.first.rawValue;
    if (code == null) return;

    setState(() => _isFetching = true);
    try {
      final response = await http.get(Uri.parse('$apiBaseUrl/api/products/code/$code'));
      if (response.statusCode == 200) {
        final product = jsonDecode(response.body);
        if (!mounted) return;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailPage(product: product),
          ),
        );
      } else {
        _showError('Produit non trouvé');
      }
    } catch (e) {
      _showError('Erreur serveur : $e');
    } finally {
      setState(() => _isFetching = false);
    }
  }

  void _showError(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Erreur"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  void _manualCodeEntry() {
    final TextEditingController codeController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text("Entrer un code produit"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: codeController,
                decoration: const InputDecoration(labelText: "Code du produit"),
                keyboardType: TextInputType.number,
              ),
              if (codeError != null)
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Text(
                    codeError!,
                    style: TextStyle(color: Colors.red, fontSize: 12),
                  ),
                ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Annuler"),
            ),
            ElevatedButton(
              onPressed: () {
                final code = codeController.text.trim();
                if (code.isEmpty) {
                  setDialogState(() {
                    codeError = "Le code produit est requis.";
                  });
                  return;
                }
                Navigator.pop(context);
                _fetchProduct(code);
              },
              child: const Text("Rechercher"),
            ),
          ],
        ),
      ),
    );
  }

  void _fetchProduct(String code) async {
    setState(() => _isFetching = true);
    try {
      final response = await http.get(Uri.parse('$apiBaseUrl/api/products/code/$code'));
      if (response.statusCode == 200) {
        final product = jsonDecode(response.body);
        if (!mounted) return;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailPage(product: product),
          ),
        );
      } else {
        _showError('Produit non trouvé');
      }
    } catch (e) {
      _showError('Erreur serveur : $e');
    } finally {
      setState(() => _isFetching = false);
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
            child: Stack(
              alignment: Alignment.center,
              children: [
                MobileScanner(
                  controller: _controller,
                  onDetect: _onDetect,
                ),
                Positioned(
                  top: 16,
                  right: 16,
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.flash_on, color: Colors.white),
                        onPressed: () {
                          _controller.toggleTorch();
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.flip_camera_ios, color: Colors.white),
                        onPressed: () {
                          _controller.switchCamera();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (_isFetching)
            const Padding(
              padding: EdgeInsets.all(20),
              child: CircularProgressIndicator(),
            ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: ElevatedButton(
              onPressed: _manualCodeEntry,
              child: const Text("Renseigner le code manuellement"),
            ),
          ),
        ],
      ),
    );
  }
}