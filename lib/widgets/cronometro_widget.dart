import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pomodoro/store/pomodoro.store.dart';
import 'package:pomodoro/widgets/cronometro_botao_widget.dart';
import 'package:provider/provider.dart';

class CronometroWidget extends StatelessWidget {
  const CronometroWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<PomodoroStore>(context);
    return Observer(builder: (_) {
      return Container(
        color: store.estaTrabalhando ? Colors.red : Colors.green,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              store.estaTrabalhando ? 'Hora de trabalhar' : 'Hora de descansar',
              style: const TextStyle(
                fontSize: 40,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              '${store.minutos.toString().padLeft(2, '0')}:${store.segundos.toString().padLeft(2, '0')}',
              style: const TextStyle(
                fontSize: 120,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (!store.iniciado)
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: CronometroBotaoWidget(
                      titulo: 'Iniciar',
                      icone: Icons.play_arrow,
                      click: store.iniciar,
                    ),
                  ),
                if (store.iniciado)
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: CronometroBotaoWidget(
                      titulo: 'Parar',
                      icone: Icons.stop,
                      click: store.parar,
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: CronometroBotaoWidget(
                    titulo: 'Reiniciar',
                    icone: Icons.refresh,
                    click: store.reiniciar,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
