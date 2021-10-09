import 'package:custom_filter_list/filter_list.dart';
import 'package:custom_filter_list/src/filter/filter_rule.dart';
import 'package:flutter/material.dart';


class ListFilter<T> {
  List<T> listData;
  List<T> selectedListData;
  List<FilterRule> filters;

  /// The `onItemRemove` is being called when an item is removed from the selectedList.
  final OnItemRemove<T>? onItemRemove;

  /// The `onItemInsert` is being called when an item is inserted to the selectedList.
  final OnItemInsert<T>? onItemInsert;

  /// The `onItemInsert` is being called when an item is inserted to the selectedList.
  final ItemsCompare<T> itemsCompare;

  ListFilter(this.listData, this.selectedListData, this.filters, {required this.itemsCompare, this.onItemRemove, this.onItemInsert});

  void filterItems() {
    List<T> newItems = [];
    int j = -1;

    for (int i = 0; i < listData.length; i++) {
      T element = listData[i];

      bool shouldDisplay = true;
      bool previous = false;
      if (_checkIfListOfItemsContainer(selectedListData, element)) {
        previous = true;
        j++;
      }
      getSelectedFilters().forEach((filter) {
        if (!filter.shouldDisplay(element)) {
          shouldDisplay = false;
          return;
        }
      });

      if (shouldDisplay) {
        newItems.add(element);
        if (!previous) {
          if (onItemInsert != null) {
            j++;
            onItemInsert!(element, j);
          }
        }
      } else {
        if (previous) {
          if (onItemRemove != null) {
            onItemRemove!(element, j);
            j--;
          }
        }
      }
    }
    selectedListData = newItems;
  }

  bool _checkIfListOfItemsContainer(List<T> items, T item) {
    for (int i = 0; i < items.length; i++) {
      if (itemsCompare(items[i], item)) {
        return true;
      }
    }
    return false;
  }

  List<FilterRule> getSelectedFilters() {
    return filters.where((e) => e.selected).toList();
  }

  void setAllFiltersSelected() {
    return filters.forEach((element) { element.selected = true; });
  }

  void setAllFiltersUnselected() {
    return filters.forEach((element) { element.selected = false; });
  }
}
