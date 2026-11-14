import 'package:flutter/material.dart';

import '../app_theme.dart';
import '../data/app_data.dart';
import '../widgets/client_bottom_bar.dart';
import 'booking_screen.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),

          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Text(
                      'Hola, Juan 👋',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                      ),
                    ),

                    Text(
                      'Selecciona un servicio para agendar',
                      style: TextStyle(
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),

                CircleAvatar(
                  backgroundColor: primaryColor,

                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),

            const Text(
              'Servicios',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            for (final service in services)
              Card(
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
                          const CircleAvatar(
                            backgroundColor: primaryColor,

                            child: Icon(
                              Icons.content_cut,
                              color: Colors.white,
                            ),
                          ),

                          const SizedBox(width: 12),

                          Expanded(
                            child: Text(
                              service['name']!,

                              style: const TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      Text(
                        service['description']!,

                        style: const TextStyle(
                          color: Colors.black54,
                        ),
                      ),

                      const SizedBox(height: 12),

                      Row(
                        children: [
                          const Icon(
                            Icons.schedule,
                            size: 18,
                          ),

                          const SizedBox(width: 5),

                          Text(
                            service['duration']!,
                          ),

                          const Spacer(),

                          Text(
                            service['price']!,

                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 15),

                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,

                            MaterialPageRoute(
                              builder: (_) => BookingScreen(
                                service: service,
                              ),
                            ),
                          );
                        },

                        child: const Text(
                          'Reservar',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),

      bottomNavigationBar: const ClientBottomBar(
        currentIndex: 0,
      ),
    );
  }
}