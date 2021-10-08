import 'package:flutter/material.dart';

typedef ShouldDisplay<T> = bool Function(T item);
typedef OnItemRemove<T> = void Function(T item, int index);
typedef OnItemInsert<T> = void Function(T item, int index);

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

class ListFilter<T> {
  final List<T> listData;
  final List<T> selectedListData;
  final List<FilterRule> filters;
  final OnItemRemove<T>? onItemRemove;
  final OnItemInsert<T>? onItemInsert;

  ListFilter(this.listData, this.selectedListData, this.filters, {this.onItemRemove, this.onItemInsert});

  void filterItems() {
    List<T> newItems = [];
    for (int i = 0; i < listData.length; i++) {
      T element = listData[i];

      bool shouldDisplay = true;
      bool previous = false;
      if (selectedListData.contains(element)) {
        previous = true;
      }
      filters.forEach((filter) {
        if (!filter.shouldDisplay(element)) {
          shouldDisplay = false;
          return;
        }
      });

      if (shouldDisplay) {
        newItems.add(element);
        if (!previous) {
          if (onItemInsert != null) {
            onItemInsert!(element, i);
          }
        }
      } else {
        if (previous) {
          if (onItemRemove != null) {
            onItemRemove!(element, i);
          }
        }
      }
    }
  }
}
