part of 'filter_list_dialog.dart';

typedef ValidateSelectedItem<FilterRule> = bool Function(List<FilterRule>? list, FilterRule item);
typedef OnApplyButtonClick<T> = Function(List<T> list);
typedef ChoiceChipBuilder<FilterRule> = Widget Function(BuildContext context, FilterRule? item, bool? iselected);
typedef ItemSearchDelegate<FilterRule> = List<FilterRule> Function(List<FilterRule>? list, String text);
typedef LabelDelegate<FilterRule> = String? Function(FilterRule?);
typedef ValidateRemoveItem<FilterRule> = List<FilterRule> Function(List<FilterRule>? list, FilterRule item);
typedef OnItemRemove<T> = void Function(T item, int index);
typedef OnItemInsert<T> = void Function(T item, int index);
typedef ItemsCompare<T> = bool Function(T item1, T item2);

/// The [FilterListWidget] is a widget with some filter utilities and callbacks which helps in single/multiple selection from list of data.
///
/// {@macro arguments}
///
/// ### This example shows how to use [FilterListWidget]
///  ``` dart
///  FilterListWidget<String>(
///    listData: ["One","Two","Three", "Four","five", "Six","Seven","Eight","Nine","Ten"],
///    selectedListData: ["One", "Three", "Four", "Eight", "Nine"],
///    hideHeaderText: true,
///    height: MediaQuery.of(context).size.height,
///    // hideHeaderText: true,
///    onApplyButtonClick: (list) {
///      Navigator.pop(context, list);
///    },
///    choiceChipLabel: (item) {
///      /// Used to print text on chip
///      return item;
///    },
///    validateSelectedItem: (list, val) {
///      ///  identify if item is selected or not
///      return list!.contains(val);
///    },
///    onItemSearch: (list, text) {
///      /// When text change in search text field then return list containing that text value
///      ///
///      ///Check if list has value which matchs to text
///      if (list!.any((element) =>
///          element.toLowerCase().contains(text.toLowerCase()))) {
///        /// return list which contains matches
///        return list
///            .where((element) =>
///                element.toLowerCase().contains(text.toLowerCase()))
///            .toList();
///      }
///      return [];
///    },
///   )
/// ```
class FilterListWidget<T> extends StatefulWidget {
  const FilterListWidget({
    Key? key,
    this.height,
    this.width,
    required this.choiceChipLabel,
    required this.onItemSearch,
    required this.listFilter,
    this.borderRadius = 20,
    this.onApplyButtonClick,
    this.choiceChipBuilder,
    this.selectedChipTextStyle,
    this.unselectedChipTextStyle,
    this.controlButtonTextStyle,
    this.applyButtonTextStyle,
    this.headerTextStyle,
    this.searchFieldTextStyle,
    this.headlineText = "Select",
    this.searchFieldHintText = "Search here",
    this.hideSelectedTextCount = false,
    this.hideSearchField = false,
    this.hideCloseIcon = true,
    this.hideHeader = false,
    this.hideHeaderText = false,
    this.closeIconColor = Colors.black,
    this.headerTextColor = Colors.black,
    this.applyButtonTextBackgroundColor = Colors.blue,
    this.backgroundColor = Colors.white,
    this.searchFieldBackgroundColor = const Color(0xfff5f5f5),
    this.selectedTextBackgroundColor = Colors.blue,
    this.unselectedTextBackgroundColor = const Color(0xfff8f8f8),
    this.enableOnlySingleSelection = false,
    this.allButtonText = 'All',
    this.applyButtonText = 'Apply',
    this.resetButtonText = 'Reset',
    this.selectedFiltersText = 'selected filters',
    this.controlContainerDecoration = const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(25)),
      boxShadow: <BoxShadow>[
        BoxShadow(
          offset: Offset(0, 5),
          blurRadius: 15,
          color: Color(0x12000000),
        )
      ],
    ),
    this.buttonRadius,
    this.buttonSpacing,
    this.wrapAlignment = WrapAlignment.start,
    this.wrapCrossAxisAlignment = WrapCrossAlignment.start,
    this.wrapSpacing = 0.0,
  }) : super(key: key);
  final double? height;
  final double? width;
  final double borderRadius;

  final Color? closeIconColor;
  final Color? headerTextColor;
  final Color? backgroundColor;
  final Color? applyButtonTextBackgroundColor;
  final Color? searchFieldBackgroundColor;
  final Color? selectedTextBackgroundColor;
  final Color? unselectedTextBackgroundColor;

  final String headlineText;
  final String searchFieldHintText;
  final bool hideSelectedTextCount;
  final bool hideSearchField;

  /// TextStyle for chip when selected.
  final TextStyle? selectedChipTextStyle;

  /// TextStyle for chip when not selected.
  final TextStyle? unselectedChipTextStyle;

  /// TextStyle for `All` and `Reset` button text.
  final TextStyle? controlButtonTextStyle;

  /// TextStyle for `Apply` button.
  final TextStyle? applyButtonTextStyle;

  /// TextStyle for header text.
  final TextStyle? headerTextStyle;

  /// TextStyle for search field text.
  final TextStyle? searchFieldTextStyle;

  /// if true then it hides close icon.
  final bool hideCloseIcon;

  /// If true then it hide complete header section.
  final bool? hideHeader;

  /// If true then it hides the header text.
  final bool? hideHeaderText;

  /// if [enableOnlySingleSelection] is true then it disabled the multiple selection.
  /// and enabled the single selection model.
  ///
  /// Defautl value is `false`
  final bool? enableOnlySingleSelection;

  /// The `onApplyButtonClick` is a callback which return list of all selected items on apply button click.  if no item is selected then it will return empty list.
  final OnApplyButtonClick<T>? onApplyButtonClick;

  /// The `onItemSearch` is delagate which filter the list on the basis of search field text.
  final ItemSearchDelegate<FilterRule> onItemSearch;

  /*required*/

  /// The `choiceChipLabel` is callback which required [String] value to display text on choice chip.
  final LabelDelegate<FilterRule> choiceChipLabel;

  /*required*/

  /// The `listFilter` is an object containing all the filter rules and it manages the list's items.
  final ListFilter listFilter;

  /*required*/

  /// The `choiceChipBuilder` is a builder to design custom choice chip.
  final ChoiceChipBuilder? choiceChipBuilder;

  /// Apply Button Label
  final String? applyButtonText;

  /// Reset Button Label
  final String? resetButtonText;

  /// All Button Label
  final String? allButtonText;

  /// Selected items count text
  final String? selectedFiltersText;

  /// Control button actions container styling
  /// ``` dart
  ///  const BoxDecoration(
  ///   color: Colors.white,
  ///   borderRadius: BorderRadius.all(Radius.circular(25)),
  ///   boxShadow: <BoxShadow>[
  ///     BoxShadow(
  ///       offset: Offset(0, 5),
  ///       blurRadius: 15,
  ///       color: Color(0x12000000),
  ///     )
  ///   ],
  /// ),
  /// ```
  final BoxDecoration? controlContainerDecoration;

  /// Control button radius
  final double? buttonRadius;

  /// Spacing between control buttons
  final double? buttonSpacing;

  /// How the choice chip within a run should be placed in the main axis.
  /// For example, if [wrapSpacing] is [WrapAlignment.center], the choice chip in each run are grouped together in the center of their run in the main axis.
  ///
  /// Defaults to [WrapAlignment.start].
  final WrapAlignment wrapAlignment;

  /// How the choice chip within a run should be aligned relative to each other in the cross axis.
  ///For example, if this is set to [WrapCrossAlignment.end], and the [direction] is [Axis.horizontal], then the choice chip within each run will have their bottom edges aligned to the bottom edge of the run.
  ///
  ///Defaults to [WrapCrossAlignment.start].
  final WrapCrossAlignment wrapCrossAxisAlignment;

  ///How much space to place between choice chip in a run in the main axis.
  ///For example, if [wrapSpacing] is 10.0, the choice chip will be spaced at least 10.0 logical pixels apart in the main axis.
  ///If there is additional free space in a run (e.g., because the wrap has a minimum size that is not filled or because some runs are longer than others), the additional free space will be allocated according to the [alignment].
  ///
  ///Defaults to 0.0.
  final double wrapSpacing;

  @override
  _FilterListWidgetState<T> createState() => _FilterListWidgetState<T>();
}

class _FilterListWidgetState<T> extends State<FilterListWidget<T>> {

  var listFilter;

  @override
  void initState() {
    listFilter = widget.listFilter;
    super.initState();
  }

  bool showApplyButton = false;

  Widget _body() {
    return Container(
      child: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              widget.hideHeader! ? SizedBox() : _header(),
              widget.hideSelectedTextCount
                  ? SizedBox()
                  : Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: Text(
                        '${listFilter.getSelectedFilters().length} ${widget.selectedFiltersText}',
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ),
              Expanded(
                  child: Container(
                padding: EdgeInsets.only(top: 0, bottom: 0, left: 5, right: 5),
                child: SingleChildScrollView(
                  child: Wrap(
                    alignment: widget.wrapAlignment,
                    crossAxisAlignment: widget.wrapCrossAxisAlignment,
                    spacing: widget.wrapSpacing,
                    children: _buildChoiceList(),
                  ),
                ),
              )),
            ],
          ),
          _controlButtonSection()
        ],
      ),
    );
  }

  Widget _header() {
    return Container(
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        boxShadow: <BoxShadow>[
          BoxShadow(
            offset: Offset(0, 5),
            blurRadius: 15,
            color: Color(0x12000000),
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(),
                ),
                Expanded(
                  flex: 6,
                  child: Center(
                    child: widget.hideHeaderText!
                        ? Container()
                        : Text(
                            widget.headlineText,
                            style: widget.headerTextStyle ?? Theme.of(context).textTheme.headline4!.copyWith(fontSize: 18, color: widget.headerTextColor),
                          ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: InkWell(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    onTap: () {
                      Navigator.pop(context, null);
                    },
                    child: widget.hideCloseIcon
                        ? SizedBox()
                        : Container(
                            height: 25,
                            width: 25,
                            decoration: BoxDecoration(border: Border.all(color: widget.closeIconColor!), shape: BoxShape.circle),
                            child: Icon(
                              Icons.close,
                              color: widget.closeIconColor,
                            ),
                          ),
                  ),
                ),
              ],
            ),
            widget.hideSearchField
                ? SizedBox()
                : SizedBox(
                    height: 10,
                  ),
            widget.hideSearchField
                ? SizedBox()
                : SearchFieldWidget(
                    searchFieldBackgroundColor: widget.searchFieldBackgroundColor,
                    searchFieldHintText: widget.searchFieldHintText,
                    searchFieldTextStyle: widget.searchFieldTextStyle,
                    onChanged: (String value) {
                      setState(() {
                        // if (value.isEmpty) {
                        //   _listData = widget.listData;
                        //   return;
                        // }
                        listFilter.filters = widget.onItemSearch(listFilter.filters, value);
                      });
                    },
                  )
          ],
        ),
      ),
    );
  }

  List<Widget> _buildChoiceList() {
    List<Widget> choices = [];
    listFilter.filters.forEach(
      (item) {
        choices.add(
          ChoiceChipWidget(
            choiceChipBuilder: widget.choiceChipBuilder,
            item: item,
            onSelected: (value) {
              setState(
                () {
                  if (widget.enableOnlySingleSelection!) {
                    listFilter.filters.forEach((anotherItem) {
                      anotherItem.selected = false;
                    });
                    item.selected = true;
                  } else {
                    item.selected = !item.selected;
                  }
                },
              );
            },
            selected: item.selected,
            selectedTextBackgroundColor: widget.selectedTextBackgroundColor,
            unselectedTextBackgroundColor: widget.unselectedTextBackgroundColor,
            selectedChipTextStyle: widget.selectedChipTextStyle,
            unselectedChipTextStyle: widget.unselectedChipTextStyle,
            text: widget.choiceChipLabel(item),
          ),
        );
      },
    );
    choices.add(
      SizedBox(
        height: 70,
        width: MediaQuery.of(context).size.width,
      ),
    );
    return choices;
  }

  Widget _controlButton(
      {required String choiceChipLabel, Function? onPressed, Color backgroundColor = Colors.transparent, double elevation = 0, TextStyle? textStyle, double? radius}) {
    return TextButton(
      style: ButtonStyle(
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(radius ?? 25)),
          )),
          backgroundColor: MaterialStateProperty.all(backgroundColor),
          elevation: MaterialStateProperty.all(elevation),
          foregroundColor: MaterialStateProperty.all(Theme.of(context).buttonColor)),
      onPressed: onPressed as void Function()?,
      clipBehavior: Clip.antiAlias,
      child: Text(
        choiceChipLabel,
        style: textStyle,
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  /// Bottom section for control buttons
  Widget _controlButtonSection() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 45,
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        alignment: Alignment.center,
        child: Container(
          decoration: widget.controlContainerDecoration,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _controlButton(
                  choiceChipLabel: '${widget.allButtonText}',
                  onPressed: widget.enableOnlySingleSelection!
                      ? null
                      : () {
                          setState(() {
                            listFilter.filters.forEach((item) {
                              item.selected = true;
                            });
                          });
                        },
                  // textColor:
                  textStyle: widget.controlButtonTextStyle ??
                      Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(fontSize: 20, color: widget.enableOnlySingleSelection! ? Theme.of(context).dividerColor : Theme.of(context).primaryColor),
                  radius: widget.buttonRadius),
              SizedBox(
                width: widget.buttonSpacing ?? 0,
              ),
              _controlButton(
                  choiceChipLabel: '${widget.resetButtonText}',
                  onPressed: () {
                    setState(() {
                      listFilter.filters.forEach((item) {
                        item.selected = false;
                      });
                    });
                  },
                  textStyle: widget.controlButtonTextStyle ?? Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 20, color: Theme.of(context).primaryColor),
                  radius: widget.buttonRadius),
              SizedBox(
                width: widget.buttonSpacing ?? 0,
              ),
              _controlButton(
                  choiceChipLabel: '${widget.applyButtonText}',
                  onPressed: () {
                    setState(() {
                      listFilter.filterItems();
                    });
                    if (widget.onApplyButtonClick != null) {
                      widget.onApplyButtonClick!(listFilter.selectedListData);
                    }
                    Navigator.pop(context);
                  },
                  elevation: 5,
                  backgroundColor: widget.applyButtonTextBackgroundColor!,
                  textStyle: widget.applyButtonTextStyle ??
                      Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(fontSize: 20, color: widget.enableOnlySingleSelection! ? Theme.of(context).dividerColor : Theme.of(context).buttonColor),
                  radius: widget.buttonRadius),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(widget.borderRadius)),
        child: Container(
          height: widget.height,
          width: widget.width,
          color: widget.backgroundColor,
          child: Stack(
            children: <Widget>[
              _body(),
            ],
          ),
        ),
      ),
    );
  }
}
