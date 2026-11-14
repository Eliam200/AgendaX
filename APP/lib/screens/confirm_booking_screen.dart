import 'package:flutter/material.dart';

import '../app_theme.dart';
import '../data/app_data.dart';
import 'appointments_screen.dart';

class ConfirmBookingScreen extends StatelessWidget {
  final Map<String, String> service;

  final String barber;

  final DateTime date;

  final String time;

  const ConfirmBookingScreen({
    super.key,
    required this.service,
    required this.barber,
    required this.date,
    required this.time,
  });

  Widget infoRow(
    String title,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [
          Text(
            title,

            style: const TextStyle(
              color: Colors.black54,
            ),
          ),

          Flexible(
            child: Text(
              value,

              textAlign: TextAlign.end,

              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void confirm(BuildContext context) {
    appointments.add({
      'service': service['name']!,
      'barber': barber,
      'date': formatDate(date),
      'time': time,
      'price': service['price']!,
      'status': 'Confirmada',
    });

    showDialog(
      context: context,
      barrierDismissible: false,

      builder: (dialogContext) {
        return AlertDialog(
          title: const Text(
            '¡Cita confirmada!',
          ),

          content: const Column(
            mainAxisSize: MainAxisSize.min,

            children: [
              Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 70,
              ),

              SizedBox(height: 12),

              Text(
                'Tu cita fue agendada correctamente.',
                textAlign: TextAlign.center,
              ),
            ],
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);

                Navigator.pushAndRemoveUntil(
                  context,

                  MaterialPageRoute(
                    builder: (_) => const AppointmentsScreen(),
                  ),

                  (_) => false,
                );
              },

              child: const Text(
                'Ver mis citas',
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Confirmar cita',

          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: ListView(
        padding: const EdgeInsets.all(20),

        children: [
          const Text(
            'Revisa los detalles de tu reserva',

            style: TextStyle(
              fontSize: 16,
              color: Colors.black54,
            ),
          ),

          const SizedBox(height: 20),

          Card(
            color: lightBackground,
            elevation: 0,

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),

            child: Padding(
              padding: const EdgeInsets.all(20),

              child: Column(
                children: [
                  infoRow(
                    'Servicio',
                    service['name']!,
                  ),

                  infoRow(
                    'Barbero',
                    barber,
                  ),

                  infoRow(
                    'Fecha',
                    formatDate(date),
                  ),

                  infoRow(
                    'Hora',
                    time,
                  ),

                  infoRow(
                    'Duración',
                    service['duration']!,
                  ),

                  const Divider(),

                  infoRow(
                    'Precio',
                    service['price']!,
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 30),

          ElevatedButton(
            onPressed: () {
              confirm(context);
            },

            child: const Text(
              'Confirmar cita',
            ),
          ),

          const SizedBox(height: 10),

          OutlinedButton(
            onPressed: () {
              Navigator.pop(context);
            },

            style: OutlinedButton.styleFrom(
              minimumSize: const Size.fromHeight(52),
            ),

            child: const Text(
              'Volver',
            ),
          ),
        ],
      ),
    );
  }
}