import 'package:custom_filter_list/filter_list.dart';
import 'package:flutter/material.dart';

class AppFilters {
  static FilterRule ageFilter = FilterRule(Key("ageFilter"), (item) {
    return item.age > 18;
  }, choiceName: "Age: Above 18");
  static FilterRule heightFilter = FilterRule(Key("heightFilter"), (item) {
    return item.height > 1.50;
  }, choiceName: "Height: Above 1.50");
}

class User {
  final String name;
  final int age;
  final double height;
  final String avatar;

  User(this.name, this.age, this.height, this.avatar);
}

/// Creating a global list for example purpose.
/// Generally it should be within data class or where ever you want
List<User> userList = [
  User("Jon", 10, 1.70, "user.png"),
  User("Lindsey", 20, 1.57, "user.png"),
  User("Valarie", 30, 1.60, "user.png"),
  User("Elyse", 40, 1.72, "user.png"),
  User("Ethel", 50, 1.87, "user.png"),
  User("Emelyan", 60, 1.91, "user.png"),
  User("Catherine", 70, 1.45, "user.png"),
  User("Stepanida", 80, 1.49, "user.png"),
  User("Carolina", 90, 1.67, "user.png"),
  User("Nail", 100, 1.84, "user.png"),
];

/// Another exmaple of [FilterListWidget] to filter list of strings
///
/// FilterListWidget<String>(
///   listData: ["One", "Two", "Three", "Four","five","Six","Seven","Eight","Nine","Ten"],
///   selectedListData: ["One", "Three", "Four","Eight","Nine"],
///   hideHeaderText: true,
///   height: MediaQuery.of(context).size.height,
///   // hideHeaderText: true,
///   onApplyButtonClick: (list) {
///     Navigator.pop(context, list);
///   },
///   choiceChipLabel: (item) {
///     /// Used to print text on chip
///     return item;
///   },
///   validateSelectedItem: (list, val) {
///     ///  identify if item is selected or not
///     return list!.contains(val);
///   },
///   onItemSearch: (list, text) {
///     /// When text change in search text field then return list containing that text value
///     ///
///     ///Check if list has value which matchs to text
///     if (list!.any((element) =>
///         element.toLowerCase().contains(text.toLowerCase()))) {
///       /// return list which contains matches
///       return list
///           .where((element) =>
///               element.toLowerCase().contains(text.toLowerCase()))
///           .toList();
///     }
///     return [];
///   },
/// )
