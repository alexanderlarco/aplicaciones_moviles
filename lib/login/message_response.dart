import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

messageResponse(BuildContext context, String name) {
  showDialog(
      context: context,
      builder: (_) => AlertDialog(
            title: const Text("Mensaje Informativo"),
            content: Text("El registro $name"),
          ));
}
