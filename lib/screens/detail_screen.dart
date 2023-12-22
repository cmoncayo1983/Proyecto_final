import 'package:flutter/material.dart';
import 'package:proyecto_final/application_layer/person.dart';
import 'package:proyecto_final/application_layer/alerts.dart';
import 'package:proyecto_final/screens/cards_screen.dart';
//import 'package:widgets/ScreenTarjeta.dart';
//import 'alertas.dart';

class DetailsScreen extends StatefulWidget {
  final Person _person;
  final Function(Person, ActionsEnumCard) accionListPerson;
  final ActionsEnumCard accion;

  const DetailsScreen(this._person, this.accionListPerson, this.accion,
      {super.key});

  @override
  State<DetailsScreen> createState() => DetailsScreenState();
}

class DetailsScreenState extends State<DetailsScreen> {
  TextEditingController controladorNui = TextEditingController();
  TextEditingController controladorNombre = TextEditingController();
  TextEditingController controladorCargo = TextEditingController();
  TextEditingController controladorEdad = TextEditingController();
  TextEditingController controladorFoto = TextEditingController();
  TextEditingController controladorDireccion = TextEditingController();
  DateTime date1 = DateTime.now();
  TimeOfDay time1 = TimeOfDay.now();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  /*void _submit() {
    print("Submit button pressed");
    validForm();
  }*/

  bool validForm() {
    final form = _formKey.currentState;
    if (form == null) {
      return false;
    }
    return form.validate();
  }

  selectDate(BuildContext context) async {
    var picked = await showDatePicker(
        context: context,
        initialDate: date1,
        firstDate: DateTime(2020),
        lastDate: DateTime(2025),
        confirmText: 'Seleccionar',
        cancelText: 'Cancelar',
        selectableDayPredicate: (val) =>
            val.weekday == 5 || val.weekday == 6 ? false : true);

    if (picked != null && picked != date1) {
      setState(() {
        date1 = picked;
      });
    }
  }

  selectHour(BuildContext context) async {
    var picked = await showTimePicker(
      context: context,
      initialTime: time1,
    );

    if (picked != null && picked != time1) {
      setState(() {
        time1 = picked;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    controladorNui.text = widget._person.nui;
    controladorNombre.text = widget._person.name;
    controladorCargo.text = widget._person.cargo;
    controladorEdad.text = widget._person.age.toString();

    if (widget._person.direccion != null) {
      controladorDireccion.text = widget._person.direccion!;
    } else {
      controladorDireccion.text = '-0,-0';
    }
    /*if (widget._person.foto != null) {
      controladorFoto.text = widget._person.foto!;
    } else {
      controladorFoto.text =
          'https://cdn.pixabay.com/photo/2015/03/04/22/35/avatar-659651_1280.png';
    }*/
    controladorFoto.text =
        'https://cdn.pixabay.com/photo/2015/03/04/22/35/avatar-659651_1280.png';
    //'https://cdn.pixabay.com/photo/2015/03/04/22/35/avatar-659651_1280.png'
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles'),
      ),
      body: Form(
        key: _formKey,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Center(
              child: ListView(
                children: [
                  Container(
                    width: 100.0,
                    height: 150.0,
                    margin: const EdgeInsets.only(
                      top: 15.0,
                      left: 10.0,
                      right: 10.0,
                      bottom: 15.0,
                    ),
                    child: Image.network(
                      controladorFoto.text,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                  /* SizedBox(
                    height: 30.0,
                    width: 220.0,
                    child: TextField(
                      controller: controladorFoto,
                      textAlign: TextAlign.center,
                      //decoration: const InputDecoration(labelText: 'Nombre:'),
                      decoration: const InputDecoration(
                        //icon: Icon(Icons.person),
                        labelText: 'URL Imagen:',
                        // border: InputBorder.none,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(7.0),
                          ),
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                      ),
                    ),
                  ), */
                  SizedBox(
                    height: 30.0,
                    width: 220.0,
                    child: TextFormField(
                      controller: controladorDireccion,
                      textAlign: TextAlign.center,
                      //decoration: const InputDecoration(labelText: 'Nombre:'),
                      decoration: const InputDecoration(
                        //icon: Icon(Icons.person),
                        labelText: 'Ubicacion:',
                        // border: InputBorder.none,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(7.0),
                          ),
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  SizedBox(
                    height: 30.0,
                    width: 220.0,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: controladorNui,
                      enabled: widget._person.nui.isNotEmpty ? false : true,
                      textAlign: TextAlign.center,
                      //decoration: const InputDecoration(labelText: 'Nombre:'),
                      decoration: const InputDecoration(
                        //icon: Icon(Icons.person),
                        labelText: 'NUI:',
                        // border: InputBorder.none,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(7.0),
                          ),
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                      ),
                      validator: (value) =>
                          value != null && value.isEmpty ? 'Requerido' : null,
                      //onSaved: (value) => print('value'),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  SizedBox(
                    height: 30.0,
                    width: 220.0,
                    child: TextFormField(
                      controller: controladorNombre,
                      textAlign: TextAlign.center,
                      //decoration: const InputDecoration(labelText: 'Nombre:'),
                      decoration: const InputDecoration(
                        //icon: Icon(Icons.person),
                        labelText: 'Nombre:',
                        // border: InputBorder.none,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(7.0),
                          ),
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                      ),
                      validator: (value) =>
                          value != null && value.isEmpty ? 'Requerido' : null,
                      //onSaved: (value) => print('value'),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  SizedBox(
                    height: 30.0,
                    width: 220.0,
                    child: TextFormField(
                      controller: controladorCargo,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        //icon: Icon(Icons.person),
                        labelText: 'Cargo:',
                        // border: InputBorder.none,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(7.0),
                          ),
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                      ),
                    ),
                  ),
                  //Text(widget._person.description),
                  const SizedBox(
                    height: 20.0,
                  ),
                  SizedBox(
                    height: 30.0,
                    width: 220.0,
                    child: TextFormField(
                      controller: controladorEdad,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        //icon: Icon(Icons.person),
                        labelText: 'Edad:',
                        // border: InputBorder.none,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(7.0),
                          ),
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                      ),
                    ),
                  ),
                  //Text(widget._person.description),
                  /* const SizedBox(
                    height: 20.0,
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Fecha Nacimiento: '),
                        Text('${date1.day}-${date1.month}-${date1.year}'),
                        IconButton(
                          onPressed: () {
                            selectDate(context);
                          },
                          icon: const Icon(Icons.date_range),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Horario de Ingreso: '),
                      Text('${time1.hour}:${time1.minute}'),
                      IconButton(
                        onPressed: () {
                          selectHour(context);
                        },
                        icon: const Icon(Icons.date_range),
                      ),
                    ],
                  ), */

                  const SizedBox(
                    height: 20.0,
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              Navigator.pop(context);
                            });
                          },
                          child: const Text('Cancelar'),
                        ),
                        const SizedBox(
                          width: 20.0,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            widget._person.nui = controladorNui.text;
                            widget._person.name = controladorNombre.text;
                            widget._person.cargo = controladorCargo.text;
                            widget._person.age =
                                int.parse(controladorEdad.text);
                            widget._person.foto = controladorFoto.text;
                            widget._person.direccion =
                                controladorDireccion.text;
                            if (validForm()) {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return showAlert(
                                      context: context,
                                      title: 'Guardar',
                                      subtitle: 'Esta seguro de guardar?',
                                      accionPersona: widget.accionListPerson,
                                      persona: widget._person,
                                      accion: widget.accion);
                                },
                              );
                            }
                          },
                          child: const Text('Guardar'),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
