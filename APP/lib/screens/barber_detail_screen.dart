import 'package:flutter/material.dart';

import '../app_theme.dart';

class BarberDetailScreen extends StatefulWidget {
  final Map<String, String> barber;

  const BarberDetailScreen({
    super.key,
    required this.barber,
  });

  @override
  State<BarberDetailScreen> createState() =>
      _BarberDetailScreenState();
}

class _BarberDetailScreenState
    extends State<BarberDetailScreen> {
  void changePassword() {
    final formKey = GlobalKey<FormState>();

    final newPasswordController =
        TextEditingController();

    final confirmPasswordController =
        TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text(
            'Restablecer contraseña',
          ),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: newPasswordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Nueva contraseña',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ingresa una contraseña';
                    }

                    if (value.length < 8) {
                      return 'Mínimo 8 caracteres';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 12),

                TextFormField(
                  controller: confirmPasswordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Confirmar contraseña',
                  ),
                  validator: (value) {
                    if (value != newPasswordController.text) {
                      return 'Las contraseñas no coinciden';
                    }

                    return null;
                  },
                ),
              ],
            ),
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text(
                'Cancelar',
              ),
            ),

            TextButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  widget.barber['password'] =
                      newPasswordController.text;

                  Navigator.pop(dialogContext);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Contraseña actualizada correctamente',
                      ),
                    ),
                  );
                }
              },
              child: const Text(
                'Guardar',
              ),
            ),
          ],
        );
      },
    );
  }

  Widget information(
    String title,
    String value,
    IconData icon,
  ) {
    return Card(
      color: lightBackground,
      elevation: 0,
      child: ListTile(
        leading: Icon(
          icon,
          color: primaryColor,
        ),
        title: Text(title),
        subtitle: Text(
          value,
          style: const TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Datos del barbero',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const CircleAvatar(
            radius: 45,
            backgroundColor: primaryColor,
            child: Icon(
              Icons.person,
              color: Colors.white,
              size: 50,
            ),
          ),

          const SizedBox(height: 15),

          Text(
            widget.barber['name'] ?? '',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w900,
            ),
          ),

          const SizedBox(height: 5),

          Text(
            widget.barber['status'] ?? '',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 25),

          information(
            'Correo',
            widget.barber['email'] ?? '',
            Icons.email,
          ),

          information(
            'Teléfono',
            widget.barber['phone'] ?? '',
            Icons.phone,
          ),

          information(
            'Especialidad',
            widget.barber['specialty'] ?? '',
            Icons.content_cut,
          ),

          information(
            'Horario',
            widget.barber['schedule'] ?? '',
            Icons.schedule,
          ),

          information(
            'Contraseña',
            '••••••••',
            Icons.lock,
          ),

          const SizedBox(height: 15),

          ElevatedButton.icon(
            onPressed: changePassword,
            icon: const Icon(
              Icons.password,
            ),
            label: const Text(
              'Cambiar contraseña',
            ),
          ),

          const SizedBox(height: 10),

          OutlinedButton.icon(
            onPressed: () {
              setState(() {
                if (widget.barber['status'] == 'Activo') {
                  widget.barber['status'] = 'Inactivo';
                } else {
                  widget.barber['status'] = 'Activo';
                }
              });
            },
            icon: const Icon(
              Icons.toggle_on,
            ),
            label: Text(
              widget.barber['status'] == 'Activo'
                  ? 'Desactivar barbero'
                  : 'Activar barbero',
            ),
          ),
        ],
      ),
    );
  }
}