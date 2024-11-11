import 'package:flutter/foundation.dart';
import 'package:reactive_listenable/src/disposable_mixin.dart';
import 'package:reactive_listenable/src/state_notifier.dart';

extension type ReadonlyStateNotifier<T>(StateNotifier<T> _notifier)
    implements ValueListenable<T>, ObservedDisposableMixin {}
