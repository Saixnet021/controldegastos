import 'package:cloud_firestore/cloud_firestore.dart';

class Gasto {
  final String id;
  final double monto;
  final String descripcion;
  final DateTime fecha;

  Gasto({
    required this.id,
    required this.monto,
    required this.descripcion,
    required this.fecha,
  });

  factory Gasto.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Gasto(
      id: doc.id,
      monto: data['monto'] as double,
      descripcion: data['descripcion'] as String,
      fecha: (data['fecha'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'monto': monto,
      'descripcion': descripcion,
      'fecha': Timestamp.fromDate(fecha),
    };
  }
}
