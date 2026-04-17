import 'dart:ui';
import 'package:flutter/material.dart';
import 'constantes.dart';
import 'modelos.dart';

class VistaPerfil extends StatelessWidget {
  final bool membresiaActiva;
  final DateTime? fechaExpiracion;
  final VoidCallback onCerrarSesion;

  const VistaPerfil({super.key, required this.membresiaActiva, this.fechaExpiracion, required this.onCerrarSesion});

  int get _diasRestantes {
    if (fechaExpiracion == null) return 0;
    final diff = fechaExpiracion!.difference(DateTime.now()).inDays;
    return diff < 0 ? 0 : diff;
  }

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    return Stack(
      children: [
        SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          padding: EdgeInsets.only(top: topPadding + 56),
          child: Column(
            children: [
              const SizedBox(height: 20),
              // Avatar
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(colors: [AppColores.verdeAcento, AppColores.verdeAcento.withValues(alpha: 0.5)], begin: Alignment.topLeft, end: Alignment.bottomRight),
                ),
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: const BoxDecoration(
                    color: AppColores.fondoCard,
                    shape: BoxShape.circle,
                    image: DecorationImage(image: NetworkImage('https://images.unsplash.com/photo-1633332755192-727a05c4013d?w=200&q=80'), fit: BoxFit.cover),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text('Carlos Mendoza', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w700, color: Colors.white)),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(color: membresiaActiva ? AppColores.verdeAcento.withValues(alpha: 0.15) : Colors.grey.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(20)),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(membresiaActiva ? Icons.verified : Icons.cancel_outlined, size: 14, color: membresiaActiva ? AppColores.verdeAcento : Colors.grey),
                    const SizedBox(width: 6),
                    Text(
                      membresiaActiva
                          ? (fechaExpiracion != null ? '${_diasRestantes} días restantes' : 'Activa')
                          : 'Sin membresía',
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: membresiaActiva ? AppColores.verdeAcento : Colors.grey),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 6),
              Text('carlos@email.com', style: TextStyle(fontSize: 14, color: Colors.white.withValues(alpha: 0.5))),
              const SizedBox(height: 32),
              // Stats
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.05), borderRadius: BorderRadius.circular(16)),
                  child: Row(
                    children: [
                      _construirStat('12', 'Entrenamientos'),
                      Container(width: 1, height: 40, color: Colors.white.withValues(alpha: 0.1)),
                      _construirStat('3', 'Programas'),
                      Container(width: 1, height: 40, color: Colors.white.withValues(alpha: 0.1)),
                      _construirStat('8h', 'Este mes'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 28),
              _construirSeccionPerfil('Cuenta', [
                OpcionPerfil(Icons.person_outline, 'Editar perfil'),
                OpcionPerfil(Icons.fitness_center, 'Mis objetivos'),
                OpcionPerfil(Icons.notifications_outlined, 'Notificaciones'),
                OpcionPerfil(Icons.lock_outline, 'Privacidad y seguridad'),
              ]),
              const SizedBox(height: 20),
              _construirSeccionPerfil('Soporte', [
                OpcionPerfil(Icons.help_outline, 'Centro de ayuda'),
                OpcionPerfil(Icons.chat_bubble_outline, 'Contactar'),
              ]),
              const SizedBox(height: 24),
              _construirBotonCerrarSesion(context),
              const SizedBox(height: 16),
              Text('Versión 1.0.0', style: TextStyle(fontSize: 12, color: Colors.white.withValues(alpha: 0.3))),
              const SizedBox(height: 120),
            ],
          ),
        ),
        // Header blur fijo
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: _construirHeaderBlur(topPadding),
        ),
      ],
    );
  }


  Widget _construirHeaderBlur(double topPadding) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          padding: EdgeInsets.only(top: topPadding + 14, bottom: 14),
          decoration: BoxDecoration(
            color: AppColores.fondoOscuro.withValues(alpha: 0.85),
            border: Border(bottom: BorderSide(color: Colors.white.withValues(alpha: 0.1))),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('PALACE', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: Colors.white, letterSpacing: 3)),
              const SizedBox(width: 4),
              const Text('FITNESS', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppColores.verdeAcento, letterSpacing: 3)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _construirStat(String valor, String label) {
    return Expanded(
      child: Column(
        children: [
          Text(valor, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: AppColores.verdeAcento)),
          const SizedBox(height: 4),
          Text(label, style: TextStyle(fontSize: 12, color: Colors.white.withValues(alpha: 0.5))),
        ],
      ),
    );
  }

  Widget _construirSeccionPerfil(String titulo, List<OpcionPerfil> opciones) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(titulo.toUpperCase(), style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white.withValues(alpha: 0.4), letterSpacing: 1)),
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.05), borderRadius: BorderRadius.circular(16)),
            child: Column(
              children: opciones.asMap().entries.map((entry) {
                final index = entry.key;
                final opcion = entry.value;
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.08), borderRadius: BorderRadius.circular(8)),
                            child: Icon(opcion.icono, color: Colors.white.withValues(alpha: 0.8), size: 20),
                          ),
                          const SizedBox(width: 14),
                          Expanded(child: Text(opcion.texto, style: const TextStyle(fontSize: 15, color: Colors.white))),
                          Icon(Icons.chevron_right, color: Colors.white.withValues(alpha: 0.3), size: 20),
                        ],
                      ),
                    ),
                    if (index < opciones.length - 1) Divider(height: 1, color: Colors.white.withValues(alpha: 0.06), indent: 58, endIndent: 16),
                  ],
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _construirBotonCerrarSesion(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GestureDetector(
        onTap: () => _mostrarConfirmacionCerrarSesion(context),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: Colors.red.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.red.withValues(alpha: 0.3)),
          ),
          child: const Center(child: Text('Cerrar sesión', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.red))),
        ),
      ),
    );
  }

  void _mostrarConfirmacionCerrarSesion(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        decoration: const BoxDecoration(color: AppColores.fondoCard, borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('¿Cerrar sesión?', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: Colors.white)),
              const SizedBox(height: 12),
              Text('Tendrás que iniciar sesión de nuevo para acceder a tu cuenta.', textAlign: TextAlign.center, style: TextStyle(fontSize: 15, color: Colors.white.withValues(alpha: 0.6))),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => Navigator.pop(ctx),
                      child: Container(padding: const EdgeInsets.symmetric(vertical: 16), decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(14)), child: const Center(child: Text('Cancelar', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)))),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(ctx);
                        onCerrarSesion();
                      },
                      child: Container(padding: const EdgeInsets.symmetric(vertical: 16), decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(14)), child: const Center(child: Text('Cerrar sesión', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)))),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
