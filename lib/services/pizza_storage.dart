import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:pizzeria/models/pizza.dart';

class PizzaStorage {
  Future<File> get _localFile async {
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path;
    return File('$path/pizza.json');
  }

  Future<List<Pizza>> load() async {
    List<Pizza> result = [];
    try {
      final file = await _localFile;
      final contents = await file.readAsString();
      for(final value in json.decode(contents)) {
        result.add(Pizza.fromJson(value));
      }
      return result;
    } catch(e){
      print('ERROR=$e');
    }
    return [];
  }

  Future<void> save(List<Pizza> liste) async {
    try {
      final file = await _localFile;
      String contents = json.encode(liste);
      file.writeAsString(contents);
    } catch(e) {
      print('ERROR=$e');
    }
  }
}