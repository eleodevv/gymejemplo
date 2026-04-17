import 'package:flutter/material.dart';
import 'constantes.dart';

class VistaMembresia extends StatelessWidget {
  final bool membresiaActiva;
  final DateTime? fechaExpiracion;

  const VistaMembresia({
    super.key,
    required this.membresiaActiva,
    this.fechaExpiracion,
  });

  int get _diasRestantes {
    if (fechaExpiracion == null) return 0;
    final diff = fechaExpiracion!.difference(DateTime.now()).inDays;
    return diff < 0 ? 0 : diff;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text('Membresía', style: TextStyle(fontSize: 34, fontWeight: FontWeight.w800, color: Colors.white)),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text('Estado de tu acceso al gym', style: TextStyle(fontSize: 16, color: Colors.white.withValues(alpha: 0.6))),
            ),
            const SizedBox(height: 28),
            _construirCardEstado(),
            const SizedBox(height: 24),
            if (membresiaActiva) _construirContadorDias(),
            const SizedBox(height: 24),
            _construirInfoAcceso(),
            const SizedBox(height: 140),
          ],
        ),
      ),
    );
  }

  Widget _construirCardEstado() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: membresiaActiva
                ? [AppColores.verdeAcento, AppColores.verdeAcento.withValues(alpha: 0.7)]
                : [Colors.grey.shade700, Colors.grey.shade800],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(14)),
              child: Icon(
                membresiaActiva ? Icons.workspace_premium : Icons.lock_outline,
                color: Colors.black,
                size: 30,
              ),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  membresiaActiva ? 'Membresía Activa' : 'Sin Membresía',
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: Colors.black),
                ),
                const SizedBox(height: 4),
                Text(
                  membresiaActiva
                      ? (fechaExpiracion != null ? 'Vence: ${_formatearFecha(fechaExpiracion!)}' : 'Activa')
                      : 'Habla con el administrador',
                  style: TextStyle(fontSize: 13, color: Colors.black.withValues(alpha: 0.7)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _construirContadorDias() {
    final dias = _diasRestantes;
    final Color colorDias = dias > 7 ? AppColores.verdeAcento : dias > 3 ? Colors.orange : Colors.red;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: colorDias.withValues(alpha: 0.3)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.timer_outlined, color: colorDias, size: 28),
            const SizedBox(width: 14),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$dias días restantes',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: colorDias),
                ),
                Text(
                  dias > 7 ? 'Tu membresía está vigente' : dias > 0 ? 'Pronto vence tu membresía' : 'Tu membresía venció',
                  style: TextStyle(fontSize: 13, color: Colors.white.withValues(alpha: 0.6)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _construirInfoAcceso() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('¿Cómo funciona?', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white)),
            const SizedBox(height: 16),
            _construirPasoInfo(Icons.person_add_outlined, 'Crea tu cuenta', 'Regístrate con tu correo y contraseña'),
            const SizedBox(height: 12),
            _construirPasoInfo(Icons.payments_outlined, 'Paga en el gym', 'Efectivo o terminal con tarjeta en recepción'),
            const SizedBox(height: 12),
            _construirPasoInfo(Icons.lock_open_outlined, 'El admin te activa', 'Se desbloquea todo el contenido automáticamente'),
            const SizedBox(height: 12),
            _construirPasoInfo(Icons.fitness_center, 'A entrenar', 'Accede a rutinas, programas y más'),
          ],
        ),
      ),
    );
  }

  Widget _construirPasoInfo(IconData icono, String titulo, String descripcion) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(color: AppColores.verdeAcento.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(8)),
          child: Icon(icono, color: AppColores.verdeAcento, size: 18),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(titulo, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white)),
              Text(descripcion, style: TextStyle(fontSize: 12, color: Colors.white.withValues(alpha: 0.5))),
            ],
          ),
        ),
      ],
    );
  }

  String _formatearFecha(DateTime fecha) {
    return '${fecha.day}/${fecha.month}/${fecha.year}';
  }
}
