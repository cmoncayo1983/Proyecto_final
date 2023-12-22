import 'package:flutter/material.dart';
import 'package:proyecto_final/application_layer/person.dart';
import 'package:proyecto_final/screens/cards_screen.dart';
import 'package:proyecto_final/application_layer/alerts.dart';
import 'package:proyecto_final/screens/detail_screen.dart';
import 'package:proyecto_final/screens/map_screen.dart';

class CustomCard extends StatefulWidget {
  final Person person;
  final Function(Person, ActionsEnumCard) accionListPerson;
  //DetailsScreen detailScreen;

  const CustomCard(this.person, this.accionListPerson, {super.key});

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  BoxDecoration _buildDecoration() {
    if (widget.person.foto != null) {
      return const BoxDecoration(
        color: Colors.blue,
        shape: BoxShape.circle,
        image: DecorationImage(
          fit: BoxFit.cover,
          //image: NetworkImage(widget.person.foto!),
          image: NetworkImage(
              'https://cdn.pixabay.com/photo/2015/03/04/22/35/avatar-659651_1280.png'),
        ),
      );
    } else {
      return const BoxDecoration(
        color: Colors.blue,
        shape: BoxShape.circle,
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(
              'https://cdn.pixabay.com/photo/2015/03/04/22/35/avatar-659651_1280.png'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Accede al provider desde cualquier parte de tu árbol de widgets
    return Dismissible(
      key: Key(widget.person.nui),
      onDismissed: (direction) {
        if (direction == DismissDirection.startToEnd) {
          widget.accionListPerson(widget.person, ActionsEnumCard.delete);
        } else if (direction == DismissDirection.endToStart) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailsScreen(
                widget.person,
                widget.accionListPerson,
                ActionsEnumCard.update,
              ),
            ),
          );
        }
      },
      child: Card(
        margin: const EdgeInsets.all(12.0),
        //color: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        shadowColor: Colors.black,
        elevation: 10,
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.blue,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.blueAccent,
                Colors.white70,
              ],
              stops: [0.0, 1.0],
            ),
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                offset: Offset(12.0, 12.0),
                blurRadius: 8.0,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      width: 100.0,
                      height: 100.0,
                      decoration: _buildDecoration(),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Text(widget.person.name)
                  ],
                ),
                const SizedBox(width: 15.00),
                Flexible(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Center(child: Text(widget.person.cargo)),
                      const SizedBox(height: 15.00),
                      Text('Edad: ${widget.person.age}'),
                      const SizedBox(height: 5.00),
                      Text(widget.person.nui),
                      const SizedBox(height: 20.00),
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MapScreen(widget.person),
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.house,
                          color: Colors.blueAccent,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return showAlert(
                                    context: context,
                                    title: 'Eliminar',
                                    subtitle:
                                        'Está seguro de eliminar la persona?',
                                    accionPersona: widget.accionListPerson,
                                    persona: widget.person,
                                    accion: ActionsEnumCard.delete);
                              },
                            );
                          },
                          icon: const Icon(
                            Icons.close,
                            color: Colors.red,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 55.0,
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailsScreen(
                                  widget.person,
                                  widget.accionListPerson,
                                  ActionsEnumCard.update,
                                ),
                              ),
                            );
                          },
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.green,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
