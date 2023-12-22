import 'package:flutter/material.dart';
import 'package:proyecto_final/application_layer/person.dart';
import 'package:proyecto_final/screens/cards_screen.dart';

AlertDialog showAlert(
    {required BuildContext context,
    required String title,
    required String subtitle,
    Function(Person, ActionsEnumCard)? accionPersona,
    Person? persona,
    ActionsEnumCard? accion}) {
  var alertDialog = AlertDialog(
    title: Text(title),
    content: Text(subtitle),
    actions: [
      TextButton(
        onPressed: () {
          Navigator.pop(
              context); // Cerrar el cuadro de diálogo sin realizar ninguna acción
        },
        child: const Text('No'),
      ),
      TextButton(
        onPressed: () {
          if (accionPersona != null && persona != null && accion != null) {
            accionPersona(persona, accion);
          }
          Navigator.pop(
              context); // Cerrar el cuadro de diálogo sin realizar ninguna acción
        },
        child: const Text('Si'),
      )
    ],
  );
  return alertDialog;
}
