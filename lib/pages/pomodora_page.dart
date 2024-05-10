import 'package:flutter/material.dart';
import 'package:pomodoro/store/pomodoro.store.dart';
import 'package:pomodoro/widgets/cronometro_widget.dart';
import 'package:pomodoro/widgets/entrada_tempo_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class PomodoroPage extends StatelessWidget {
  const PomodoroPage({super.key});

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<PomodoroStore>(context);
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Expanded(
            child: CronometroWidget(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 40,
            ),
            child: Observer(
              builder: (_) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  EntradaTempoWidget(
                    titulo: 'Trabalho',
                    valor: store.tempoTrabalho,
                    inc: store.iniciado && store.estaTrabalhando
                        ? null
                        : store.incrementTrabalho,
                    dec: store.iniciado && store.estaTrabalhando
                        ? null
                        : store.decrementTrabalho,
                  ),
                  EntradaTempoWidget(
                    titulo: 'Descanco',
                    valor: store.tempoDescanso,
                    inc: store.iniciado && store.estaDescansando
                        ? null
                        : store.incrementDescanso,
                    dec: store.iniciado && store.estaDescansando
                        ? null
                        : store.decrementDescanso,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
