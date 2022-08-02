import 'dart:async';

import 'package:redesprou_boilerplate_name/utils/string_utils.dart';

// Util criado para fazer o debounce (atraso) na execução de chamadas
// repetidas dentro de um intervalo especificado (debounceDuration)
class Debouncer {
  Timer? _debounceTimer;

  bool? _debounceTimerIsDone;

  Debouncer() {
    this._debounceTimer = Timer(Duration(milliseconds: 0), () => _debounceTimerIsDone = true);
    this._debounceTimerIsDone = true;
  }

  Future<T> debounce<T>(Duration debounceDuration, T Function() function) async {
    Completer<T> completer = Completer<T>();
    if (isTrue(_debounceTimerIsDone)) {
      completer.complete(function());
      _debounceTimerIsDone = false;
      _debounceTimer = Timer(debounceDuration, () => _debounceTimerIsDone = true);
    } else if (this._debounceTimer!.isActive) {
      this._debounceTimer!.cancel();
      _debounceTimer = Timer(debounceDuration, () {
        completer.complete(function());
        _debounceTimerIsDone = true;
      });
    }
    return completer.future;
  }
}
