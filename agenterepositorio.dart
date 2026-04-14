import 'dart:io';

/// Agente Repositorio GitHub
/// Script interactivo para inicializar, realizar commits y subir proyectos a GitHub.
/// Uso desde terminal: dart agenterepositorio.dart

void main() async {
  print('\n=============================================');
  print('🤖 AGENTE REPOSITORIO GITHUB INICIADO 🚀');
  print('=============================================');

  // 1. Verificar que Git esté instalado en el sistema
  if (!await _verificarGit()) {
    return;
  }

  // 2. Verificar o inicializar el repositorio local (.git)
  bool gitIniciado = Directory('.git').existsSync();
  if (!gitIniciado) {
    print('\n[+] Inicializando repositorio Git local...');
    await _ejecutarComando('git', ['init']);
  } else {
    print('\n[+] Repositorio Git detectado en el directorio actual (✅).');
  }

  // >>> REPARACIÓN: Verificar identidad de Git para evitar error de author <<<
  if (!await _verificarEIdentidadGit()) {
    return;
  }

  // 3. Obtener o solicitar la URL del repositorio remoto (Origin)
  String? urlRemoto = _obtenerRemotoOrigin();
  
  if (urlRemoto == null || urlRemoto.isEmpty) {
    print('\n[?] No se detectó un repositorio remoto.');
    print('    Por favor, ingresa el enlace de tu repositorio de GitHub.');
    print('    (Ejemplo: https://github.com/tuUsuario/tuRepositorio.git)');
    stdout.write('🔗 Link GitHub: ');
    
    urlRemoto = stdin.readLineSync()?.trim();

    if (urlRemoto != null && urlRemoto.isNotEmpty) {
      await _ejecutarComando('git', ['remote', 'add', 'origin', urlRemoto]);
      print('    > Remoto "origin" enlazado correctamente al proyecto.');
    } else {
      print('❌ ERROR: Link inválido. Saliendo del agente...');
      return;
    }
  } else {
    print('\n[+] Enlace de repositorio actual configurado: $urlRemoto');
  }

  // 4. Agregar todo al Stage (git add .)
  print('\n[+] Preparando los archivos (git add .)...');
  await _ejecutarComando('git', ['add', '.']);

  // 5. Solicitar el mensaje del Commit
  print('\n[?] Ingresa el mensaje para este COMMIT:');
  stdout.write('📝 Mensaje: ');
  String? mensajeCommit = stdin.readLineSync()?.trim();
  
  if (mensajeCommit == null || mensajeCommit.isEmpty) {
    mensajeCommit = 'Actualización automática vía Agente Dart';
    print('    > Se usará el mensaje por defecto: "$mensajeCommit"');
  }

  // Ejecutar Commit y capturar resultado
  var resCommit = await Process.run('git', ['commit', '-m', mensajeCommit]);
  if (resCommit.stdout.toString().contains('nothing to commit')) {
    print('    > No hay cambios nuevos para confirmar (nada que hacer en este commit).');
  } else if (resCommit.exitCode != 0) {
    print('❌ ERROR al hacer commit:');
    print(resCommit.stderr);
    return; // Detenemos aquí si falla el commit (para no intentar hacer Push invisible)
  } else {
    print('    > Commit "$mensajeCommit" (✅).');
  }

  // 6. Solicitar y configurar la rama (Branch) destino
  print('\n[?] ¿A qué rama deseas subir los cambios?');
  stdout.write('🌿 Nombre de la rama [Presiona Enter para default: "main"]: ');
  String? rama = stdin.readLineSync()?.trim();
  
  if (rama == null || rama.isEmpty) {
    rama = 'main';
  }

  // Forzar/Asegurar la rama actual
  await _ejecutarComando('git', ['branch', '-M', rama]);

  // 7. PUSH: Subiendo al repositorio remoto
  print('\n🚀 Subiendo los datos a GitHub -> Rama ["$rama"]...');
  print('⏳ Por favor, espera...');
  
  var resPush = await Process.run('git', ['push', '-u', 'origin', rama]);
  
  if (resPush.exitCode == 0) {
    print('\n✅ EL PROYECTO SE HA GUARDADO Y SUBIDO CON ÉXITO A GITHUB.');
  } else {
    print('\n❌ Ocurrió un error finalizando la subida (push):');
    print(resPush.stderr.toString().trim());
    if (resPush.stderr.toString().contains('Logon failed') || resPush.stderr.toString().contains('Authentication failed')) {
         print('\n💡 TIP: Parece un error de credenciales. Asegúrate de estar validado en GitHub en este equipo.');
    }
  }
  
  print('=============================================\n');
}

/// Funciones Auxiliares

// Averigua si Git está instalado globalmente
Future<bool> _verificarGit() async {
  try {
    var result = await Process.run('git', ['--version']);
    if (result.exitCode == 0) {
       print('[+] Git está instalado: ${result.stdout.toString().trim()}');
       return true;
    }
  } catch (e) {
    print('❌ ERROR GRAVE: Git no está instalado o no detectado.');
    return false;
  }
  return false;
}

// Verifica si la configuración "user.name" y "user.email" existen. De lo contrario, las pide interactivo.
Future<bool> _verificarEIdentidadGit() async {
  var resName = await Process.run('git', ['config', 'user.name']);
  var resEmail = await Process.run('git', ['config', 'user.email']);
  
  if (resName.stdout.toString().trim().isEmpty || resEmail.stdout.toString().trim().isEmpty) {
     print('\n[!] Git necesita saber quién eres para realizar un Commit (Identidad vacía en esta PC).');
     stdout.write('👤 Ingresa tu nombre (Ej. Jaziel): ');
     String? nombre = stdin.readLineSync()?.trim();
     
     stdout.write('📧 Ingresa tu correo (Ej. jaziel@ejemplo.com): ');
     String? correo = stdin.readLineSync()?.trim();
     
     if(nombre != null && nombre.isNotEmpty && correo != null && correo.isNotEmpty) {
        // Configuramos la identidad localmente en este entorno para evitar el error Author Identity Unknown
        await _ejecutarComando('git', ['config', 'user.name', nombre]);
        await _ejecutarComando('git', ['config', 'user.email', correo]);
        print('    > [OK] Identidad de Git guardada exitosamente.');
     } else {
        print('❌ ERROR: Nombre y correo son obligatorios para usar Git.');
        return false;
     }
  }
  return true;
}

String? _obtenerRemotoOrigin() {
  try {
    var resultado = Process.runSync('git', ['remote', 'get-url', 'origin']);
    if (resultado.exitCode == 0) return resultado.stdout.toString().trim();
  } catch (e) {}
  return null;
}

Future<void> _ejecutarComando(String comando, List<String> argumentos) async {
  try {
    var resultado = await Process.run(comando, argumentos);
    if (resultado.exitCode != 0 && !resultado.stderr.toString().contains('nothing to commit')) {
      print('    [!] Advertencia en "$comando ${argumentos.join(' ')}":');
      print('        ${resultado.stderr.toString().trim()}');
    }
  } catch (e) {}
}
