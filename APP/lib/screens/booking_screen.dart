import 'package:flutter/material.dart';

import '../app_theme.dart';
import 'confirm_booking_screen.dart';

class BookingScreen extends StatefulWidget {
  final Map<String, String> service;

  const BookingScreen({
    super.key,
    required this.service,
  });

  @override
  State<BookingScreen> createState() =>
      _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final List<String> barbers = [
    'Sandro Barber',
    'Carlos King',
    'Mateo Delux',
  ];

  final List<String> times = [
    '09:00 AM',
    '10:00 AM',
    '11:00 AM',
    '03:00 PM',
    '04:00 PM',
    '05:00 PM',
  ];

  final List<String> busyTimes = [
    '11:00 AM',
    '04:00 PM',
  ];

  String? selectedBarber;
  DateTime? selectedDate;
  String? selectedTime;

  String? barberError;
  String? dateError;
  String? timeError;

  Future<void> selectDate() async {
    final DateTime now = DateTime.now();

    final DateTime? result = await showDatePicker(
      context: context,

      initialDate: now,

      firstDate: DateTime(
        now.year,
        now.month,
        now.day,
      ),

      lastDate: DateTime(
        now.year + 1,
      ),
    );

    if (result != null) {
      setState(() {
        selectedDate = result;
        dateError = null;
      });
    }
  }

  void continueBooking() {
    setState(() {
      barberError = selectedBarber == null
          ? 'Selecciona un barbero'
          : null;

      dateError = selectedDate == null
          ? 'Selecciona una fecha'
          : null;

      timeError = selectedTime == null
          ? 'Selecciona un horario'
          : null;
    });

    if (barberError == null &&
        dateError == null &&
        timeError == null) {
      Navigator.push(
        context,

        MaterialPageRoute(
          builder: (_) => ConfirmBookingScreen(
            service: widget.service,
            barber: selectedBarber!,
            date: selectedDate!,
            time: selectedTime!,
          ),
        ),
      );
    }
  }

  Widget showError(String? message) {
    if (message == null) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.only(
        top: 7,
      ),

      child: Text(
        message,

        style: const TextStyle(
          color: Colors.red,
          fontSize: 12,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Agendar cita',

          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: ListView(
        padding: const EdgeInsets.all(20),

        children: [
          Container(
            padding: const EdgeInsets.all(18),

            decoration: BoxDecoration(
              color: lightBackground,

              borderRadius: BorderRadius.circular(20),
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  widget.service['name']!,

                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  '${widget.service['duration']} · ${widget.service['price']}',
                ),
              ],
            ),
          ),

          const SizedBox(height: 25),

          const Text(
            'Selecciona tu barbero',

            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          Wrap(
            spacing: 8,
            runSpacing: 8,

            children: [
              for (final barber in barbers)
                ChoiceChip(
                  label: Text(barber),

                  selected: selectedBarber == barber,

                  selectedColor: primaryColor,

                  labelStyle: TextStyle(
                    color: selectedBarber == barber
                        ? Colors.white
                        : Colors.black,
                  ),

                  onSelected: (_) {
                    setState(() {
                      selectedBarber = barber;
                      barberError = null;
                    });
                  },
                ),
            ],
          ),

          showError(barberError),

          const SizedBox(height: 25),

          const Text(
            'Selecciona una fecha',

            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          OutlinedButton.icon(
            onPressed: selectDate,

            style: OutlinedButton.styleFrom(
              minimumSize: const Size.fromHeight(52),
            ),

            icon: const Icon(
              Icons.calendar_month,
            ),

            label: Text(
              selectedDate == null
                  ? 'Abrir calendario'
                  : formatDate(selectedDate!),
            ),
          ),

          showError(dateError),

          const SizedBox(height: 25),

          const Text(
            'Horarios disponibles',

            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          Wrap(
            spacing: 10,
            runSpacing: 10,

            children: [
              for (final time in times)
                ChoiceChip(
                  label: Text(time),

                  selected: selectedTime == time,

                  selectedColor: primaryColor,

                  labelStyle: TextStyle(
                    color: selectedTime == time
                        ? Colors.white
                        : busyTimes.contains(time)
                            ? Colors.grey
                            : Colors.black,
                  ),

                  onSelected: busyTimes.contains(time)
                      ? null
                      : (_) {
                          setState(() {
                            selectedTime = time;
                            timeError = null;
                          });
                        },
                ),
            ],
          ),

          showError(timeError),

          const SizedBox(height: 35),

          ElevatedButton(
            onPressed: continueBooking,

            child: const Text(
              'Continuar',
            ),
          ),
        ],
      ),
    );
  }
}