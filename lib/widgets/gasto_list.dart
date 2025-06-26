import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/gasto.dart';
import '../viewmodels/gasto_viewmodel.dart';

class GastoList extends StatelessWidget {
  const GastoList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GastoViewModel>(
      builder: (context, viewModel, child) {
        return StreamBuilder<List<Gasto>>(
          stream: viewModel.gastosStream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            // Actualizar gastos en el ViewModel
            WidgetsBinding.instance.addPostFrameCallback((_) {
              viewModel.actualizarGastos(snapshot.data!);
            });

            final gastos = viewModel.gastos;

            if (gastos.isEmpty) {
              return const Center(
                child: Text(
                  'No hay gastos en esta fecha.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            }

            return ListView.builder(
              itemCount: gastos.length,
              itemBuilder: (context, index) {
                final gasto = gastos[index];
                return GastoItem(gasto: gasto);
              },
            );
          },
        );
      },
    );
  }
}

class GastoItem extends StatelessWidget {
  final Gasto gasto;

  const GastoItem({super.key, required this.gasto});

  @override
  Widget build(BuildContext context) {
    final fechaTexto =
        '${gasto.fecha.day}/${gasto.fecha.month}/${gasto.fecha.year}';
    final horaTexto =
        '${gasto.fecha.hour}:${gasto.fecha.minute.toString().padLeft(2, '0')}';

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF2C2C2C),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFFF1744).withOpacity(0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFF1744).withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'S/. ${gasto.monto}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Color(0xFFFF1744),
                ),
              ),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '$fechaTexto $horaTexto',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    onPressed: () =>
                        context.read<GastoViewModel>().eliminarGasto(gasto.id),
                    icon: const Icon(
                      Icons.delete_outline,
                      color: Color(0xFFFF1744),
                      size: 20,
                    ),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(
                      minWidth: 32,
                      minHeight: 32,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            gasto.descripcion,
            style: const TextStyle(color: Colors.white, fontSize: 15),
          ),
        ],
      ),
    );
  }
}
