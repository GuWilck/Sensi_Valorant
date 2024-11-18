import 'package:flutter/material.dart';

void main() {
  runApp(const SensiValorantApp());
}

class SensiValorantApp extends StatelessWidget {
  const SensiValorantApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sensi Valorant',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SensiValorantHomePage(),
    );
  }
}

class SensiValorantHomePage extends StatefulWidget {
  const SensiValorantHomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SensiValorantHomePageState createState() => _SensiValorantHomePageState();
}

class _SensiValorantHomePageState extends State<SensiValorantHomePage> {
  final TextEditingController _mousePadController = TextEditingController();
  final TextEditingController _dpiController = TextEditingController();
  double _sensitivity = 0.0;

  void _calculateSensitivity() {
    final double mousePadSize =
        double.tryParse(_mousePadController.text) ?? 0.0;
    final int dpi = int.tryParse(_dpiController.text) ?? 0;

    if (mousePadSize > 0 && dpi > 0) {
      double sensi = ((-45 * mousePadSize) + 3000) / dpi;
      sensi = sensi / 3.18;

      setState(() {
        _sensitivity = sensi;
      });
    } else {
      setState(() {
        _sensitivity = 0.0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text("Sensi Valorant")],
        ),
        backgroundColor: const Color.fromARGB(255, 83, 10, 10),
        foregroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.jpg'), // Caminho para a imagem no projeto
            fit: BoxFit.cover, // Ajusta a imagem para cobrir todo o espaço disponível
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              TextField(
                controller: _mousePadController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Tamanho do Mouse Pad (cm)',
                ),
              ),
              TextField(
                controller: _dpiController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'DPI',
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _calculateSensitivity,
                child: const Text('Calcular Sensibilidade'),
              ),
              const SizedBox(height: 20),
              Text(
                'Sua sensibilidade para Valorant é: ${_sensitivity.toStringAsFixed(3)}',
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
