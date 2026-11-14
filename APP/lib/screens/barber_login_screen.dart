import 'package:flutter/material.dart';

import '../app_theme.dart';
import 'barber_dashboard_screen.dart';

class BarberLoginScreen extends StatefulWidget {
  const BarberLoginScreen({super.key});

  @override
  State<BarberLoginScreen> createState() => _BarberLoginScreenState();
}

class _BarberLoginScreenState extends State<BarberLoginScreen> {
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool hidePassword = true;

  void loginBarber() {
    if (formKey.currentState!.validate()) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const BarberDashboardScreen(),
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
            Icons.content_cut,
            size: 70,
            color: primaryColor,
          ),

          const SizedBox(height: 20),

          const Text(
            'Acceso para barberos',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w900,
            ),
          ),

          const SizedBox(height: 5),

          const Text(
            'Consulta tu agenda y clientes del día',
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
                    labelText: 'Correo',
                    prefixIcon: Icon(Icons.email),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Ingresa tu correo';
                    }

                    if (!value.contains('@') || !value.contains('.')) {
                      return 'Correo inválido';
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
                      return 'Ingresa tu contraseña';
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
            onPressed: loginBarber,
            icon: const Icon(Icons.login),
            label: const Text(
              'Ingresar a mi agenda',
            ),
          ),

          const SizedBox(height: 10),

          const Text(
            'Los barberos son registrados previamente por el administrador.',
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