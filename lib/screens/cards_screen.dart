import 'package:flutter/material.dart';
import 'package:proyecto_final/application_layer/custom_card.dart';
import 'package:proyecto_final/application_layer/person.dart';
import 'package:proyecto_final/provider/data_provider.dart';
import 'package:proyecto_final/screens/detail_screen.dart';

class CardsScreen extends StatelessWidget {
  const CardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ListScreen();
  }
}

final class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
/*final List<Person> people = [
    Person('Anderson', 'Ingeniero', 28),
    Person('Pancho', 'Desarrollador', 32),
    Person('Juan', 'QA', 21),
  ];*/

  final List<Person> people = [];

  void accionPerson(Person persona, ActionsEnumCard accion) {
    setState(() {
      switch (accion) {
        case ActionsEnumCard.insert:
          //people.add(persona);
          DBProvider.db.addPerson(persona);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
              content: Row(
                children: [
                  Icon(Icons.person),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text('Persona Creada'),
                ],
              ),
            ),
          );
          Navigator.pop(context);

          break;
        case ActionsEnumCard.delete:
          //people.remove(persona);
          DBProvider.db.deletePerson(persona.nui, persona);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.red,
              duration: Duration(seconds: 2),
              content: Row(
                children: [
                  Icon(Icons.delete),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text('Persona Eliminada'),
                ],
              ),
            ),
          );
          break;
        case ActionsEnumCard.update:
          //int index = people.indexWhere((p) => p.name == persona.name);
          //if (index != -1) {
          //people[index] = persona;
          DBProvider.db.updatePerson(persona.nui, persona);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.yellow,
              duration: Duration(seconds: 2),
              content: Row(
                children: [
                  Icon(Icons.update),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text('Persona Actualizada'),
                ],
              ),
            ),
          );
          Navigator.pop(context);
        //}
        default:
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tarjetas'),
      ),
      body: SafeArea(
          child: FutureBuilder(
              future: DBProvider.db.getAllPersons(),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Person>> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final persons = snapshot.data;
                if (persons == null || persons.isEmpty) {
                  return const Center(
                    child: Text('No existen personas registradas'),
                  );
                }

                return ListView.builder(
                  itemCount: persons.length,
                  itemBuilder: (context, index) =>
                      CustomCard(persons[index], accionPerson),
                );
              })),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Person personaNueva = Person(nui: '', name: '', cargo: '', age: 0);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (contextNew) => DetailsScreen(
                  personaNueva, accionPerson, ActionsEnumCard.insert),
            ),
          );
        },
        tooltip: 'Crear',
        child: const Icon(Icons.add),
      ),
    );
  }
}

enum ActionsEnumCard { delete, insert, update }
