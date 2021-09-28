import 'package:flutter/material.dart';
import 'package:pizzeria/models/menu.dart';
import 'package:pizzeria/ui/pizza_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pizzéria',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Notre Pizzéria'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  String title;
  MyHomePage({Key? key, required this.title}) : super(key: key);

  var _menus = [
    Menu(1, 'Entrées', 'entrees.jpg', Colors.lightGreen),
    Menu(2, 'Pizzas', 'pizzas.jpg', Colors.redAccent),
    Menu(3, 'Desserts', 'desserts.png', Colors.brown),
    Menu(4, 'Boissons', 'boissons.jpg', Colors.lightBlue),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: _menus.length,
          itemBuilder: (context, index) => InkWell(
            onTap: (){
              switch (_menus[index].type){
                case 2:
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PizzaList()),
                  );
                  break;
              }
            },
            child: _buildRow(_menus[index]),
          ),
          itemExtent: 180,
        ),
      ),
    );
  }

  _buildRow(Menu menu){
    return Container(
      height: 180,
      decoration: BoxDecoration(
        color: menu.color,
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      margin: EdgeInsets.all(4.0),
      child: Column(
        children: <Widget>[
          Expanded(
            child: Image.asset(
              'assets/images/menus/${menu.image}',
              fit: BoxFit.fitWidth,
            ),
          ),
          Center(
            child : Text(
              menu.title,
              style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'Roboto',
              fontSize: 28,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

