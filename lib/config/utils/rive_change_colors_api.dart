import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rive/math.dart';
import 'package:rive/rive.dart';

/// Represents a color component of a Rive animation.
class RiveColorComponent {
  final String shapeName;
  final String? fillName;
  final Color color;
  final String? strokeName;

  Shape? shape;
  Fill? fill;
  Stroke? stroke;

  /// Creates a [RiveColorComponent].
  ///
  /// The [shapeName] is the name of the shape in the Rive animation.
  /// The [fillName] is the name of the fill in the shape. Either [fillName]
  /// or [strokeName] must be provided, but not both.
  /// The [color] is the color to be applied to the component.
  RiveColorComponent({
    required this.shapeName,
    this.fillName,
    this.strokeName,
    required this.color,
  }) : assert(fillName == null || strokeName == null,
            "Fill or stroke name must be provided, but not both");

  /// Overrides the equality operator for the [RiveColorComponent] class.
  ///
  /// Returns `true` if the [other] object is equal to this [RiveColorComponent]
  /// object, `false` otherwise.
  ///
  /// Two [RiveColorComponent] objects are considered equal if their [fillName],
  ///  [shapeName], [strokeName], and [color] properties are all equal.
  @override
  bool operator ==(covariant RiveColorComponent other) {
    if (identical(this, other)) return true;

    return other.fillName == fillName &&
        other.shapeName == shapeName &&
        other.strokeName == strokeName &&
        other.color == color;
  }

  /// Overrides the default hashCode getter to calculate the hash code based
  /// on the values of [fillName], [shapeName], [strokeName], and [color].
  @override
  int get hashCode {
    return fillName.hashCode ^
        shapeName.hashCode ^
        strokeName.hashCode ^
        color.hashCode;
  }
}

/// A widget that modifies the colors of a Rive animation.
class RiveColorModifier extends LeafRenderObjectWidget {
  final Artboard artboard;
  final BoxFit fit;
  final Alignment alignment;
  final List<RiveColorComponent> components;

  /// Creates a [RiveColorModifier].
  ///
  /// The [artboard] is the Rive animation to modify.
  /// The [fit] determines how the animation is fitted into the widget.
  /// The [alignment] determines the alignment of the animation within the widget.
  /// The [components] is a list of [RiveColorComponent]s that define the color modifications to apply.
  const RiveColorModifier({
    super.key,
    required this.artboard,
    this.fit = BoxFit.contain,
    this.alignment = Alignment.center,
    this.components = const [],
  });

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RiveCustomRenderObject(artboard as RuntimeArtboard)
      ..artboard = artboard
      ..fit = fit
      ..alignment = alignment
      ..components = components;
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant RiveCustomRenderObject renderObject) {
    renderObject
      ..artboard = artboard
      ..fit = fit
      ..alignment = alignment
      ..components = components;
  }

  @override
  void didUnmountRenderObject(covariant RiveCustomRenderObject renderObject) {
    renderObject.dispose();
  }
}

/// A custom Rive render object that taps into the draw method to modify colors.
class RiveCustomRenderObject extends RiveRenderObject {
  List<RiveColorComponent> _components = [];

  RiveCustomRenderObject(super.artboard);

  /// The list of [RiveColorComponent]s that define the color modifications to apply.
  List<RiveColorComponent> get components => _components;

  /// Setter method for the [components] property.
  /// Updates the list of [RiveColorComponent] objects and performs necessary operations.
  /// Throws exceptions if the required shapes, fills, or strokes are not found.
  /// Triggers a repaint of the widget.
  set components(List<RiveColorComponent> value) {
    if (listEquals(_components, value)) {
      return;
    }
    _components = value;

    for (final component in _components) {
      component.shape = artboard.objects.firstWhere(
        (object) => object is Shape && object.name == component.shapeName,
        orElse: () => null,
      ) as Shape?;

      if (component.shape != null &&
          component.fillName != null &&
          component.shape!.fills.isNotEmpty) {
        try {
          component.fill = component.shape!.fills.firstWhere(
            (fill) => fill.name == component.fillName,
          );
        } catch (e) {
          component.fill = null;
        }

        if (component.fill == null) {
          throw Exception(
            "Could not find fill named: ${component.fillName}",
          );
        }
      } else if (component.shape != null &&
          component.strokeName != null &&
          component.shape!.strokes.isNotEmpty) {
        try {
          component.stroke = component.shape!.strokes
              .firstWhere((stroke) => stroke.name == component.strokeName);
        } catch (e) {
          component.stroke = null;
        }

        if (component.stroke == null) {
          throw Exception(
            "Could not find stroke named: ${component.strokeName}",
          );
        }
      } else {
        throw Exception("Could not find shape named: ${component.shapeName}");
      }
    }

    markNeedsPaint();
  }

  /// Overrides the [draw] method of the parent class to change the colors of the components.
  ///
  /// This method iterates through the list of components and updates their fill or stroke colors
  /// based on the component's color and alpha value. If a component has both fill and stroke,
  /// the fill color will be updated. If a component has neither fill nor stroke, an exception
  /// will be thrown.
  ///
  /// After updating the colors, the method calls the [draw] method of the parent class to
  /// draw the components on the canvas.
  @override
  void draw(Canvas canvas, Mat2D viewTransform) {
    for (final component in _components) {
      if (component.fill != null) {
        component.fill!.paint.color =
            component.color.withAlpha(component.fill!.paint.color.alpha);
      } else if (component.stroke != null) {
        component.stroke!.paint.color =
            component.color.withAlpha(component.stroke!.paint.color.alpha);
      } else {
        throw Exception("Could not find fill or stroke for component");
      }
    }

    super.draw(canvas, viewTransform);
  }
}
