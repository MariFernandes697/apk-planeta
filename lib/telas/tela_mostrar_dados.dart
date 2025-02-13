import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue).copyWith(surface: Colors.black), // Definimos a cor de fundo como preta
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final planetImages = [
      'https://static.todamateria.com.br/upload/pl/an/planetaterra-cke.jpg',
      'https://s1.static.brasilescola.uol.com.br/be/2021/11/planeta-marte.jpg',
      'https://static.mundoeducacao.uol.com.br/mundoeducacao/2024/01/planeta-jupiter.jpg',
      'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c7/Saturn_during_Equinox.jpg/1200px-Saturn_during_Equinox.jpg',
    ];


    return Scaffold(
      appBar: AppBar(
       title: Text('Planetas', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 43, 26, 127),
        
      ),
      body: Stack(
        children: [
          // Fundo preto
          Container(
            color: Colors.black,
          ),
          // Estrelas
          Positioned.fill(
            child: CustomPaint(
              painter: StarPainter(),
            ),
          ),
       Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(planetImages.length, (index) {
            final angle = (index / planetImages.length) * 2 * pi;
            final xOffset = 200 * cos(angle);
            final yOffset = 150 * sin(angle);

            return Transform.translate(
              offset: Offset(xOffset, yOffset),
              child: Image.network(
                planetImages[index],
                width: 100,
                height: 100,
              ),
            );
          }),
        ),
      ),
        ],
      ),
    );
  }
}

class StarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final random = Random();
    final paint = Paint()..color = Colors.white;

    for (var i = 0; i < 500; i++) {
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height;
      canvas.drawCircle(Offset(x, y), 1, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}


















