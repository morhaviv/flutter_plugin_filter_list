import 'package:flutter/material.dart';

typedef ShouldHide<T> = bool Function(T item);

class FilterRule {
  Key key;
  String? choiceName;
  final ShouldHide shouldHide;
  bool selected;

  FilterRule(this.key, this.shouldHide, {this.choiceName, this.selected=false});

  String getName() {
    if (this.choiceName != null) {
      return this.choiceName!;
    }
    return this.key.toString();
  }
}
