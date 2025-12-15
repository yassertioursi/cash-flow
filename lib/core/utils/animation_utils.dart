import 'package:flutter/animation.dart';

class AnimationUtils {

  const AnimationUtils._();

  static const Duration fastDuration = Duration(milliseconds: 150);
  static const Duration normalDuration = Duration(milliseconds: 300);
  static const Duration slowDuration = Duration(milliseconds: 500);
  static const Duration pageTransitionDuration = Duration(milliseconds: 350);

  static const Duration none = Duration.zero;

  static Duration getDuration(bool enableAnimations, [Duration? targetDuration]) {
    if (!enableAnimations) return none;
    return targetDuration ?? normalDuration;
  }

  static Duration fast(bool enableAnimations) => getDuration(enableAnimations, fastDuration);

  static Duration normal(bool enableAnimations) => getDuration(enableAnimations, normalDuration);

  static Duration slow(bool enableAnimations) => getDuration(enableAnimations, slowDuration);

  static Duration pageTransition(bool enableAnimations) => getDuration(enableAnimations, pageTransitionDuration);

  static const Curve defaultCurve = Curves.easeInOut;
  static const Curve bounceCurve = Curves.elasticOut;
  static const Curve sharpCurve = Curves.easeOutCubic;
  static const Curve fadeInCurve = Curves.easeIn;
  static const Curve fadeOutCurve = Curves.easeOut;
}
