import 'package:flutter/material.dart';
import 'dart:async';
import 'package:renderer_switcher/renderer_switcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  WebRenderer? _webRenderer;

  @override
  void initState() {
    super.initState();
    getCurrentWebRenderer();
  }

  Future<void> getCurrentWebRenderer() async {
    final currentRenderer = await RendererSwitcher.getCurrentWebRenderer();
    if (!mounted) return;
    setState(() {
      _webRenderer = currentRenderer;
    });
  }

  void toggleRenderer() async {
    final currentRenderer = await RendererSwitcher.getCurrentWebRenderer();

    WebRenderer targetRenderer;
    if (currentRenderer == WebRenderer.html) {
      targetRenderer = WebRenderer.canvaskit;
    } else {
      targetRenderer = WebRenderer.html;
    }
    RendererSwitcher.switchWebRenderer(targetRenderer);
  }

  String get rendererDescription {
    /// Emojis are a great way of identifying what renderer you're on.
    switch (_webRenderer) {
      case WebRenderer.html:
        return 'Html 🚀';
      case WebRenderer.canvaskit:
        return 'Canvaskit 🚀';
      default:
        return 'Auto 🚀';
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Renderer Switcher'),
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Running on $rendererDescription',
                style: Theme.of(context).textTheme.headline5,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: toggleRenderer,
                child: const Text('Toggle Renderer'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
