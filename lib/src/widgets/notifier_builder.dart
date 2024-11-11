import 'package:flutter/widgets.dart';
import 'package:reactive_listenable/src/reactive_listenable.dart';

class ReactiveBuilder extends StatefulWidget {
  const ReactiveBuilder({
    super.key,
    required this.builder,
  });

  final Widget Function(BuildContext, WatchFunction) builder;

  @override
  State<ReactiveBuilder> createState() => _ReactiveBuilderState();
}

class _ReactiveBuilderState extends State<ReactiveBuilder> {
  final _listenables = <Listenable>[];
  Listenable? _combinedListenable;

  void _handleChange() => setState(() {});

  T watch<T extends Listenable>(T listenable) {
    if (!_listenables.contains(listenable)) {
      _listenables.add(listenable);
    }
    return listenable;
  }

  @override
  Widget build(BuildContext context) {
    _clearListenables();

    final buildedWidget = widget.builder(context, watch);

    _combinedListenable = Listenable.merge(_listenables);
    _combinedListenable?.addListener(_handleChange);

    return buildedWidget;
  }

  void _clearListenables() {
    _combinedListenable?.removeListener(_handleChange);
    _listenables.clear();
  }

  @override
  void dispose() {
    _clearListenables();
    super.dispose();
  }
}
