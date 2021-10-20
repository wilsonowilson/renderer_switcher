@JS()
library renderer_switcher_web;

// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html show window;
import 'package:flutter/services.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:js/js.dart';

class RendererSwitcherWeb {
  static void registerWith(Registrar registrar) {
    final MethodChannel channel = MethodChannel(
      'renderer_switcher',
      const StandardMethodCodec(),
      registrar,
    );

    final pluginInstance = RendererSwitcherWeb();
    channel.setMethodCallHandler(pluginInstance.handleMethodCall);
  }

  Future<dynamic> handleMethodCall(MethodCall call) async {
    switch (call.method) {
      case 'switchWebRenderer':
        return switchWebRenderer(call.arguments['rendererCode']);
      case 'getCurrentWebRenderer':
        return _flutterWebRenderer ?? 'auto';
      default:
        throw PlatformException(
          code: 'Unimplemented',
          details:
              'renderer_switcher for web doesn\'t implement \'${call.method}\'',
        );
    }
  }

  void switchWebRenderer(String rendererCode) {
    html.window.localStorage['flutterWebRenderer'] = rendererCode;
    html.window.location.reload();
  }
}

@JS('flutterWebRenderer')
external String? get _flutterWebRenderer;
