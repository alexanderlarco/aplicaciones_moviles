import 'package:crud_productos/my_home_page.dart';
import 'package:crud_productos/text_box.dart';
import 'package:flutter/material.dart';

class RegisterProduct extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RegisterProduct();
}

class _RegisterProduct extends State<RegisterProduct> {
  late TextEditingController controllerName;
  late TextEditingController controllerDescripcion;
  late TextEditingController controllerCantidad;

  @override
  void initState() {
    controllerName = new TextEditingController();
    controllerDescripcion = new TextEditingController();
    controllerCantidad = new TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("REGISTRAR PRODUCTOS"),
        ),
        body: ListView(
          children: [
            TextBox(controllerName, "Nombre"),
            TextBox(controllerDescripcion, "Descripcion"),
            TextBox(controllerCantidad, "Cantidad"),
            ElevatedButton(
                onPressed: () {
                  String name = controllerName.text;
                  String descripcion = controllerDescripcion.text;
                  String cantidad = controllerCantidad.text;

                  if (name.isNotEmpty &&
                      descripcion.isNotEmpty &&
                      cantidad.isNotEmpty) {
                    Navigator.pop(
                        context,
                        new Producto(
                            name: name,
                            descripcion: descripcion,
                            cantidad: cantidad));
                  }
                },
                child: Text("GUARDAR PRODUCTO")),
          ],
        ));
  }
}
