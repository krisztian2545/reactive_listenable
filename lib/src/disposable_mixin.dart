import 'package:flutter/foundation.dart';
import 'package:reactive_listenable/src/change_observer.dart';

mixin ObservedDisposableMixin {
  final _disposeCallbacks = <VoidCallback>[];

  void onDispose(void Function() callback) => _disposeCallbacks.add(callback);

  void dispose() {
    for (final callback in _disposeCallbacks) {
      try {
        callback();
      } catch (e) {
        ReactiveListenableObserver.observer
            ?.onError(this, e, StackTrace.current);
      }
    }
  }
}
