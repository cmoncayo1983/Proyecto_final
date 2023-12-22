import 'package:flutter/material.dart';
import 'package:proyecto_final/screens/cards_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      /* drawer: Drawer(
        child: ListView(
          //padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Opciones',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.card_membership),
              title: const Text('Tarjetas'),
              onTap: () {
                // Acción al hacer clic en Página 1
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CardsScreen(),
                  ),
                ); // Cerrar el menú
                // Puedes agregar lógica para navegar a la página correspondiente
              },
            ),
            ListTile(
              title: const Text('Página 2'),
              onTap: () {
                // Acción al hacer clic en Página 2
                Navigator.pop(context); // Cerrar el menú
                // Puedes agregar lógica para navegar a la página correspondiente
              },
            ),
          ],
        ),
      ), */
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              '¡Hola, bienvenido!',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CardsScreen(),
                  ),
                );
              },
              child: const Text('Iniciar'),
            ),
          ],
        ),
      ),
    );
  }
}
