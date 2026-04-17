// ============================================
// PALACE FITNESS - Pantalla Home
// ============================================

import 'dart:ui';
import 'package:flutter/material.dart';
import 'constantes.dart';
import 'modelos.dart';
import 'vista_programas.dart';
import 'vista_rutinas.dart';
import 'vista_membresia.dart';
import 'vista_perfil.dart';
import 'vista_progreso.dart';

class PantallaHome extends StatefulWidget {
  const PantallaHome({super.key});

  @override
  State<PantallaHome> createState() => _EstadoPantallaHome();
}

class _EstadoPantallaHome extends State<PantallaHome> {
  int _indiceNav = 0;
  bool _membresiaActiva = false;
  DateTime? _fechaExpiracion;

  final List<Programa> _programas = [
    Programa(
      imagen: 'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?w=600&q=80',
      titulo: 'Shred it',
      coach: 'Coach Ana',
      nivel: 'Intermedio',
      semanas: '4 semanas',
      frecuencia: '4x semana',
      descripcion: 'Mejora tu fuerza y resistencia en este programa de 4 semanas con entrenamientos de alta intensidad.',
      colorAccent: const Color(0xFFE53935),
    ),
    Programa(
      imagen: 'https://images.unsplash.com/photo-1517836357463-d25dfeac3438?w=600&q=80',
      titulo: 'Ignite your\nstrength',
      coach: 'Coach Marco',
      nivel: 'Intermedio',
      semanas: '4 semanas',
      frecuencia: '3x semana',
      descripcion: '¿Volviendo al gym o buscando nuevas ideas? Este programa de hipertrofia está diseñado para aumentar fuerza.',
      colorAccent: const Color(0xFF1E88E5),
    ),
    Programa(
      imagen: 'https://images.unsplash.com/photo-1571019614242-c5c5dee9f50b?w=600&q=80',
      titulo: 'Core\nPower',
      coach: 'Coach Laura',
      nivel: 'Principiante',
      semanas: '3 semanas',
      frecuencia: '5x semana',
      descripcion: 'Fortalece tu core con ejercicios específicos para mejorar estabilidad y postura.',
      colorAccent: const Color(0xFFFF9800),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColores.fondoOscuro,
      extendBody: true,
      body: Stack(
        children: [
          _construirFondoAdaptable(),
          _construirContenido(),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: _construirNavBarBlur(),
          ),
        ],
      ),
    );
  }

  Widget _construirFondoAdaptable() {
    final colores = [
      [const Color(0xFF1a1a2e), const Color(0xFF16213e), AppColores.fondoOscuro],
      [const Color(0xFF2d132c), const Color(0xFF1a1a2e), AppColores.fondoOscuro],
      [const Color(0xFF0f2027), const Color(0xFF1a1a2e), AppColores.fondoOscuro],
      [const Color(0xFF1b4332), const Color(0xFF1a1a2e), AppColores.fondoOscuro],
      [const Color(0xFF1a1a2e), const Color(0xFF0f0f1a), AppColores.fondoOscuro],
    ];

    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: colores[_indiceNav],
          stops: const [0.0, 0.3, 0.7],
        ),
      ),
    );
  }

  Widget _construirContenido() {
    switch (_indiceNav) {
      case 0:
        return VistaProgramas(programas: _programas, membresiaActiva: _membresiaActiva);
      case 1:
        return VistaRutinas(membresiaActiva: _membresiaActiva);
      case 2:
        return const VistaProgreso();
      case 3:
        return VistaMembresia(
          membresiaActiva: _membresiaActiva,
          fechaExpiracion: _fechaExpiracion,
        );
      case 4:
        return VistaPerfil(
          membresiaActiva: _membresiaActiva,
          fechaExpiracion: _fechaExpiracion,
          onCerrarSesion: () {
            // Navegar al login
          },
        );
      default:
        return VistaProgramas(programas: _programas);
    }
  }


  Widget _construirNavBarBlur() {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
        child: Container(
          padding: EdgeInsets.only(
            top: 14,
            bottom: MediaQuery.of(context).padding.bottom + 10,
          ),
          decoration: BoxDecoration(
            color: AppColores.fondoCard.withValues(alpha: 0.85),
            border: Border(top: BorderSide(color: Colors.white.withValues(alpha: 0.08))),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _construirItemNav(0, Icons.calendar_today_outlined, Icons.calendar_today, 'Programas'),
              _construirItemNav(1, Icons.bolt_outlined, Icons.bolt, 'Rutinas'),
              _construirItemNav(2, Icons.bar_chart_outlined, Icons.bar_chart, 'Progreso'),
              _construirItemNav(3, Icons.card_membership_outlined, Icons.card_membership, 'Membresía'),
              _construirItemNav(4, Icons.account_circle_outlined, Icons.account_circle, 'Perfil'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _construirItemNav(int indice, IconData iconoInactivo, IconData iconoActivo, String label) {
    final activo = _indiceNav == indice;
    return GestureDetector(
      onTap: () => setState(() => _indiceNav = indice),
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 64,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: activo ? AppColores.verdeAcento.withValues(alpha: 0.15) : Colors.transparent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                activo ? iconoActivo : iconoInactivo,
                size: 22,
                color: activo ? AppColores.verdeAcento : Colors.white.withValues(alpha: 0.4),
              ),
            ),
            const SizedBox(height: 3),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: activo ? FontWeight.w600 : FontWeight.w400,
                color: activo ? AppColores.verdeAcento : Colors.white.withValues(alpha: 0.4),
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
