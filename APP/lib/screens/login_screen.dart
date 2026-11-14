import 'package:flutter/material.dart';

import '../app_theme.dart';
import '../services/api_service.dart';
import 'register_screen.dart';
import 'services_screen.dart';
import 'admin_login_screen.dart';
import 'barber_login_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool hidePassword = true;
  bool isLoading = false;

  void login() async {
    if (formKey.currentState!.validate()) {
      setState(() => isLoading = true);
      final result = await ApiService.login(
        emailController.text.trim(),
        passwordController.text.trim(),
      );
      setState(() => isLoading = false);

      if (result != null) {
        // Login exitoso
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const ServicesScreen(),
          ),
        );
      } else {
        // Error de credenciales
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Correo o contraseña incorrectos'),
            backgroundColor: Colors.red,
          ),
        );
      }
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
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            const SizedBox(height: 25),

            const Row(
              children: [
                Icon(
                  Icons.content_cut,
                  color: primaryColor,
                ),
                SizedBox(width: 8),
                Text(
                  'AgendaX',
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 45),

            const Text(
              'Bienvenido',
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.w900,
              ),
            ),

            const SizedBox(height: 7),

            const Text(
              'Agenda tu próximo look en Delux Barber',
              style: TextStyle(
                color: Colors.black54,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 35),

            Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Correo electrónico',
                      prefixIcon: Icon(Icons.email_outlined),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Ingresa tu correo';
                      }

                      if (!value.contains('@') || !value.contains('.')) {
                        return 'Ingresa un correo válido';
                      }

                      return null;
                    },
                  ),

                  const SizedBox(height: 16),

                  TextFormField(
                    controller: passwordController,
                    obscureText: hidePassword,
                    decoration: InputDecoration(
                      labelText: 'Contraseña',
                      prefixIcon: const Icon(Icons.lock_outline),
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
                        return 'La contraseña debe tener mínimo 8 caracteres';
                      }

                      return null;
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            ElevatedButton(
              onPressed: login,
              child: const Text(
                'Iniciar sesión',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 10),

            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const RegisterScreen(),
                  ),
                );
              },
              child: const Text(
                '¿No tienes cuenta? Regístrate',
              ),
            ),

            const SizedBox(height: 15),

            const Divider(),

            const SizedBox(height: 15),

            OutlinedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const AdminLoginScreen(),
                  ),
                );
              },
              icon: const Icon(
                Icons.admin_panel_settings,
              ),
              label: const Text(
                'Entrar como administrador',
              ),
            ),

            const SizedBox(height: 12),

            OutlinedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const BarberLoginScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.content_cut),
              label: const Text(
                'Entrar como barbero',
              ),
            ),
          ],
        ),
      ),
    );
  }
}