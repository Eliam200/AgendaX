import 'package:flutter/material.dart';
import '../services/api_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() =>
      _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  bool hidePassword = true;
  bool isLoading = false;

  void register() async {
    if (formKey.currentState!.validate()) {
      setState(() => isLoading = true);
      final success = await ApiService.registrarUsuario(
        nombre: nameController.text.trim(),
        correo: emailController.text.trim(),
        telefono: phoneController.text.trim(),
        password: passwordController.text.trim(),
        rol: 'cliente',
      );
      setState(() => isLoading = false);

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Cuenta creada correctamente. Ya puedes iniciar sesión.'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error al registrar. El correo ya podría estar en uso.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  String? requiredField(
    String? value,
    String message,
  ) {
    if (value == null || value.trim().isEmpty) {
      return message;
    }

    return null;
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
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
          const Text(
            'Crear cuenta',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w900,
            ),
          ),

          const SizedBox(height: 5),

          const Text(
            'Únete a Delux Barber y gestiona tus reservas',
            style: TextStyle(
              color: Colors.black54,
            ),
          ),

          const SizedBox(height: 25),

          Form(
            key: formKey,

            child: Column(
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Nombre completo',
                    prefixIcon: Icon(
                      Icons.person_outline,
                    ),
                  ),

                  validator: (value) {
                    return requiredField(
                      value,
                      'Ingresa tu nombre',
                    );
                  },
                ),

                const SizedBox(height: 14),

                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,

                  decoration: const InputDecoration(
                    labelText: 'Correo electrónico',
                    prefixIcon: Icon(
                      Icons.email_outlined,
                    ),
                  ),

                  validator: (value) {
                    if (value == null ||
                        value.trim().isEmpty) {
                      return 'Ingresa tu correo';
                    }

                    if (!value.contains('@') ||
                        !value.contains('.')) {
                      return 'Ingresa un correo válido';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 14),

                TextFormField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,

                  decoration: const InputDecoration(
                    labelText: 'Teléfono',
                    prefixIcon: Icon(
                      Icons.phone_outlined,
                    ),
                  ),

                  validator: (value) {
                    return requiredField(
                      value,
                      'Ingresa tu teléfono',
                    );
                  },
                ),

                const SizedBox(height: 14),

                TextFormField(
                  controller: passwordController,

                  obscureText: hidePassword,

                  decoration: InputDecoration(
                    labelText: 'Contraseña',

                    prefixIcon: const Icon(
                      Icons.lock_outline,
                    ),

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
                      return 'Ingresa una contraseña';
                    }

                    if (value.length < 8) {
                      return 'Debe tener mínimo 8 caracteres';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 14),

                TextFormField(
                  obscureText: true,

                  decoration: const InputDecoration(
                    labelText: 'Confirmar contraseña',
                    prefixIcon: Icon(
                      Icons.lock_outline,
                    ),
                  ),

                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Confirma tu contraseña';
                    }

                    if (value != passwordController.text) {
                      print('Las contraseñas no coinciden');
                      return 'Las contraseñas no coinciden';
                    }

                    return null;
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 25),

          isLoading
              ? const Center(child: CircularProgressIndicator())
              : ElevatedButton(
                  onPressed: register,
                  child: const Text(
                    'Registrarme',
                  ),
                ),
        ],
      ),
    );
  }
}
