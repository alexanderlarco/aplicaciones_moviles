import 'package:crud_customer/my_home_page.dart';
import 'package:crud_customer/text_box.dart';
import 'package:flutter/material.dart';

class RegisterCustomer extends StatefulWidget {
  const RegisterCustomer({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RegisterCustomer();
}

class _RegisterCustomer extends State<RegisterCustomer> {

  late TextEditingController controllerName;
  late TextEditingController controllerCi;
  late TextEditingController controllerAddress;
  late TextEditingController controllerTelephone;
  late TextEditingController controllerEmail;
  late TextEditingController controllerAccountNumber;
  late TextEditingController controllerRol;


  @override
  void initState() {

    controllerName = TextEditingController();
    controllerCi = TextEditingController();
    controllerAddress = TextEditingController();
    controllerTelephone = TextEditingController();
    controllerEmail = TextEditingController();
    controllerAccountNumber = TextEditingController();
    controllerRol = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Registrar Cliente"),
        ),
        body: ListView(
          children: [

            TextBox (controllerName, "Nombre"),
            TextBox (controllerCi, "Identificacion"),
            TextBox (controllerAddress, "Dirección"),
            TextBox (controllerTelephone, "Telefono"),
            TextBox (controllerEmail, "Correo"),
            TextBox (controllerAccountNumber, "Numero de cuenta"),
            TextBox (controllerRol, "Rol"),
            ElevatedButton(
                onPressed: () {
                  String name = controllerName.text;
                  String ci = controllerCi.text;
                  String address = controllerAddress.text;
                  String telephone = controllerTelephone.text;
                  String email = controllerEmail.text;
                  String accountNumber = controllerAccountNumber.text;
                  String rol = controllerRol.text;

                  if (name.isNotEmpty &&
                      ci.isNotEmpty &&
                      address.isNotEmpty &&
                      telephone.isNotEmpty&&
                      email.isNotEmpty&&
                      accountNumber.isNotEmpty&&
                      rol.isNotEmpty) {
                    Navigator.pop(context,
                        Customer(name: name, ci: ci, address: address, telephone: telephone, email: email, accountNumber: accountNumber, rol: rol));
                  }
                },
                child: const Text("Guardar Cliente")),
          ],
        ));
  }
}