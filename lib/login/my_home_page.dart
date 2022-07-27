import "package:flutter/material.dart";
import 'package:registro/modify.dart';
import 'package:registro/register.dart';

import 'message_response.dart';

class MyHomePage extends StatefulWidget {
  final String _title;
  MyHomePage(this._title);
  @override
  State<StatefulWidget> createState() => _MyHomePage();
}

class _MyHomePage extends State<MyHomePage> {
  List<Client> clients = [
    Client(
        name: "Alan",
        phone: "0987654321",
        email: "alan@gmail.com",
        password: "123"),
    Client(
        name: "Cris",
        phone: "0988854321",
        email: "cirs@gmail.com",
        password: "193"),
    Client(
        name: "Vanessa",
        phone: "0987654398",
        email: "vane@gmail.com",
        password: "113"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget._title),
      ),
      body: ListView.builder(
          itemCount: clients.length,
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () {
                Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => ModifyRegister(clients[index])))
                    .then((newRegister) {
                  if (newRegister != null) {
                    setState(() {
                      clients.removeAt(index);

                      clients.insert(index, newRegister);
                      messageResponse(
                          context, newRegister.name + " ha sido modificado");
                    });
                  }
                });
              },
              onLongPress: () {
                removeClient(context, clients[index]);
              },
              title: Text(clients[index].name),
              subtitle: Text(clients[index].phone),
              leading: CircleAvatar(
                child: Text(clients[index].name..substring(0, 1)),
              ),
              trailing: const Icon(Icons.call, color: Colors.red),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => Register()))
              .then((newRegister) {
            if (newRegister != null) {
              setState(() {
                clients.add(newRegister);
                messageResponse(
                    context, newRegister.name + " ha sido guardado");
              });
            }
          });
        },
        tooltip: "Agregar Registro",
        child: const Icon(Icons.add),
      ),
    );
  }

  removeClient(BuildContext context, Client client) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: const Text("Eliminar registro"),
              content: Text("¿Está seguro de eliminar a " + client.name + "?"),
              actions: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      clients.remove(client);
                      Navigator.pop(context);
                    });
                  },
                  child: const Text(
                    "Eliminar",
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Cancelar",
                      style: TextStyle(color: Colors.blue),
                    ))
              ],
            ));
  }
}

class Client {
  var name;
  var phone;
  var email;
  var password;

  Client({this.name, this.phone, this.email, this.password});
}
