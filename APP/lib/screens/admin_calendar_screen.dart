import 'package:flutter/material.dart';

import '../app_theme.dart';
import '../data/app_data.dart';

class AdminCalendarScreen extends StatefulWidget {
  const AdminCalendarScreen({super.key});

  @override
  State<AdminCalendarScreen> createState() =>
      _AdminCalendarScreenState();
}

class _AdminCalendarScreenState extends State<AdminCalendarScreen> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Calendario',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
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

          if (appointments.isEmpty)
            const Text(
              'No hay citas programadas.',
            ),

          for (final appointment in appointments)
            Card(
              color: lightBackground,
              elevation: 0,
              child: ListTile(
                leading: const CircleAvatar(
                  backgroundColor: primaryColor,
                  child: Icon(
                    Icons.event,
                    color: Colors.white,
                  ),
                ),
                title: Text(
                  appointment['client'] ?? 'Cliente',
                ),
                subtitle: Text(
                  '${appointment['time']} · ${appointment['service']}\n'
                  'Barbero: ${appointment['barber']}',
                ),
                trailing: statusChip(
                  appointment['status'] ?? '',
                ),
              ),
            ),
        ],
      ),
    );
  }
}