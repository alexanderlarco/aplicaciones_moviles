import 'package:crud_productos/my_home_page.dart';
import 'package:flutter/material.dart';
import 'package:crud_productos/text_box.dart';

class ModifyProduct extends StatefulWidget {
  final Producto _producto;
  ModifyProduct(this._producto);
  @override
  State<StatefulWidget> createState() => _ModifyProduct();
}

class _ModifyProduct extends State<ModifyProduct> {
  late TextEditingController controllerName;
  late TextEditingController controllerDescripcion;
  late TextEditingController controllerCantidad;

  @override
  void initState() {
    Producto p = widget._producto;
    controllerName = new TextEditingController(text: p.name);
    controllerDescripcion = new TextEditingController(text: p.descripcion);
    controllerCantidad = new TextEditingController(text: p.cantidad);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // ignore: prefer_const_constructors
        title: Text(" MODIFICAR PRODUCTO "),
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
      ),
    );
  }
}
