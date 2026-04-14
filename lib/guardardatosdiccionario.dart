import 'claseempleado.dart';
import 'diccionarioempleado.dart';

class GuardarDatosDiccionario {
  // Contador para el ID autonumérico
  static int _siguienteId = 1;

  // Agente principal para modificar el diccionario
  static void guardarEmpleado(String nombre, String puesto, double salario) {
    Empleado nuevoEmpleado = Empleado(
      id: _siguienteId,
      nombre: nombre,
      puesto: puesto,
      salario: salario,
    );

    // Guardar en el diccionario usando el id como llave
    datosempleado[_siguienteId] = nuevoEmpleado;
    
    // Preparar el siguiente ID
    _siguienteId++;
  }
}
