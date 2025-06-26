import 'package:flutter/material.dart';
import '../widgets/filter_buttons.dart';
import '../widgets/gasto_form.dart';
import '../widgets/gasto_list.dart';
import '../widgets/totales_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text('Mis Gastos Diarios'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF000000), Color(0xFF1A1A1A), Color(0xFF2D0A0A)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.0, 0.6, 1.0],
          ),
        ),
        child: const Padding(
          padding: EdgeInsets.only(top: 80, left: 16, right: 16),
          child: Column(
            children: [
              FilterButtons(),
              SizedBox(height: 10),
              TotalesWidget(),
              GastoForm(),
              Expanded(child: GastoList()),
            ],
          ),
        ),
      ),
    );
  }
}
