import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pizzeria/models/cart.dart';

class Panier extends StatefulWidget {
  final Cart _cart;
  const Panier(this._cart, {Key? key}) : super(key: key);

  @override
  _PanierState createState() => _PanierState();
}

class _PanierState extends State<Panier> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mon Panier'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget._cart.totalItems(),
              itemBuilder: (context, index) => _buildItem(widget._cart.getCartItem(index)),
              itemExtent: 100,
              padding: EdgeInsets.all(4.0),
            ),
          ),
          Row(
            children: [
              Text('Total : '),
              Text(widget._cart.totalPrice() + '€'),
            ],
          ),
          Container(
            child: ElevatedButton(
              child: Text('Valider'),
              onPressed: (){
                print('Valider');
              },
            )
          ),
        ],
      ),
    );
  }
  Widget _buildItem(CartItem cartItem) {
    return Row(
      children: [
        Image.asset('assets/images/pizzas/${cartItem.pizza.image}', height: 80),
        Padding(
          padding: EdgeInsets.only(left: 4.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Pizza '+cartItem.pizza.title),
              Text('Prix unitaire : '+cartItem.pizza.price.toString()+'€'),
              Text('Sous total : '+cartItem.pizza.total.toString()+'€'),
            ],
          ),
        ),
        Row(
          children: [
            Text('-'),
            Text('1'),
            Text('+'),
          ],
        )
      ],
    );
  }
}
