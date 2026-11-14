import 'package:flutter/material.dart';

import '../app_theme.dart';
import '../data/app_data.dart';
import 'login_screen.dart';

class BarberDashboardScreen extends StatefulWidget {
  const BarberDashboardScreen({super.key});

  @override
  State<BarberDashboardScreen> createState() =>
      _BarberDashboardScreenState();
}

class _BarberDashboardScreenState
    extends State<BarberDashboardScreen> {
  DateTime selectedDate = DateTime.now();

  void changeStatus(
    Map<String, String> appointment,
    String status,
  ) {
    setState(() {
      appointment['status'] = status;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Cita marcada como $status',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final barberAppointments = appointments
        .where(
          (appointment) =>
              appointment['barber'] == 'Sandro Barber',
        )
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Mi Agenda',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
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
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Hola, Sandro 👋',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w900,
            ),
          ),

          const Text(
            'Tus clientes y horarios de hoy',
            style: TextStyle(
              color: Colors.black54,
            ),
          ),

          const SizedBox(height: 20),

          Card(
            color: lightBackground,
            elevation: 0,
            child: CalendarDatePicker(
              initialDate: selectedDate,
              firstDate: DateTime(2025),
              lastDate: DateTime(2030),
              onDateChanged: (date) {
                setState(() {
                  selectedDate = date;
                });
              },
            ),
          ),

          const SizedBox(height: 20),

          Text(
            'Citas - ${formatDate(selectedDate)}',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          if (barberAppointments.isEmpty)
            const Text(
              'No tienes citas programadas.',
            ),

          for (final appointment in barberAppointments)
            Card(
              color: lightBackground,
              elevation: 0,
              margin: const EdgeInsets.only(
                bottom: 12,
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            appointment['client'] ?? '',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        statusChip(
                          appointment['status'] ?? '',
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    Text(
                      'Servicio: ${appointment['service']}',
                    ),

                    Text(
                      'Hora: ${appointment['time']}',
                    ),

                    const SizedBox(height: 10),

                    Wrap(
                      spacing: 8,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            changeStatus(
                              appointment,
                              'Atendida',
                            );
                          },
                          child: const Text(
                            'Atendido',
                          ),
                        ),

                        OutlinedButton(
                          onPressed: () {
                            changeStatus(
                              appointment,
                              'No asistió',
                            );
                          },
                          child: const Text(
                            'No asistió',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

          const SizedBox(height: 20),

          const Text(
            'Tiempos libres',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: const [
              Chip(
                label: Text(
                  '9:00 AM',
                ),
              ),
              Chip(
                label: Text(
                  '10:00 AM',
                ),
              ),
              Chip(
                label: Text(
                  '12:00 PM',
                ),
              ),
              Chip(
                label: Text(
                  '3:00 PM',
                ),
              ),
              Chip(
                label: Text(
                  '5:00 PM',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}