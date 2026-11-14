import 'package:flutter/material.dart';

import '../app_theme.dart';
import '../data/app_data.dart';
import 'admin_calendar_screen.dart';
import 'admin_services_screen.dart';
import 'admin_appointments_screen.dart';
import 'barbers_screen.dart';
import 'login_screen.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  Widget statistic(
    String number,
    String text,
    IconData icon,
  ) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 4,
        ),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: lightBackground,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: primaryColor,
            ),
            const SizedBox(height: 5),
            Text(
              number,
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w900,
                color: primaryColor,
              ),
            ),
            Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget reservation(
    Map<String, String> appointment,
  ) {
    return Card(
      color: lightBackground,
      elevation: 0,
      child: ListTile(
        leading: const CircleAvatar(
          backgroundColor: primaryColor,
          child: Icon(
            Icons.person,
            color: Colors.white,
          ),
        ),
        title: Text(
          appointment['client'] ?? 'Cliente',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          '${appointment['service']} · ${appointment['time']}',
        ),
        trailing: statusChip(
          appointment['status'] ?? '',
        ),
      ),
    );
  }

  Widget actionButton({
    required BuildContext context,
    required IconData icon,
    required String text,
    required Widget screen,
  }) {
    return ElevatedButton.icon(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => screen,
          ),
        );
      },
      icon: Icon(icon),
      label: Text(text),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'AgendaX',
          style: TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.w900,
          ),
        ),
        actions: [
          IconButton(
            tooltip: 'Cerrar sesión',
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (_) => const LoginScreen(),
                ),
                (_) => false,
              );
            },
            icon: const Icon(
              Icons.logout,
            ),
          ),
        ],
      ),

      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Panel Administrativo',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w900,
            ),
          ),

          const Text(
            'Control general de Delux Barber',
            style: TextStyle(
              color: Colors.black54,
            ),
          ),

          const SizedBox(height: 25),

          const Text(
            'Resumen de hoy',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              statistic(
                '${appointments.length}',
                'Citas',
                Icons.calendar_today,
              ),
              statistic(
                '3',
                'Espacios libres',
                Icons.schedule,
              ),
              statistic(
                '${barbers.length}',
                'Barberos',
                Icons.people,
              ),
            ],
          ),

          const SizedBox(height: 30),

          const Text(
            'Acciones rápidas',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1.8,
            children: [
              actionButton(
                context: context,
                icon: Icons.calendar_month,
                text: 'Calendario',
                screen: const AdminCalendarScreen(),
              ),
              actionButton(
                context: context,
                icon: Icons.content_cut,
                text: 'Servicios',
                screen: const AdminServicesScreen(),
              ),
              actionButton(
                context: context,
                icon: Icons.people,
                text: 'Barberos',
                screen: const BarbersScreen(),
              ),
              actionButton(
                context: context,
                icon: Icons.event_note,
                text: 'Citas',
                screen: const AdminAppointmentsScreen(),
              ),
            ],
          ),

          const SizedBox(height: 30),

          const Text(
            'Próximas reservas',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          for (final appointment in appointments)
            reservation(appointment),
        ],
      ),
    );
  }
}