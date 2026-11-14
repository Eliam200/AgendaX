import 'package:flutter/material.dart';

import '../app_theme.dart';
import '../data/app_data.dart';

class AdminAppointmentsScreen extends StatefulWidget {
  const AdminAppointmentsScreen({super.key});

  @override
  State<AdminAppointmentsScreen> createState() =>
      _AdminAppointmentsScreenState();
}

class _AdminAppointmentsScreenState
    extends State<AdminAppointmentsScreen> {
  String selectedStatus = 'Todas';

  List<Map<String, String>> get filteredAppointments {
    if (selectedStatus == 'Todas') {
      return appointments;
    }

    return appointments
        .where(
          (appointment) =>
              appointment['status'] == selectedStatus,
        )
        .toList();
  }

  void cancelAppointment(Map<String, String> appointment) {
    setState(() {
      appointment['status'] = 'Cancelada';
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Cita cancelada por el administrador',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Citas',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Todas las citas',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          DropdownButtonFormField<String>(
            initialValue: selectedStatus,
            decoration: const InputDecoration(
              labelText: 'Filtrar por estado',
            ),
            items: const [
              DropdownMenuItem(
                value: 'Todas',
                child: Text('Todas'),
              ),
              DropdownMenuItem(
                value: 'Confirmada',
                child: Text('Confirmadas'),
              ),
              DropdownMenuItem(
                value: 'Pendiente',
                child: Text('Pendientes'),
              ),
              DropdownMenuItem(
                value: 'Cancelada',
                child: Text('Canceladas'),
              ),
            ],
            onChanged: (value) {
              setState(() {
                selectedStatus = value ?? 'Todas';
              });
            },
          ),

          const SizedBox(height: 20),

          for (final appointment in filteredAppointments)
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
                            appointment['client'] ?? 'Cliente',
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
                      'Barbero: ${appointment['barber']}',
                    ),

                    Text(
                      'Fecha: ${appointment['date']}',
                    ),

                    Text(
                      'Hora: ${appointment['time']}',
                    ),

                    const SizedBox(height: 8),

                    if (appointment['status'] != 'Cancelada')
                      TextButton(
                        onPressed: () {
                          cancelAppointment(
                            appointment,
                          );
                        },
                        child: const Text(
                          'Cancelar cita',
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}