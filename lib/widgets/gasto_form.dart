import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/gasto_viewmodel.dart';

class GastoForm extends StatelessWidget {
  const GastoForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GastoViewModel>(
      builder: (context, viewModel, child) {
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFF1E1E1E),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: const Color(0xFFFF1744).withOpacity(0.3),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFFF1744).withOpacity(0.2),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            children: [
              TextField(
                controller: viewModel.montoController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Monto'),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: viewModel.descController,
                decoration: const InputDecoration(labelText: 'Descripción'),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: viewModel.agregarGasto,
                  icon: const Icon(Icons.add_circle_outline, size: 24),
                  label: const Text(
                    'Agregar',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
