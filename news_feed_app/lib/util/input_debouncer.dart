import 'dart:async';

/// Delay the search request respond
/// when typing so it does not use
/// a lot of request every time you type
/// and search.
///
/// MUST call [cancel] on dispose when you are done!
class InputDebouncer {
  final Duration _delay;
  Timer? _timer;

  InputDebouncer({
    Duration delay = const Duration(milliseconds: 300),
  }) : _delay = delay;

  void call(void Function() action) {
    _timer?.cancel();
    _timer = Timer(_delay, action);
  }

  void cancel() => _timer?.cancel();
}
