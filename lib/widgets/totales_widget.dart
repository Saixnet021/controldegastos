import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/gasto_viewmodel.dart';

class TotalesWidget extends StatelessWidget {
  const TotalesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GastoViewModel>(
      builder: (context, viewModel, child) {
        final totales = viewModel.totales;
        final fechaSeleccionada = viewModel.fechaSeleccionada;
        final mesSeleccionado = viewModel.mesSeleccionado;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1E1E1E),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: const Color(0xFFFF1744).withOpacity(0.3),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFFF1744).withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (fechaSeleccionada != null)
                    Text(
                      'Total del ${fechaSeleccionada.day}/${fechaSeleccionada.month}/${fechaSeleccionada.year}: S/. ${totales['dia']?.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color(0xFFFF1744),
                      ),
                    )
                  else if (mesSeleccionado != null)
                    Text(
                      'Total de ${mesSeleccionado.month}/${mesSeleccionado.year}: S/. ${totales['mes']?.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color(0xFFFF1744),
                      ),
                    )
                  else ...[
                    Text(
                      'Total de hoy: S/. ${totales['dia']?.toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Total de esta semana: S/. ${totales['semana']?.toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Total de este mes: S/. ${totales['mes']?.toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: Color(0xFFFF1744),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        );
      },
    );
  }
}
