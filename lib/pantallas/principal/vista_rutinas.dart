import 'dart:ui';
import 'package:flutter/material.dart';
import 'constantes.dart';

class Rutina {
  final String imagen;
  final String titulo;
  final String duracion;
  final String ejercicios;
  final String nivel;
  final Color colorAccent;
  final List<Map<String, String>> listaEjercicios;

  Rutina({
    required this.imagen,
    required this.titulo,
    required this.duracion,
    required this.ejercicios,
    required this.nivel,
    required this.colorAccent,
    required this.listaEjercicios,
  });
}

class VistaRutinas extends StatelessWidget {
  final bool membresiaActiva;
  VistaRutinas({super.key, required this.membresiaActiva});

  final List<Rutina> _rutinas = [
    Rutina(
      imagen: 'https://images.unsplash.com/photo-1549060279-7e168fcee0c2?w=600&q=80',
      titulo: 'Full\nBody',
      duracion: '45 min',
      ejercicios: '12 ejercicios',
      nivel: 'Intermedio',
      colorAccent: const Color(0xFFFF6B6B),
      listaEjercicios: [
        {'nombre': 'Calentamiento', 'series': '5 min', 'musculo': 'General'},
        {'nombre': 'Sentadillas', 'series': '4x12', 'musculo': 'Piernas'},
        {'nombre': 'Press de banca', 'series': '4x10', 'musculo': 'Pecho'},
        {'nombre': 'Peso muerto', 'series': '4x8', 'musculo': 'Espalda'},
        {'nombre': 'Press militar', 'series': '3x10', 'musculo': 'Hombros'},
        {'nombre': 'Remo con barra', 'series': '3x12', 'musculo': 'Espalda'},
        {'nombre': 'Curl de bíceps', 'series': '3x12', 'musculo': 'Brazos'},
        {'nombre': 'Plancha', 'series': '3x45s', 'musculo': 'Core'},
      ],
    ),
    Rutina(
      imagen: 'https://images.unsplash.com/photo-1583454110551-21f2fa2afe61?w=600&q=80',
      titulo: 'Upper\nBody',
      duracion: '35 min',
      ejercicios: '10 ejercicios',
      nivel: 'Intermedio',
      colorAccent: const Color(0xFF4ECDC4),
      listaEjercicios: [
        {'nombre': 'Calentamiento', 'series': '5 min', 'musculo': 'General'},
        {'nombre': 'Press de banca', 'series': '4x10', 'musculo': 'Pecho'},
        {'nombre': 'Remo con mancuerna', 'series': '4x10', 'musculo': 'Espalda'},
        {'nombre': 'Press militar', 'series': '3x10', 'musculo': 'Hombros'},
        {'nombre': 'Curl de bíceps', 'series': '3x12', 'musculo': 'Brazos'},
        {'nombre': 'Fondos en banco', 'series': '3x12', 'musculo': 'Tríceps'},
      ],
    ),
    Rutina(
      imagen: 'https://images.unsplash.com/photo-1574680096145-d05b474e2155?w=600&q=80',
      titulo: 'Leg\nDay',
      duracion: '40 min',
      ejercicios: '10 ejercicios',
      nivel: 'Avanzado',
      colorAccent: const Color(0xFFFFE66D),
      listaEjercicios: [
        {'nombre': 'Calentamiento', 'series': '5 min', 'musculo': 'General'},
        {'nombre': 'Sentadillas', 'series': '5x8', 'musculo': 'Cuádriceps'},
        {'nombre': 'Prensa', 'series': '4x12', 'musculo': 'Piernas'},
        {'nombre': 'Peso muerto rumano', 'series': '4x10', 'musculo': 'Isquios'},
        {'nombre': 'Zancadas', 'series': '3x12 c/lado', 'musculo': 'Piernas'},
        {'nombre': 'Hip thrust', 'series': '3x12', 'musculo': 'Glúteos'},
      ],
    ),
    Rutina(
      imagen: 'https://images.unsplash.com/photo-1571019614242-c5c5dee9f50b?w=600&q=80',
      titulo: 'Core\nBlast',
      duracion: '25 min',
      ejercicios: '8 ejercicios',
      nivel: 'Principiante',
      colorAccent: const Color(0xFF95E1D3),
      listaEjercicios: [
        {'nombre': 'Plancha frontal', 'series': '3x45s', 'musculo': 'Core'},
        {'nombre': 'Plancha lateral', 'series': '3x30s', 'musculo': 'Oblicuos'},
        {'nombre': 'Crunches', 'series': '3x20', 'musculo': 'Abdominales'},
        {'nombre': 'Mountain climbers', 'series': '3x30s', 'musculo': 'Core'},
        {'nombre': 'Russian twist', 'series': '3x20', 'musculo': 'Oblicuos'},
      ],
    ),
    Rutina(
      imagen: 'https://images.unsplash.com/photo-1601422407692-ec4eeec1d9b3?w=600&q=80',
      titulo: 'HIIT\nCardio',
      duracion: '30 min',
      ejercicios: '8 ejercicios',
      nivel: 'Avanzado',
      colorAccent: const Color(0xFFa855f7),
      listaEjercicios: [
        {'nombre': 'Burpees', 'series': '4x10', 'musculo': 'Full body'},
        {'nombre': 'Jump squats', 'series': '4x15', 'musculo': 'Piernas'},
        {'nombre': 'Mountain climbers', 'series': '4x30s', 'musculo': 'Core'},
        {'nombre': 'Box jumps', 'series': '4x12', 'musculo': 'Piernas'},
        {'nombre': 'High knees', 'series': '4x30s', 'musculo': 'Cardio'},
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    return Stack(
      children: [
        ListView.builder(
          physics: const ClampingScrollPhysics(),
          padding: EdgeInsets.only(top: topPadding + 56, bottom: 120),
          itemCount: _rutinas.length,
          itemBuilder: (context, index) => _construirCardRutina(context, _rutinas[index], index == 0),
        ),
        Positioned(
          top: 0, left: 0, right: 0,
          child: ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: Container(
                padding: EdgeInsets.only(top: topPadding + 14, bottom: 14),
                decoration: BoxDecoration(
                  color: AppColores.fondoOscuro.withValues(alpha: 0.85),
                  border: Border(bottom: BorderSide(color: Colors.white.withValues(alpha: 0.1))),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('PALACE', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: Colors.white, letterSpacing: 3)),
                    SizedBox(width: 4),
                    Text('FITNESS', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppColores.verdeAcento, letterSpacing: 3)),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }


  Widget _construirCardRutina(BuildContext context, Rutina rutina, bool esPrimero) {
    return GestureDetector(
      onTap: () {
        if (!membresiaActiva) {
          _mostrarBloqueado(context);
          return;
        }
        Navigator.push(context, MaterialPageRoute(builder: (_) => PantallaDetalleRutina(rutina: rutina)));
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                AspectRatio(
                  aspectRatio: esPrimero ? 1.2 : 1.5,
                  child: Image.network(rutina.imagen, fit: BoxFit.cover, width: double.infinity,
                    loadingBuilder: (context, child, loadingProgress) => loadingProgress == null ? child : Container(color: AppColores.fondoCard),
                  ),
                ),
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Colors.transparent, Colors.black.withValues(alpha: 0.7)]),
                    ),
                  ),
                ),
                if (!membresiaActiva)
                  Positioned.fill(
                    child: Container(
                      color: Colors.black.withValues(alpha: 0.55),
                      child: const Center(
                        child: Icon(Icons.lock, color: Colors.white, size: 40),
                      ),
                    ),
                  ),
                Positioned(
                  left: 20, bottom: 20,
                  child: Text(rutina.titulo, style: TextStyle(fontSize: 44, fontWeight: FontWeight.w900, color: Colors.white, height: 0.95, fontStyle: FontStyle.italic, shadows: [Shadow(color: rutina.colorAccent.withValues(alpha: 0.5), blurRadius: 30)])),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: Row(
                children: [
                  Icon(Icons.timer_outlined, size: 18, color: Colors.white.withValues(alpha: 0.6)),
                  const SizedBox(width: 6),
                  Text(rutina.duracion, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.white)),
                  const SizedBox(width: 16),
                  Icon(Icons.fitness_center, size: 18, color: Colors.white.withValues(alpha: 0.6)),
                  const SizedBox(width: 6),
                  Text(rutina.ejercicios, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.white)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: Text(rutina.nivel, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColores.verdeAcento)),
            ),
          ],
        ),
      ),
    );
  }

  void _mostrarBloqueado(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => Container(
        decoration: const BoxDecoration(color: AppColores.fondoCard, borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.08), shape: BoxShape.circle),
              child: const Icon(Icons.lock, color: Colors.white, size: 32),
            ),
            const SizedBox(height: 16),
            const Text('Contenido bloqueado', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white)),
            const SizedBox(height: 8),
            Text('Necesitas una membresía activa para acceder a las rutinas. Habla con el administrador del gym.', textAlign: TextAlign.center, style: TextStyle(fontSize: 14, color: Colors.white.withValues(alpha: 0.6), height: 1.5)),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

// ==================== DETALLE RUTINA ====================
class PantallaDetalleRutina extends StatelessWidget {
  final Rutina rutina;
  const PantallaDetalleRutina({super.key, required this.rutina});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColores.fondoOscuro,
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            backgroundColor: AppColores.fondoOscuro,
            leading: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.5), shape: BoxShape.circle),
                child: const Icon(Icons.arrow_back, color: Colors.white),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(rutina.imagen, fit: BoxFit.cover),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Colors.transparent, AppColores.fondoOscuro]),
                    ),
                  ),
                  Positioned(
                    left: 20, bottom: 20,
                    child: Text(rutina.titulo.replaceAll('\n', ' '), style: TextStyle(fontSize: 36, fontWeight: FontWeight.w900, color: Colors.white, fontStyle: FontStyle.italic, shadows: [Shadow(color: rutina.colorAccent.withValues(alpha: 0.5), blurRadius: 30)])),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      _infoChip(rutina.duracion, Icons.timer_outlined),
                      _infoChip(rutina.nivel, Icons.speed),
                      _infoChip('${rutina.listaEjercicios.length} ejercicios', Icons.fitness_center),
                    ],
                  ),
                  const SizedBox(height: 28),
                  const Text('EJERCICIOS', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white54, letterSpacing: 1)),
                  const SizedBox(height: 16),
                  ...rutina.listaEjercicios.asMap().entries.map((entry) => _ejercicioItem(entry.key + 1, entry.value)),
                  const SizedBox(height: 24),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      decoration: BoxDecoration(color: AppColores.verdeAcento, borderRadius: BorderRadius.circular(14)),
                      child: const Center(child: Text('Comenzar rutina', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: Colors.black))),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoChip(String texto, IconData icono) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.08), borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icono, size: 16, color: AppColores.verdeAcento),
          const SizedBox(width: 6),
          Text(texto, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.white)),
        ],
      ),
    );
  }

  Widget _ejercicioItem(int numero, Map<String, String> ejercicio) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.05), borderRadius: BorderRadius.circular(14)),
      child: Row(
        children: [
          Container(
            width: 40, height: 40,
            decoration: BoxDecoration(color: AppColores.verdeAcento.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(10)),
            child: Center(child: Text('$numero', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppColores.verdeAcento))),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(ejercicio['nombre']!, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)),
                const SizedBox(height: 4),
                Text(ejercicio['musculo']!, style: TextStyle(fontSize: 13, color: Colors.white.withValues(alpha: 0.5))),
              ],
            ),
          ),
          Text(ejercicio['series']!, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white.withValues(alpha: 0.7))),
        ],
      ),
    );
  }
}
