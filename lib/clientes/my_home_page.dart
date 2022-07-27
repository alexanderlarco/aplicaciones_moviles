import 'package:flutter/material.dart';

import 'package:crud_customer/message_response.dart';
import 'package:crud_customer/modify_customer.dart';
import 'package:crud_customer/register_customer.dart';

class MyHomePage extends StatefulWidget {
  final String _title;
  // ignore: use_key_in_widget_constructors
  const MyHomePage(this._title);
  @override
  State<StatefulWidget> createState() => _MyHomePage();
}

class _MyHomePage extends State<MyHomePage> {
  List<Customer> customers = [

    Customer(name:'Jose', ci:'123', address:'Inca', telephone:'2364548', email:'jose@gmail.com',accountNumber:'2589',rol:'Cliente'),
    Customer(name:'Maria', ci:'456', address:'Villaflora', telephone:'216515', email:'maria@gmail.com',accountNumber:'7894',rol:'Cliente'),
    Customer(name:'Juan', ci:'789', address:'El valle', telephone:'6465454', email:'juan@gmail.com',accountNumber:'9632',rol:'Cliente'),
    Customer(name:'Rocio', ci:'112', address:'Cruz roja', telephone:'31486458', email:'rocio@gmail.com',accountNumber:'2587',rol:'Cliente')
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget._title),
      ),
      body: ListView.builder(
        itemCount: customers.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => ModifyCustomer(customers[index])))
                  .then((newCustomer) {
                if (newCustomer != null) {
                  setState(() {
                    customers.removeAt(index);

                    customers.insert(index, newCustomer);

                    messageResponse(
                        context, newCustomer.name + " a sido modificado...!");
                  });
                }
              });
            },
            onLongPress: () {
              removeCustomer(context, customers[index]);
            },
            title: Text(customers[index].name + " " + customers[index].ci+ " " + customers[index].address+ " " + customers[index].telephone),
            subtitle: Text(customers[index].email + " " + customers[index].accountNumber+ " " + customers[index].rol),
            leading: CircleAvatar(
              child: Text(customers[index].name.substring(0, 1)),
            ),
            trailing: const Icon(
              Icons.arrow_circle_right_outlined,
              color: Colors.purpleAccent,
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
                  context, MaterialPageRoute(builder: (_) => const RegisterCustomer()))
              .then((newCustomer) {
            if (newCustomer != null) {
              setState(() {
                customers.add(newCustomer);
                messageResponse(
                    context, newCustomer.name + " a sido guardado...!");
              });
            }
          });
        },
        tooltip: "Agregar Cliente",
        child: const Icon(Icons.add),
      ),
    );
  }

  removeCustomer(BuildContext context, Customer customer) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: const Text("Eliminar Cliente"),
              // ignore: prefer_interpolation_to_compose_strings
              content: Text("${"Esta seguro de eliminar a " + customer.name}?"),
              actions: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      customers.remove(customer);
                      Navigator.pop(context);
                    });
                  },
                  child: const Text(
                    "Eliminar",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Cancelar",
                    style: TextStyle(color: Colors.blue),
                  ),
                )
              ],
            ));
  }
}

class Customer {
  // ignore: prefer_typing_uninitialized_variables
  var name;
  // ignore: prefer_typing_uninitialized_variables
  var ci;
  // ignore: prefer_typing_uninitialized_variables
  var address;
  // ignore: prefer_typing_uninitialized_variables
  var telephone;
  // ignore: prefer_typing_uninitialized_variables
  var email;
  // ignore: prefer_typing_uninitialized_variables
  var accountNumber;
  // ignore: prefer_typing_uninitialized_variables
  var rol;

  Customer({this.name, this.ci, this.address, this.telephone, this.email, this.accountNumber, this.rol});
}