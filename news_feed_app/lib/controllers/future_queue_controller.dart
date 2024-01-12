import 'dart:async';

import 'package:get/get_state_manager/get_state_manager.dart';

class FutureQueueController extends GetxController {
  final _queueChatSend = StreamController<Future<void>>();
  StreamSubscription<void>? _queueChatSendSubs;

  FutureQueueController() {
    _queueChatSendSubs = _queueChatSend.stream
        .asyncMap((future) async => await future)
        .listen((_) {}, cancelOnError: false);
  }

  void addFuture(Future<void> future) {
    _queueChatSend.add(future);
  }

  @override
  void dispose() {
    _queueChatSend.close();
    _queueChatSendSubs?.cancel();
    super.dispose();
  }
}
