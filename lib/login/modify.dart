import 'package:flutter/material.dart';
import 'package:registro/my_home_page.dart';
import 'package:registro/text_box.dart';

class ModifyRegister extends StatefulWidget {
  final Client _client;
  ModifyRegister(this._client);
  @override
  State<StatefulWidget> createState() => _ModifyRegister();
}

class _ModifyRegister extends State<ModifyRegister> {
  late TextEditingController controllerName;
  late TextEditingController controllerPhone;
  late TextEditingController controllerEmail;
  late TextEditingController controllerPassword;

  @override
  void initState() {
    Client c = widget._client;
    controllerName = TextEditingController(text: c.name);
    controllerPhone = TextEditingController(text: c.phone);
    controllerEmail = TextEditingController(text: c.email);
    controllerPassword = TextEditingController(text: c.password);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Modificar registro"),
        ),
        body: ListView(
          children: [
            TextBox(controllerName, "Nombre"),
            TextBox(controllerPhone, "Telefono"),
            TextBox(controllerEmail, "Correo"),
            TextBox(controllerPassword, "Contraseña"),
            ElevatedButton(
                onPressed: () {
                  String name = controllerName.text;
                  String phone = controllerPhone.text;
                  String email = controllerEmail.text;
                  String password = controllerPassword.text;

                  if (name.isNotEmpty &&
                      phone.isNotEmpty &&
                      email.isNotEmpty &&
                      password.isNotEmpty) {
                    Navigator.pop(
                        context,
                        Client(
                            name: name,
                            phone: phone,
                            email: email,
                            password: password));
                  }
                },
                child: const Text("Guardar registro")),
          ],
        ));
  }
}
