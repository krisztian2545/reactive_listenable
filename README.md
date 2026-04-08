# Reactive Listenable
A reactive state management library built on top of Listenables.

**Warning:** This is just a naive implementation for learning purposes!

## Features

- small API (Reactive, AsyncReactive, Effect)
- lazy loading
- push based reactivity
- optional auto dispose functionality
- batching state updates
- observable state transitions
- compatible with Widgets using Listenables

## Usage

```dart
// Root state
final counter = StateNotifier(0);

// Derived state
final counterDoubled = Reactive((watch) => watch(counter).value * 2);

// Asynchronous state
final counterDelayed = AsyncReactive((watch) async {
    final count = watch(counter).value;
    await Future.delayed(Duration(seconds: 3));
    return count;
});

// Side effect
final saveCounterEffect = Effect((watch) {
    final count = watch(counter).value;
    print('saving counter value: $count');
    // save value
});

// In Flutter
ValueListenableBuilder(
  valueListenable: counterDelayed,
  builder: (context, value, _) {
    return value.when(
      loading: CircularProgressIndicator.new,
      error: (error, stack) => Text('Error: $error\nStack: $stack'),
      data: (data) => Text('$value'),
    );
  },
);
```