import 'package:flutter/material.dart';
import '../models/gasto.dart';
import '../services/gasto_service.dart';

class GastoViewModel extends ChangeNotifier {
  final GastoService _service = GastoService();
  final TextEditingController montoController = TextEditingController();
  final TextEditingController descController = TextEditingController();

  DateTime? _fechaSeleccionada;
  DateTime? _mesSeleccionado;
  List<Gasto> _gastos = [];
  Map<String, double> _totales = {'dia': 0, 'semana': 0, 'mes': 0};

  // Getters
  DateTime? get fechaSeleccionada => _fechaSeleccionada;
  DateTime? get mesSeleccionado => _mesSeleccionado;
  List<Gasto> get gastos => _filtrarGastos();
  Map<String, double> get totales => _totales;

  // Stream de gastos
  Stream<List<Gasto>> get gastosStream => _service.getGastosStream();

  // Filtrar gastos según selección
  List<Gasto> _filtrarGastos() {
    if (_fechaSeleccionada != null) {
      return _service.filtrarPorFecha(_gastos, _fechaSeleccionada!);
    } else if (_mesSeleccionado != null) {
      return _service.filtrarPorMes(_gastos, _mesSeleccionado!);
    }
    return _gastos;
  }

  // Actualizar gastos y totales
  void actualizarGastos(List<Gasto> nuevosGastos) {
    _gastos = nuevosGastos;
    _totales = _service.calcularTotales(nuevosGastos);
    notifyListeners();
  }

  // Seleccionar fecha
  Future<void> seleccionarFecha(BuildContext context) async {
    final hoy = DateTime.now();
    final seleccion = await showDatePicker(
      context: context,
      initialDate: hoy,
      firstDate: DateTime(hoy.year - 5),
      lastDate: DateTime(hoy.year + 5),
    );

    if (seleccion != null) {
      _fechaSeleccionada = seleccion;
      _mesSeleccionado = null;
      notifyListeners();
    }
  }

  // Seleccionar mes
  Future<void> seleccionarMes(BuildContext context) async {
    final hoy = DateTime.now();
    final seleccion = await showDatePicker(
      context: context,
      initialDate: hoy,
      firstDate: DateTime(hoy.year - 5),
      lastDate: DateTime(hoy.year + 5),
      helpText: 'Selecciona un mes',
    );

    if (seleccion != null) {
      _mesSeleccionado = DateTime(seleccion.year, seleccion.month);
      _fechaSeleccionada = null;
      notifyListeners();
    }
  }

  // Agregar gasto
  Future<void> agregarGasto() async {
    final monto = double.tryParse(montoController.text);
    final descripcion = descController.text;

    if (monto == null || descripcion.isEmpty) return;

    await _service.agregarGasto(monto, descripcion);

    // Limpiar campos
    montoController.clear();
    descController.clear();
  }

  // Eliminar gasto
  Future<void> eliminarGasto(String id) async {
    await _service.eliminarGasto(id);
  }

  // Obtener texto del filtro actual
  String obtenerTextoFiltro() {
    if (_fechaSeleccionada != null) {
      return 'Filtrando día: ${_fechaSeleccionada!.day}/${_fechaSeleccionada!.month}/${_fechaSeleccionada!.year}';
    } else if (_mesSeleccionado != null) {
      return 'Filtrando mes: ${_mesSeleccionado!.month}/${_mesSeleccionado!.year}';
    }
    return 'Mostrando todos los gastos';
  }

  @override
  void dispose() {
    montoController.dispose();
    descController.dispose();
    super.dispose();
  }
}
