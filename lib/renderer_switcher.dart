import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

enum WebRenderer { html, canvaskit, auto }

abstract class RendererSwitcher {
  static const MethodChannel _channel = MethodChannel('renderer_switcher');

  static void switchWebRenderer(WebRenderer renderer) {
    _channel.invokeMethod('switchWebRenderer', {
      'rendererCode': describeEnum(renderer),
    });
  }

  static Future<WebRenderer> getCurrentWebRenderer() async {
    final webRenderer =
        await _channel.invokeMethod<String?>('getCurrentWebRenderer');

    if (webRenderer == 'html') return WebRenderer.html;
    if (webRenderer == 'canvaskit') return WebRenderer.canvaskit;
    return WebRenderer.auto;
  }
}
