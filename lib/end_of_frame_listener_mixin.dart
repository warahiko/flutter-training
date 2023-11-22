import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

mixin EndOfFrameListenerMixin<T extends StatefulWidget> on State<T> {
  @override
  void initState() {
    super.initState();
    unawaited(listenEndOfFrame());
  }

  @protected
  Future<void> listenEndOfFrame() async {
    await SchedulerBinding.instance.endOfFrame;
    onEndOfFrame();
  }

  @protected
  void onEndOfFrame();
}
