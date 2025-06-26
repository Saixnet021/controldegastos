import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/gasto.dart';

class GastoService {
  static final GastoService _instance = GastoService._internal();
  factory GastoService() => _instance;
  GastoService._internal();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collection = 'gastos';

  // Obtener stream de gastos
  Stream<List<Gasto>> getGastosStream() {
    return _firestore
        .collection(_collection)
        .orderBy('fecha', descending: true)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((doc) => Gasto.fromFirestore(doc)).toList(),
        );
  }

  // Agregar nuevo gasto
  Future<void> agregarGasto(double monto, String descripcion) async {
    final gasto = Gasto(
      id: '',
      monto: monto,
      descripcion: descripcion,
      fecha: DateTime.now(),
    );

    await _firestore.collection(_collection).add(gasto.toMap());
  }

  // Eliminar gasto
  Future<void> eliminarGasto(String id) async {
    await _firestore.collection(_collection).doc(id).delete();
  }

  // Filtrar gastos por fecha
  List<Gasto> filtrarPorFecha(List<Gasto> gastos, DateTime fecha) {
    return gastos
        .where(
          (gasto) =>
              gasto.fecha.year == fecha.year &&
              gasto.fecha.month == fecha.month &&
              gasto.fecha.day == fecha.day,
        )
        .toList();
  }

  // Filtrar gastos por mes
  List<Gasto> filtrarPorMes(List<Gasto> gastos, DateTime mes) {
    return gastos
        .where(
          (gasto) =>
              gasto.fecha.year == mes.year && gasto.fecha.month == mes.month,
        )
        .toList();
  }

  // Calcular totales
  Map<String, double> calcularTotales(List<Gasto> gastos) {
    final hoy = DateTime.now();
    final semanaInicio = hoy.subtract(Duration(days: hoy.weekday - 1));
    final mesInicio = DateTime(hoy.year, hoy.month);

    double totalDia = 0;
    double totalSemana = 0;
    double totalMes = 0;

    for (var gasto in gastos) {
      // Total del día
      if (_esMismoDia(gasto.fecha, hoy)) {
        totalDia += gasto.monto;
      }

      // Total de la semana
      if (gasto.fecha.isAfter(
        semanaInicio.subtract(const Duration(seconds: 1)),
      )) {
        totalSemana += gasto.monto;
      }

      // Total del mes
      if (gasto.fecha.isAfter(mesInicio.subtract(const Duration(seconds: 1)))) {
        totalMes += gasto.monto;
      }
    }

    return {'dia': totalDia, 'semana': totalSemana, 'mes': totalMes};
  }

  bool _esMismoDia(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}
