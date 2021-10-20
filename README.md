# renderer_switcher

Swap Web Renderers in a Flutter Web app at runtime.

## Installation

To use this plugin, add renderer_switcher as a [dependency in your pubspec.yaml file](https://flutter.dev/platform-plugins/).

Then, add this script to the top of the body in your `web/index.html` file.

```html
  <script type="text/javascript">
    window.flutterWebRenderer = localStorage.getItem('flutterWebRenderer');
  </script>
```

## Usage

```dart
// Returns WebRenderer.html, WebRenderer.canvaskit or WebRenderer.auto
final currentRenderer = await RendererSwitcher.getCurrentWebRenderer();

if(currentRenderer == WebRenderer.canvaskit){
    // Switches web renderer to canvaskit and reloads the window.
    RendererSwitcher.switchWebRenderer(WebRenderer.auto);
}
```
