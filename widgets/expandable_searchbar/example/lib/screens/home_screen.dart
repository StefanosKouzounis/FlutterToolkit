import 'package:expandable_searchbar/expandable_searchbar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final searchController = TextEditingController();
  bool searching = false;

  final groceryList = [
    "Milk",
    "Eggs",
    "Bread",
    "Butter",
    "Cheese",
    "Chicken",
    "Beef",
    "Pasta",
    "Rice",
    "Tomatoes",
    "Lettuce",
    "Carrots",
    "Potatoes",
    "Onions",
    "Garlic",
    "Apples",
    "Bananas",
    "Oranges",
    "Strawberries",
    "Grapes",
    "Yogurt",
    "Cereal",
    "Olive oil",
    "Salt",
    "Pepper"
  ];

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var groceries = searching && searchController.text.trim().isNotEmpty
        ? groceryList
            .where((element) =>
                element
                    .toLowerCase()
                    .contains(searchController.text.toLowerCase()) ||
                element
                    .toLowerCase()
                    .contains(searchController.text.toLowerCase()))
            .toList()
        : groceryList;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        actions: [
          ExpandableSearchbar(
            curve: Curves.linear,
            animationDuration: 500,
            height: 50,
            contentColor: Colors.white,
            backgroundColor: Colors.blue,
            width: MediaQuery.sizeOf(context).width / 2,
            onSearch: () {
              setState(() {
                searching = true;
              });
            },
            controller: searchController,
            hintText: 'Search...',
            onHide: () {
              searchController.clear();
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: groceries.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(groceries[index]),
          );
        },
      ),
    );
  }
}
