import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:renderer_switcher/renderer_switcher.dart';

void main() {
  const MethodChannel channel = MethodChannel('renderer_switcher');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      switch (methodCall.method) {
        case 'getCurrentWebRenderer':
          return 'canvaskit';
      }
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getCurrentWebRenderer', () async {
    expect(
      await RendererSwitcher.getCurrentWebRenderer(),
      WebRenderer.canvaskit,
    );
  });
}
