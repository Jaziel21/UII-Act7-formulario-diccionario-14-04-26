import 'package:flutter/material.dart';

class Inicio extends StatelessWidget {
  const Inicio({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PORTAL EJECUTIVO'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFFD4AF37), width: 1.5),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFD4AF37).withOpacity(0.08),
                      blurRadius: 30,
                      spreadRadius: 10,
                    )
                  ],
                ),
                child: const Icon(
                  Icons.business,
                  size: 80,
                  color: Color(0xFFD4AF37),
                ),
              ),
              const SizedBox(height: 60),
              _buildModernButton(
                context,
                route: '/captura',
                icon: Icons.person_add_alt_1,
                label: 'REGISTRAR EMPLEADO',
              ),
              const SizedBox(height: 24),
              _buildModernButton(
                context,
                route: '/ver',
                icon: Icons.folder_shared,
                label: 'DIRECTORIO CORPORATIVO',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildModernButton(BuildContext context, {required String route, required IconData icon, required String label}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            offset: const Offset(0, 8),
            blurRadius: 15,
          )
        ],
      ),
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, route);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF26262B), // Gris muy oscuro
          foregroundColor: const Color(0xFFD4AF37), // Letras doradas
          padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
            side: BorderSide(color: const Color(0xFFD4AF37).withOpacity(0.3), width: 1),
          ),
          minimumSize: const Size(double.infinity, 60),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 24),
            const SizedBox(width: 15),
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                letterSpacing: 2.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
