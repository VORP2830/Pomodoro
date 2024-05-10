import 'package:mobx/mobx.dart';

part 'package:pomodoro/store/pomodoro.store.g.dart';

class PomodoroStore = _PomodoroStore with _$PomodoroStore;

abstract class _PomodoroStore with Store {
  @observable
  int tempoTrabalho = 2;

  @observable
  int tempoDescanso = 1;

  @action
  void incrementTrabalho() {
    tempoTrabalho++;
  }

  @action
  void decrementTrabalho() {
    if (tempoTrabalho > 1) {
      tempoTrabalho--;
    }
  }

  @action
  void incrementDescanso() {
    tempoDescanso++;
  }

  @action
  void decrementDescanso() {
    if (tempoDescanso > 1) {
      tempoDescanso--;
    }
  }
}
