import 'package:flutter/material.dart';

import 'package:crud_customer/my_home_page.dart';
import 'package:crud_customer/text_box.dart';

class ModifyCustomer extends StatefulWidget {
  final Customer _customer;
  // ignore: use_key_in_widget_constructors
  const ModifyCustomer(this._customer);
  @override
  State<StatefulWidget> createState() => _ModifyCustomer();
}

class _ModifyCustomer extends State<ModifyCustomer> {

  late TextEditingController controllerName;
  late TextEditingController controllerCi;
  late TextEditingController controllerAddress;
  late TextEditingController controllerTelephone;
  late TextEditingController controllerEmail;
  late TextEditingController controllerAccountNumber;
  late TextEditingController controllerRol;

  @override
  void initState() {
    Customer c = widget._customer;
    controllerName = TextEditingController(text: c.name);
    controllerCi = TextEditingController(text: c.ci);
    controllerAddress = TextEditingController(text: c.address);
    controllerTelephone = TextEditingController(text: c.telephone);
    controllerEmail = TextEditingController(text: c.email);
    controllerAccountNumber = TextEditingController(text: c.accountNumber);
    controllerRol = TextEditingController(text: c.rol);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Modificar Cliente"),
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
      ),
    );
  }
}