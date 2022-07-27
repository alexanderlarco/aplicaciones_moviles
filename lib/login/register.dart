import 'package:flutter/material.dart';
import 'package:registro/my_home_page.dart';
import 'package:registro/text_box.dart';

class Register extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Register();
}

class _Register extends State<Register> {
  late TextEditingController controllerName;
  late TextEditingController controllerPhone;
  late TextEditingController controllerEmail;
  late TextEditingController controllerPassword;

  @override
  void initState() {
    controllerName = TextEditingController();
    controllerPhone = TextEditingController();
    controllerEmail = TextEditingController();
    controllerPassword = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Registro"),
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
