import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:marvels/states.dart';
import 'model.dart';

class MyNotifier extends ChangeNotifier{

    states state= states.Fetching;

    Future<List<Marvel>> fetchList() async{
        List<Marvel> marvelHeroesList= <Marvel>[];
        String data = await rootBundle.loadString('assets/json_files/marvel.json');
        var list =  json.decode(data)["marvels_heroes"] as List;
        marvelHeroesList = list.map<Marvel>((json) => Marvel.fromJson(json)).toList();
        state= states.Show;
        //notifyListeners();
       return marvelHeroesList;
    }

}