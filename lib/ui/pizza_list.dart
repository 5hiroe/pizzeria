import 'package:flutter/material.dart';
import 'package:pizzeria/models/cart.dart';
import 'package:pizzeria/models/pizza.dart';
import 'package:pizzeria/models/pizza_data.dart';
import 'package:pizzeria/services/pizza_storage.dart';
import 'package:pizzeria/services/pizzeria_service.dart';
import 'package:pizzeria/ui/pizza_details.dart';
import 'package:pizzeria/ui/share/appbar_widget.dart';
import 'package:pizzeria/ui/share/buy_button_widget.dart';

class PizzaList extends StatefulWidget {
  final Cart _cart;
  const PizzaList(this._cart, {Key? key}) : super(key: key);

  @override
  _PizzaListState createState() => _PizzaListState();
}

class _PizzaListState extends State<PizzaList> {

  late Future<List<Pizza>> _pizzas;
  PizzeriaService _service = PizzeriaService();

  @override
  void initState() {
    super.initState();

    var storage = PizzaStorage();
    storage.load().then((value) {
      setState(() {
        _pizzas = value;
        if (value.isEmpty) {
          print('DEBUG no json file');
          storage.save(PizzaData.buildList());
        }
      });
    });
    int _nbItemsCart = widget._cart.totalItems();
  }

  @override
  void dispose() {
    var storage = PizzaStorage();
    storage.save(_pizzas);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget('Nos Pizzas', widget._cart),
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: _pizzas.length,
        itemBuilder: (context, index) {
          return _buildRow(_pizzas[index], context);
        },
      ),
    );
  }


  _buildRow(Pizza pizza, BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(10.0), top: Radius.circular(2.0)
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PizzaDetails(pizza, widget._cart),
                ),
              );
            },
            child: _buildPizzaDetails(pizza, context),
          ),
          BuyButtonWidget(pizza, widget._cart),
        ],
      ),
    );
  }

  _buildPizzaDetails(Pizza pizza, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: Text(pizza.title),
          subtitle: Text(pizza.garniture),
          leading: Icon(Icons.local_pizza),
        ),
        Image.asset(
          'assets/images/pizzas/${pizza.image}',
          height: 120,
          width: MediaQuery
              .of(context)
              .size
              .width,
          fit: BoxFit.fitWidth,
        ),
        Container(
          padding: const EdgeInsets.all(4.0),
          child: Text(pizza.garniture),
        )
      ],
    );
  }
}