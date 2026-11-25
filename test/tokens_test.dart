import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:stem_union/utils/constants/tf_tokens.dart';

double _contrastRatio(Color foreground, Color background) {
  final l1 = foreground.computeLuminance();
  final l2 = background.computeLuminance();
  final lighter = math.max(l1, l2);
  final darker = math.min(l1, l2);
  return (lighter + 0.05) / (darker + 0.05);
}

void main() {
  group('TF design tokens WCAG 2.2 AA contrast', () {
    test('light surface ink, brand, accentText, and signal pass 4.5:1 AA', () {
      for (final surface in [
        TfTokens.surface,
        TfTokens.canvas,
        TfTokens.surfaceSunken,
      ]) {
        expect(_contrastRatio(TfTokens.text, surface), greaterThanOrEqualTo(4.5));
        expect(
          _contrastRatio(TfTokens.textMuted, surface),
          greaterThanOrEqualTo(4.5),
        );
        expect(
          _contrastRatio(TfTokens.brand, surface),
          greaterThanOrEqualTo(4.5),
        );
        expect(
          _contrastRatio(TfTokens.accentText, surface),
          greaterThanOrEqualTo(4.5),
        );
      }
      expect(
        _contrastRatio(TfTokens.signal, TfTokens.canvas),
        greaterThanOrEqualTo(4.5),
      );
    });

    test('dark surface text, brand, and accentText pass 4.5:1 AA', () {
      for (final surface in [TfTokens.darkCanvas, TfTokens.darkSurface]) {
        expect(
          _contrastRatio(TfTokens.darkText, surface),
          greaterThanOrEqualTo(4.5),
        );
        expect(
          _contrastRatio(TfTokens.darkBrand, surface),
          greaterThanOrEqualTo(4.5),
        );
        expect(
          _contrastRatio(TfTokens.darkAccentText, surface),
          greaterThanOrEqualTo(4.5),
        );
      }
    });
  });
}
