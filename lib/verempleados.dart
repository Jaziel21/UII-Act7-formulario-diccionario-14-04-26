import 'package:flutter/material.dart';
import 'diccionarioempleado.dart';

class VerEmpleados extends StatefulWidget {
  const VerEmpleados({super.key});

  @override
  State<VerEmpleados> createState() => _VerEmpleadosState();
}

class _VerEmpleadosState extends State<VerEmpleados> {
  @override
  Widget build(BuildContext context) {
    final listaEmpleados = datosempleado.values.toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('NÓMINA CORPORATIVA'),
      ),
      body: listaEmpleados.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.drive_folder_upload, size: 70, color: Colors.white12),
                  SizedBox(height: 25),
                  Text(
                    'NO SE ENCONTRARON REGISTROS',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white38,
                      letterSpacing: 3,
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              itemCount: listaEmpleados.length,
              itemBuilder: (context, index) {
                final empleado = listaEmpleados[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 25),
                  decoration: BoxDecoration(
                    color: const Color(0xFF202024), // Superficie oscura secundaria
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: Colors.white10, width: 1),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.6),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      )
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 45,
                          height: 45,
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xFFD4AF37), width: 1),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              empleado.id.toString().padLeft(3, '0'),
                              style: const TextStyle(
                                fontWeight: FontWeight.w400, 
                                fontSize: 13, 
                                color: Color(0xFFD4AF37),
                                letterSpacing: 1.5,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 25),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                empleado.nombre.toUpperCase(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600, 
                                  fontSize: 14,
                                  letterSpacing: 2,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  const Icon(Icons.stars_outlined, size: 14, color: Colors.white38),
                                  const SizedBox(width: 10),
                                  Text(
                                    empleado.puesto.toUpperCase(), 
                                    style: const TextStyle(fontSize: 11, color: Colors.white70, letterSpacing: 1.5)
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  const Icon(Icons.account_balance_wallet_outlined, size: 14, color: Color(0xFFD4AF37)),
                                  const SizedBox(width: 10),
                                  Text(
                                    '\$ ${empleado.salario.toStringAsFixed(2)}',
                                    style: const TextStyle(
                                      fontSize: 12, 
                                      color: Color(0xFFD4AF37), 
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 2,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
