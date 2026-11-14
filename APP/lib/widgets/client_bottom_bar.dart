import 'package:flutter/material.dart';
import '../app_theme.dart';
import '../screens/services_screen.dart';
import '../screens/appointments_screen.dart';
import '../screens/login_screen.dart';

class ClientBottomBar extends StatelessWidget {
  final int currentIndex;

  const ClientBottomBar({
    super.key,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      selectedItemColor: primaryColor,

      onTap: (index) {
        if (index == currentIndex) {
          return;
        }

        if (index == 0) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => const ServicesScreen(),
            ),
          );
        }

        if (index == 1) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => const AppointmentsScreen(),
            ),
          );
        }

        if (index == 2) {
          showDialog(
            context: context,
            builder: (dialogContext) {
              return AlertDialog(
                title: const Text('Mi perfil'),

                content: const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      radius: 35,
                      backgroundColor: primaryColor,
                      child: Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),

                    SizedBox(height: 15),

                    Text(
                      'Juan Pérez',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),

                    Text('juan@email.com'),

                    Text('+57 300 000 0000'),
                  ],
                ),

                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(dialogContext);
                    },
                    child: const Text('Cerrar'),
                  ),

                  TextButton(
                    onPressed: () {
                      Navigator.pop(dialogContext);

                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const LoginScreen(),
                        ),
                        (_) => false,
                      );
                    },
                    child: const Text(
                      'Cerrar sesión',
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        }
      },

      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Inicio',
        ),

        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_month),
          label: 'Mis citas',
        ),

        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Perfil',
        ),
      ],
    );
  }
}