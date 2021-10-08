import 'package:flutter/material.dart';

typedef ShouldDisplay<T> = bool Function(T item);

class FilterRule {
  Key key;
  String? choiceName;
  final ShouldDisplay shouldDisplay;
  bool selected;

  FilterRule(this.key, this.shouldDisplay, {this.choiceName, this.selected = false});

  String getName() {
    if (this.choiceName != null) {
      return this.choiceName!;
    }
    return this.key.toString();
  }
}
