import 'package:flutter/material.dart';
import 'package:web_app/config.dart';
import 'product_detail_page.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ManualCodeEntryPage extends StatefulWidget {
  const ManualCodeEntryPage({super.key});

  @override
  State<ManualCodeEntryPage> createState() => _ManualCodeEntryPageState();
}

class _ManualCodeEntryPageState extends State<ManualCodeEntryPage> {
  final TextEditingController _controller = TextEditingController();
  bool _isLoading = false;
  String? _error;

  void _fetchProduct() async {
    final code = _controller.text.trim();
    if (code.isEmpty) return;

    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final response = await http.get(Uri.parse('$apiBaseUrl/api/products/code/$code'));
      if (response.statusCode == 200) {
        final product = jsonDecode(response.body);
        if (!mounted) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailPage(product: product),
          ),
        );
      } else {
        setState(() => _error = 'Produit non trouvé');
      }
    } catch (e) {
      setState(() => _error = 'Erreur serveur : $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Entrer un code')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Code du produit',
              ),
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _fetchProduct(),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isLoading ? null : _fetchProduct,
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : const Text('Rechercher'),
            ),
            if (_error != null)
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(_error!, style: const TextStyle(color: Colors.red)),
              ),
          ],
        ),
      ),
    );
  }
}