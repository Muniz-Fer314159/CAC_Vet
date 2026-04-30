import 'package:flutter/material.dart';
import 'screens/login_page.dart';
import 'screens/cadastro_page.dart';
import 'screens/cadastro_cli_page.dart';
import 'screens/cadastro_ani_page.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'dart:io';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sistema Pet Shop',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginPage(),
        '/cadastroUsuario': (context) => const CadastroPage(),
        '/cadastroCliente': (context) => const CadastroClientePage(),
        '/cadastroAnimal': (context) => const CadastroAnimalPage(),
      },
    );
  }
}