import 'package:flutter/material.dart';

typedef ShouldDisplay<T> = bool Function(T item);

class FilterRule {
  Key key;
  String? choiceName;
  final ShouldDisplay shouldDisplay;
  bool selected;
  bool view;

  FilterRule(this.key, this.shouldDisplay, {this.choiceName, this.selected = false, this.view = true});

  String getName() {
    if (this.choiceName != null) {
      return this.choiceName!;
    }
    return this.key.toString();
  }
}
