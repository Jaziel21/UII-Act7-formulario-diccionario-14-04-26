import 'package:flutter/material.dart';
import 'inicio.dart';
import 'capturaempleados.dart';
import 'verempleados.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Portal Ejecutivo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        primaryColor: const Color(0xFFD4AF37), // Dorado formal
        scaffoldBackgroundColor: const Color(0xFF1A1A1D), // Fondo oscuro exótico
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFD4AF37),
          secondary: Color(0xFF8B0000), // Rojo granate para acentos
          surface: Color(0xFF26262B), // Superficies (tarjetas/paneles)
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1A1A1D),
          elevation: 0,
          centerTitle: true,
          iconTheme: IconThemeData(color: Color(0xFFD4AF37)),
          titleTextStyle: TextStyle(
            color: Color(0xFFD4AF37),
            fontSize: 18,
            fontWeight: FontWeight.w400,
            letterSpacing: 4.0, // Letras espaciadas formal
          ),
        ),
        snackBarTheme: const SnackBarThemeData(
          backgroundColor: Color(0xFFD4AF37),
          contentTextStyle: TextStyle(color: Color(0xFF1A1A1D), fontWeight: FontWeight.bold),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const Inicio(),
        '/captura': (context) => const CapturaEmpleados(),
        '/ver': (context) => const VerEmpleados(),
      },
    );
  }
}
