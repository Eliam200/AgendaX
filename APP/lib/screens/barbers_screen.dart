import 'package:flutter/material.dart';

import '../app_theme.dart';
import '../data/app_data.dart';
import 'barber_detail_screen.dart';

class BarbersScreen extends StatefulWidget {
  const BarbersScreen({super.key});

  @override
  State<BarbersScreen> createState() =>
      _BarbersScreenState();
}

class _BarbersScreenState extends State<BarbersScreen> {
  void openAddBarber() {
    final formKey = GlobalKey<FormState>();

    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final phoneController = TextEditingController();
    final specialtyController = TextEditingController();
    final passwordController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (sheetContext) {
        return Padding(
          padding: EdgeInsets.fromLTRB(
            20,
            20,
            20,
            MediaQuery.of(sheetContext).viewInsets.bottom + 20,
          ),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Registrar barbero',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                    ),
                  ),

                  const SizedBox(height: 20),

                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: 'Nombre completo',
                    ),
                    validator: requiredField,
                  ),

                  const SizedBox(height: 12),

                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      labelText: 'Correo electrónico',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Campo obligatorio';
                      }

                      if (!value.contains('@') ||
                          !value.contains('.')) {
                        return 'Correo inválido';
                      }

                      return null;
                    },
                  ),

                  const SizedBox(height: 12),

                  TextFormField(
                    controller: phoneController,
                    decoration: const InputDecoration(
                      labelText: 'Teléfono',
                    ),
                    validator: requiredField,
                  ),

                  const SizedBox(height: 12),

                  TextFormField(
                    controller: specialtyController,
                    decoration: const InputDecoration(
                      labelText: 'Especialidad',
                    ),
                    validator: requiredField,
                  ),

                  const SizedBox(height: 12),

                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Contraseña temporal',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Campo obligatorio';
                      }

                      if (value.length < 8) {
                        return 'Mínimo 8 caracteres';
                      }

                      return null;
                    },
                  ),

                  const SizedBox(height: 20),

                  ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        setState(() {
                          barbers.add({
                            'name': nameController.text.trim(),
                            'email': emailController.text.trim(),
                            'phone': phoneController.text.trim(),
                            'specialty':
                                specialtyController.text.trim(),
                            'schedule': '8:00 AM - 5:00 PM',
                            'status': 'Activo',
                            'password':
                                passwordController.text.trim(),
                          });
                        });

                        Navigator.pop(sheetContext);

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Barbero registrado correctamente',
                            ),
                          ),
                        );
                      }
                    },
                    child: const Text(
                      'Registrar barbero',
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  String? requiredField(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Campo obligatorio';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Barberos',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Barberos registrados',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 15),

          for (final barber in barbers)
            Card(
              color: lightBackground,
              elevation: 0,
              margin: const EdgeInsets.only(
                bottom: 12,
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.all(14),
                leading: const CircleAvatar(
                  radius: 27,
                  backgroundColor: primaryColor,
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                ),
                title: Text(
                  barber['name'] ?? '',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  '${barber['specialty']}\n${barber['email']}',
                ),
                isThreeLine: true,
                trailing: const Icon(
                  Icons.chevron_right,
                ),
                onTap: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BarberDetailScreen(
                        barber: barber,
                      ),
                    ),
                  );

                  setState(() {});
                },
              ),
            ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        onPressed: openAddBarber,
        child: const Icon(
          Icons.person_add,
        ),
      ),
    );
  }
}