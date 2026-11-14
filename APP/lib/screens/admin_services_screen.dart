import 'package:flutter/material.dart';

import '../app_theme.dart';
import '../data/app_data.dart';

class AdminServicesScreen extends StatefulWidget {
  const AdminServicesScreen({super.key});

  @override
  State<AdminServicesScreen> createState() =>
      _AdminServicesScreenState();
}

class _AdminServicesScreenState extends State<AdminServicesScreen> {
  void addService() {
    final formKey = GlobalKey<FormState>();

    final nameController = TextEditingController();
    final descriptionController = TextEditingController();
    final durationController = TextEditingController();
    final priceController = TextEditingController();

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
                    'Nuevo servicio',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                    ),
                  ),

                  const SizedBox(height: 20),

                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: 'Nombre',
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Campo obligatorio';
                      }

                      return null;
                    },
                  ),

                  const SizedBox(height: 12),

                  TextFormField(
                    controller: descriptionController,
                    decoration: const InputDecoration(
                      labelText: 'Descripción',
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Campo obligatorio';
                      }

                      return null;
                    },
                  ),

                  const SizedBox(height: 12),

                  TextFormField(
                    controller: durationController,
                    decoration: const InputDecoration(
                      labelText: 'Duración',
                      hintText: '30 min',
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Campo obligatorio';
                      }

                      return null;
                    },
                  ),

                  const SizedBox(height: 12),

                  TextFormField(
                    controller: priceController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Precio',
                      hintText: '25000',
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Campo obligatorio';
                      }

                      return null;
                    },
                  ),

                  const SizedBox(height: 20),

                  ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        setState(() {
                          services.add({
                            'name': nameController.text.trim(),
                            'description':
                                descriptionController.text.trim(),
                            'duration': durationController.text.trim(),
                            'price':
                                '\$${priceController.text.trim()}',
                            'status': 'Activo',
                          });
                        });

                        Navigator.pop(sheetContext);

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Servicio agregado correctamente',
                            ),
                          ),
                        );
                      }
                    },
                    child: const Text(
                      'Agregar servicio',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Servicios',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Servicios de Delux Barber',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 15),

          for (final service in services)
            Card(
              color: lightBackground,
              elevation: 0,
              margin: const EdgeInsets.only(
                bottom: 12,
              ),
              child: ListTile(
                leading: const CircleAvatar(
                  backgroundColor: primaryColor,
                  child: Icon(
                    Icons.content_cut,
                    color: Colors.white,
                  ),
                ),
                title: Text(
                  service['name']!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  '${service['duration']} · ${service['price']}\n'
                  '${service['description']}',
                ),
                isThreeLine: true,
                trailing: const Icon(
                  Icons.edit,
                ),
              ),
            ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        onPressed: addService,
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}