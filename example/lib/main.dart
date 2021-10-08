import 'package:custom_filter_list/filter_list.dart';
import 'package:example/classes.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'Filter list example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title}) : super(key: key);
  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<User> selectedUserList = [];

  void _openFilterDialog() async {
    await FilterListDialog.display<User>(
      context,
      listFilter: ListFilter(userList, selectedUserList, [AppFilters.ageFilter, AppFilters.heightFilter]) ,
      height: 480,
      headlineText: "Select Users",
      searchFieldHintText: "Search Here",
      choiceChipLabel: (item) {
        return item!.getName();
      },
      validateSelectedItem: (list, val) {
        return list!.contains(val);
      },

      onItemSearch: (list, text) {
        if (list != null) {
          if (list.any((element) => element.getName().toLowerCase().contains(text.toLowerCase()))) {
            /// return list which contains matches
            return list.where((element) => element.getName().toLowerCase().contains(text.toLowerCase())).toList();
          }
        }

        return [];
      },

      onApplyButtonClick: (list) {
        setState(() {
          selectedUserList = list;
        });
        Navigator.pop(context);
      },

      /// uncomment below code to create custom choice chip
      /* choiceChipBuilder: (context, item, isSelected) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
                border: Border.all(
              color: isSelected! ? Colors.blue[300]! : Colors.grey[300]!,
            )),
            child: Text(
              item.name,
              style: TextStyle(
                  color: isSelected ? Colors.blue[300] : Colors.grey[300]),
            ),
          );
      },*/
    );
  }

  @override
  Widget build(BuildContext context) {
    print("build called");
    print(selectedUserList.toList());

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          TextButton(
            onPressed: () async {
              var list = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FilterPage(
                    allTextList: userList,
                    selectedUserList: selectedUserList,
                  ),
                ),
              );
              if (list != null) {
                setState(() {
                  selectedUserList = List.from(list);
                });
              }
            },
            child: Text(
              "Filter Page",
              style: TextStyle(color: Colors.white),
            ),
            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blue)),
          ),
          TextButton(
            onPressed: _openFilterDialog,
            child: Text(
              "Filter Dialog",
              style: TextStyle(color: Colors.white),
            ),
            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blue)),
            // color: Colors.blue,
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          selectedUserList == null || selectedUserList.length == 0
              ? Expanded(
                  child: Center(
                    child: Text('No text selected'),
                  ),
                )
              : Expanded(
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(selectedUserList[index].name),
                        );
                      },
                      separatorBuilder: (context, index) => Divider(),
                      itemCount: selectedUserList.length),
                ),
        ],
      ),
    );
  }
}

class FilterPage extends StatelessWidget {
  const FilterPage({Key? key, this.allTextList, required this.selectedUserList}) : super(key: key);
  final List<User>? allTextList;
  final List<User> selectedUserList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Filter list Page"),
      ),
      body: SafeArea(
        child: FilterListWidget<User>(
          listFilter: ListFilter(userList, selectedUserList, [AppFilters.ageFilter, AppFilters.heightFilter]) ,
          hideHeaderText: true,
          onApplyButtonClick: (list) {
            Navigator.pop(context, list);
          },
          choiceChipLabel: (item) {
            /// Used to print text on chip
            return "Test";
          },
          choiceChipBuilder: (context, item, isSelected) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                  border: Border.all(
                color: isSelected! ? Colors.blue[300]! : Colors.grey[300]!,
              )),
              child: Text(item.getName()),
            );
          },
          onItemSearch: (list, text) {
            /// When text change in search text field then return list containing that text value
            ///
            ///Check if list has value which matchs to text
            if (list!.any((element) => element.getName().toLowerCase().contains(text.toLowerCase()))) {
              /// return list which contains matches
              return list.where((element) => element.getName().toLowerCase().contains(text.toLowerCase())).toList();
            }
            return [];
          },
        ),
      ),
    );
  }
}