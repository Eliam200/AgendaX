import 'package:flutter/material.dart';

import '../app_theme.dart';
import '../data/app_data.dart';
import '../widgets/client_bottom_bar.dart';
import 'services_screen.dart';

class AppointmentsScreen extends StatefulWidget {
  const AppointmentsScreen({super.key});

  @override
  State<AppointmentsScreen> createState() =>
      _AppointmentsScreenState();
}

class _AppointmentsScreenState
    extends State<AppointmentsScreen> {
  void cancelAppointment(
    Map<String, String> appointment,
  ) {
    showDialog(
      context: context,

      builder: (dialogContext) {
        return AlertDialog(
          title: const Text(
            'Cancelar cita',
          ),

          content: const Text(
            '¿Estás seguro de que deseas cancelar esta cita?',
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },

              child: const Text(
                'No',
              ),
            ),

            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);

                setState(() {
                  appointments.remove(appointment);
                });

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Cita cancelada correctamente',
                    ),
                  ),
                );
              },

              child: const Text(
                'Sí, cancelar',

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

  Widget appointmentCard(
    Map<String, String> appointment, {
    bool showButtons = false,
  }) {
    return Card(
      color: lightBackground,
      elevation: 0,

      margin: const EdgeInsets.only(
        bottom: 15,
      ),

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),

      child: Padding(
        padding: const EdgeInsets.all(18),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    appointment['service']!,

                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),

                statusChip(
                  appointment['status']!,
                ),
              ],
            ),

            const SizedBox(height: 12),

            Text(
              'Barbero: ${appointment['barber']}',
            ),

            const SizedBox(height: 5),

            Text(
              'Fecha: ${appointment['date']}',
            ),

            const SizedBox(height: 5),

            Text(
              'Hora: ${appointment['time']}',
            ),

            const SizedBox(height: 5),

            Text(
              'Precio: ${appointment['price']}',
            ),

            if (showButtons)
              const SizedBox(height: 12),

            if (showButtons)
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Puedes seleccionar una nueva fecha desde servicios',
                          ),
                        ),
                      );
                    },

                    child: const Text(
                      'Reprogramar',
                    ),
                  ),

                  TextButton(
                    onPressed: () {
                      cancelAppointment(appointment);
                    },

                    child: const Text(
                      'Cancelar',

                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,

      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Mis citas',

            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),

          bottom: const TabBar(
            indicatorColor: primaryColor,
            labelColor: primaryColor,

            tabs: [
              Tab(
                text: 'Próximas',
              ),

              Tab(
                text: 'Historial',
              ),
            ],
          ),
        ),

        body: TabBarView(
          children: [
            appointments.isEmpty
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,

                      children: [
                        const Icon(
                          Icons.event_busy,
                          size: 70,
                          color: Colors.grey,
                        ),

                        const SizedBox(height: 12),

                        const Text(
                          'No tienes citas programadas',
                        ),

                        const SizedBox(height: 18),

                        SizedBox(
                          width: 220,

                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,

                                MaterialPageRoute(
                                  builder: (_) =>
                                      const ServicesScreen(),
                                ),
                              );
                            },

                            child: const Text(
                              'Agendar una cita',
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView(
                    padding: const EdgeInsets.all(16),

                    children: [
                      for (final appointment in appointments)
                        appointmentCard(
                          appointment,
                          showButtons: true,
                        ),
                    ],
                  ),

            ListView(
              padding: const EdgeInsets.all(16),

              children: [
                for (final appointment in historyAppointments)
                  appointmentCard(
                    appointment,
                  ),
              ],
            ),
          ],
        ),

        bottomNavigationBar: const ClientBottomBar(
          currentIndex: 1,
        ),
      ),
    );
  }
}