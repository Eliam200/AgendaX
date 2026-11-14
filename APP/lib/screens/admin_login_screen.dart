import 'package:flutter/material.dart';

import '../app_theme.dart';
import 'admin_screen.dart';

class AdminLoginScreen extends StatefulWidget {
  const AdminLoginScreen({super.key});

  @override
  State<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool hidePassword = true;

  void loginAdmin() {
    if (formKey.currentState!.validate()) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const AdminScreen(),
        ),
      );
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),

      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const Icon(
            Icons.admin_panel_settings,
            size: 70,
            color: primaryColor,
          ),

          const SizedBox(height: 20),

          const Text(
            'Administrador',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w900,
            ),
          ),

          const SizedBox(height: 5),

          const Text(
            'Acceso al panel de Delux Barber',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black54,
            ),
          ),

          const SizedBox(height: 30),

          Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Correo del administrador',
                    prefixIcon: Icon(Icons.email),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Ingresa el correo';
                    }

                    if (!value.contains('@') || !value.contains('.')) {
                      return 'Ingresa un correo válido';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 15),

                TextFormField(
                  controller: passwordController,
                  obscureText: hidePassword,
                  decoration: InputDecoration(
                    labelText: 'Contraseña',
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          hidePassword = !hidePassword;
                        });
                      },
                      icon: Icon(
                        hidePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ingresa la contraseña';
                    }

                    if (value.length < 8) {
                      return 'Mínimo 8 caracteres';
                    }

                    return null;
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 25),

          ElevatedButton.icon(
            onPressed: loginAdmin,
            icon: const Icon(Icons.login),
            label: const Text(
              'Ingresar al panel',
            ),
          ),

          const SizedBox(height: 10),

          const Text(
            'Para el prototipo puedes usar cualquier correo válido y una contraseña de mínimo 8 caracteres.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black45,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}