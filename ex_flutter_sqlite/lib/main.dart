// ignore_for_file: avoid_print
import 'package:ex_flutter_sqlite/database_helper.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SQFlite Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  // referencia nossa classe single para gerenciar o banco de dados
  final dbHelper = DatabaseHelper.instance;

  MyHomePage({super.key});

  // layout da homepage
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exemplo de CRUD básico'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              child: const Text(
                'Inserir dados',
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () {
                _inserir();
              },
            ),
            ElevatedButton(
              child: const Text(
                'Consultar dados',
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () {
                _consultar();
              },
            ),
            ElevatedButton(
              child: const Text(
                'Atualizar dados',
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () {
                _atualizar();
              },
            ),
            ElevatedButton(
              child: const Text(
                'Deletar dados',
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () {
                _deletar();
              },
            ),
          ],
        ),
      ),
    );
  }

  // Button onPressed methods
  void _inserir() async {
    // linha para inserir
    Map<String, dynamic> row = {
      DatabaseHelper.columnNome: 'Wilson',
      DatabaseHelper.columnIdade: 50
    };
    final id = await dbHelper.insert(row);
    print('linha inserida id: $id');
  }

  void _consultar() async {
    final todasLinhas = await dbHelper.queryAllRows();
    print('Consulta todas as linhas:');
    for (var row in todasLinhas) {
      print(row);
    }
  }

  void _atualizar() async {
    // linha para atualizar
    Map<String, dynamic> row = {
      DatabaseHelper.columnId: 1,
      DatabaseHelper.columnNome: 'Maria',
      DatabaseHelper.columnIdade: 32
    };
    final linhasAfetadas = await dbHelper.update(row);
    print('atualizadas $linhasAfetadas linha(s)');
  }

  void _deletar() async {
    // Assumindo que o numero de linhas é o id para a última linha
    final id = await dbHelper.queryRowCount();
    final linhaDeletada = await dbHelper.delete(id!);
    print('Deletada(s) $linhaDeletada linha(s): linha $id');
  }
}
