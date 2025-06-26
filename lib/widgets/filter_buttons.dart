import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/gasto_viewmodel.dart';

class FilterButtons extends StatelessWidget {
  const FilterButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GastoViewModel>(
      builder: (context, viewModel, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                viewModel.obtenerTextoFiltro(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF1E1E1E),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFFF1744), width: 1),
              ),
              child: TextButton.icon(
                onPressed: () => viewModel.seleccionarFecha(context),
                icon: const Icon(
                  Icons.calendar_today,
                  color: Color(0xFFFF1744),
                  size: 20,
                ),
                label: const Text(
                  'Fecha',
                  style: TextStyle(
                    color: Color(0xFFFF1744),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF1E1E1E),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFFF1744), width: 1),
              ),
              child: TextButton.icon(
                onPressed: () => viewModel.seleccionarMes(context),
                icon: const Icon(
                  Icons.date_range,
                  color: Color(0xFFFF1744),
                  size: 20,
                ),
                label: const Text(
                  'Mes',
                  style: TextStyle(
                    color: Color(0xFFFF1744),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
