import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'guardardatosdiccionario.dart';

class CapturaEmpleados extends StatefulWidget {
  const CapturaEmpleados({super.key});

  @override
  CapturaEmpleadosState createState() => CapturaEmpleadosState();
}

class CapturaEmpleadosState extends State<CapturaEmpleados> {
  final _formKey = GlobalKey<FormState>();
  
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _puestoController = TextEditingController();
  final TextEditingController _salarioController = TextEditingController();

  void _guardar() {
    if (_formKey.currentState!.validate()) {
      double salario = double.parse(_salarioController.text);
      GuardarDatosDiccionario.guardarEmpleado(
        _nombreController.text,
        _puestoController.text,
        salario,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('REGISTRO GUARDADO CON ÉXITO', style: TextStyle(letterSpacing: 1.5)),
          behavior: SnackBarBehavior.floating,
        ),
      );

      _nombreController.clear();
      _puestoController.clear();
      _salarioController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NUEVO REGISTRO'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(35.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Center(
                  child: Icon(Icons.badge_outlined, size: 60, color: Color(0xFFD4AF37)),
                ),
                const SizedBox(height: 15),
                const Center(
                  child: Text(
                    'INGRESO DE DATOS PERSONALES',
                    style: TextStyle(
                      color: Colors.white54,
                      letterSpacing: 2.5,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                _buildDarkTextField(
                  controller: _nombreController,
                  label: 'Nombre o Razón Social',
                  icon: Icons.person_outline,
                  errorMsg: 'Campo requerido',
                ),
                const SizedBox(height: 30),
                _buildDarkTextField(
                  controller: _puestoController,
                  label: 'Cargo Asignado',
                  icon: Icons.work_outline,
                  errorMsg: 'Campo requerido',
                ),
                const SizedBox(height: 30),
                _buildDarkTextField(
                  controller: _salarioController,
                  label: 'Nómina Base Mensual',
                  icon: Icons.monetization_on_outlined,
                  errorMsg: 'Monto inválido',
                  isNumber: true,
                ),
                const SizedBox(height: 60),
                ElevatedButton(
                  onPressed: _guardar,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD4AF37),
                    foregroundColor: const Color(0xFF1A1A1D), // Texto oscuro
                    padding: const EdgeInsets.symmetric(vertical: 22),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    elevation: 5,
                    shadowColor: const Color(0xFFD4AF37).withOpacity(0.4),
                  ),
                  child: const Text(
                    'PROCESAR EXPEDIENTE',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 2.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDarkTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required String errorMsg,
    bool isNumber = false,
  }) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(color: Colors.white, fontSize: 16),
      keyboardType: isNumber ? const TextInputType.numberWithOptions(decimal: true) : TextInputType.text,
      inputFormatters: isNumber ? [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))] : [],
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white54, letterSpacing: 1.5, fontSize: 14),
        prefixIcon: Icon(icon, color: const Color(0xFFD4AF37), size: 22),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white24),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFD4AF37), width: 1.5),
        ),
        errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF8B0000)),
        ),
        filled: true,
        fillColor: Colors.transparent, // Inputs transparentes para mantener lo oscuro y elegante
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) return errorMsg;
        if (isNumber && double.tryParse(value) == null) return errorMsg;
        return null;
      },
    );
  }
  
  @override
  void dispose() {
    _nombreController.dispose();
    _puestoController.dispose();
    _salarioController.dispose();
    super.dispose();
  }
}
