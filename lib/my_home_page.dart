import 'package:crud_productos/message_response.dart';
import 'package:crud_productos/modyfy_product.dart';
import 'package:crud_productos/register_product.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  final String _title;
  MyHomePage(this._title);
  @override
  State<StatefulWidget> createState() => _MyHomePage();
}

class _MyHomePage extends State<MyHomePage> {
  List<Producto> productos = [
    Producto(name: 'C', descripcion: 'Camisa de hombre', cantidad: '1'),
    Producto(name: 'B', descripcion: 'Blusa de mujer', cantidad: '2'),
    Producto(name: 'P', descripcion: 'Pantalon de hombre', cantidad: '3'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget._title),
      ),
      body: ListView.builder(
        itemCount: productos.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => ModifyProduct(productos[index])))
                  .then((newProducto) {
                if (newProducto != null) {
                  setState(() {
                    productos.removeAt(index);

                    productos.insert(index, newProducto);
                    messageResponse(
                        context,
                        newProducto.name +
                            "   " +
                            "  A sido modificado con exito  ");
                  });
                }
              });
            },
            onLongPress: () {
              removeProducto(context, productos[index]);
            },
            title: Text(productos[index].name +
                " " +
                " " +
                " " +
                productos[index].descripcion),
            subtitle: Text(productos[index].cantidad),
            leading: CircleAvatar(
              child: Text(productos[index].name..substring(0, 1)),
            ),
            trailing: Icon(Icons.shopping_bag, color: Colors.black54),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
                  context, MaterialPageRoute(builder: (_) => RegisterProduct()))
              .then((newProducto) {
            if (newProducto != null) {
              setState(() {
                productos.add(newProducto);
                messageResponse(
                    context, newProducto.name + " A sido guardado con exito ");
              });
            }
          });
        },
        tooltip: "AGREGAR PRODUCTO",
        child: Icon(Icons.add),
      ),
    );
  }

  removeProducto(BuildContext context, Producto producto) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text("ELIMINAR PRODUCTO"),
              content:
                  Text("ESTA SEGURO DE ELIMINAR" + "  " + "  " + producto.name),
              actions: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      this.productos.remove(producto);
                      Navigator.pop(context);
                    });
                  },
                  child: Text(
                    "Eliminar",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Cancelar",
                    style: TextStyle(color: Colors.blue),
                  ),
                )
              ],
            ));
  }
}

class Producto {
  var name;
  var descripcion;
  var cantidad;

  Producto({this.name, this.descripcion, this.cantidad});
}
