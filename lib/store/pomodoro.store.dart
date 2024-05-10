import 'dart:async';

import 'package:mobx/mobx.dart';

part 'pomodoro.store.g.dart';

class PomodoroStore = _PomodoroStore with _$PomodoroStore;

enum TipoIntervalo { TRABALHO, DESCANCO }

abstract class _PomodoroStore with Store {
  @observable
  bool iniciado = false;

  @observable
  int minutos = 40;

  @observable
  int segundos = 0;

  @observable
  int tempoTrabalho = 5;

  @observable
  int tempoDescanso = 5;

  @observable
  TipoIntervalo tipoIntervalo = TipoIntervalo.TRABALHO;

  Timer? cronometro;

  @action
  void iniciar() {
    iniciado = true;
    cronometro = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (minutos == 0 && segundos == 0) {
        _trocarIntervalo();
      } else if (segundos == 0) {
        segundos = 59;
        minutos--;
      } else {
        segundos--;
      }
    });
  }

  @action
  void parar() {
    iniciado = false;
    cronometro?.cancel();
  }

  @action
  void reiniciar() {
    parar();
    minutos = estaTrabalhando ? tempoTrabalho : tempoDescanso;
    segundos = 0;
  }

  @action
  void incrementTrabalho() {
    tempoTrabalho++;
    if (estaTrabalhando) reiniciar();
  }

  @action
  void decrementTrabalho() {
    if (tempoTrabalho > 1) {
      tempoTrabalho--;
    }
    if (estaTrabalhando) reiniciar();
  }

  @action
  void incrementDescanso() {
    tempoDescanso++;
    if (estaDescansando) reiniciar();
  }

  @action
  void decrementDescanso() {
    if (tempoDescanso > 1) {
      tempoDescanso--;
    }
    if (estaDescansando) reiniciar();
  }

  bool get estaTrabalhando => tipoIntervalo == TipoIntervalo.TRABALHO;

  bool get estaDescansando => tipoIntervalo == TipoIntervalo.DESCANCO;

  void _trocarIntervalo() {
    if (estaTrabalhando) {
      tipoIntervalo = TipoIntervalo.DESCANCO;
      minutos = tempoDescanso;
    } else {
      tipoIntervalo = TipoIntervalo.TRABALHO;
      minutos = tempoTrabalho;
    }
    segundos = 0;
  }
}
