import 'package:pizzeria/models/pizza.dart';

class PizzaData{
  static List<Pizza> buildList(){
    List<Pizza> list = [];
    list.add(Pizza(1, 'Barbecue', 'La garniture', 'pizza-bbq.jpeg', 8));
    list.add(Pizza(2, 'Hawaii', 'La garniture', 'pizza-hawaii.jpeg', 9));
    list.add(Pizza(3, 'Epinards', 'La garniture', 'pizza-spinach.jpeg', 7));
    list.add(Pizza(4, 'Végétarienne', 'La garniture', 'pizza-vegetable.jpeg', 10));
    return list;
  }
}
