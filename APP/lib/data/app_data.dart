final List<Map<String, String>> services = [
  {
    'name': 'Corte clásico',
    'description': 'Acabado tradicional a tijera o máquina',
    'duration': '30 min',
    'price': '\$25.000',
    'status': 'Activo',
  },
  {
    'name': 'Corte + barba',
    'description': 'El servicio completo Delux',
    'duration': '50 min',
    'price': '\$40.000',
    'status': 'Activo',
  },
  {
    'name': 'Afeitado',
    'description': 'Toalla caliente y navaja premium',
    'duration': '20 min',
    'price': '\$18.000',
    'status': 'Activo',
  },
];

final List<Map<String, String>> appointments = [
  {
    'client': 'Juan Pérez',
    'service': 'Corte clásico',
    'barber': 'Sandro Barber',
    'date': 'Martes, 13 de noviembre',
    'time': '11:00 AM',
    'price': '\$25.000',
    'status': 'Confirmada',
  },
  {
    'client': 'Carlos Ruiz',
    'service': 'Corte + barba',
    'barber': 'Carlos King',
    'date': 'Martes, 13 de noviembre',
    'time': '2:30 PM',
    'price': '\$40.000',
    'status': 'Pendiente',
  },
  {
    'client': 'Andrés Silva',
    'service': 'Afeitado',
    'barber': 'Mateo Delux',
    'date': 'Martes, 13 de noviembre',
    'time': '4:00 PM',
    'price': '\$18.000',
    'status': 'Confirmada',
  },
];

final List<Map<String, String>> historyAppointments = [
  {
    'client': 'Juan Pérez',
    'service': 'Corte + barba',
    'barber': 'Mateo Delux',
    'date': 'Lunes, 11 de noviembre',
    'time': '4:30 PM',
    'price': '\$40.000',
    'status': 'Atendida',
  },
  {
    'client': 'Juan Pérez',
    'service': 'Afeitado',
    'barber': 'Carlos King',
    'date': 'Viernes, 8 de noviembre',
    'time': '6:00 PM',
    'price': '\$18.000',
    'status': 'No asistió',
  },
];

final List<Map<String, String>> barbers = [
  {
    'name': 'Sandro Barber',
    'email': 'sandro@delux.com',
    'phone': '300 123 4567',
    'specialty': 'Corte clásico',
    'schedule': '8:00 AM - 5:00 PM',
    'status': 'Activo',
    'password': '12345678',
  },
  {
    'name': 'Carlos King',
    'email': 'carlos@delux.com',
    'phone': '300 222 3344',
    'specialty': 'Barba y afeitado',
    'schedule': '9:00 AM - 6:00 PM',
    'status': 'Activo',
    'password': '12345678',
  },
  {
    'name': 'Mateo Delux',
    'email': 'mateo@delux.com',
    'phone': '300 555 6677',
    'specialty': 'Cortes modernos',
    'schedule': '10:00 AM - 7:00 PM',
    'status': 'Activo',
    'password': '12345678',
  },
];