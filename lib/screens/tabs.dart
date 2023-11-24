import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/Categories.dart';
import 'package:meals/screens/filters.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/main_drwer.dart';

const kInitialFilters = {
  Filter.glutonFree: false,
  Filter.LactoseFree: false, 
  Filter.VegetatianFree: false,
  Filter.VeganFree: false
};

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  int _selectedPageIndex = 0;
  final List<Meal> _favoriteMeals = [];
  Map<Filter, bool> _selectedFilters = kInitialFilters;

  void _showIndoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        )
    );
  }

  void _toggleMealFavoriteStatus(Meal meal ) {
    final isExisting = _favoriteMeals.contains(meal);

    if(isExisting) {
      setState(() {
        _favoriteMeals.remove(meal);
      });
      _showIndoMessage('Meal is no longer a favourite. ');
    } else {
      setState(() {
        _favoriteMeals.add(meal);
      });
      _showIndoMessage('Marked as a favourite. ');
    }
  }

  void _selectedPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
     Navigator.of(context).pop();

    if (identifier == 'filters') {
      final result = await Navigator.of(context).push<Map<Filter, bool>> (
        MaterialPageRoute(builder: (ctx) => FiltersScreen(currentFilters: _selectedFilters ,))
      );
      // print(result);
      setState(() {
        // ?? means if the result is null, it will fall back to initialized values.
        _selectedFilters = result ?? kInitialFilters;
      });
    } 
  }

  @override
  Widget build(BuildContext context) {

    final availableMeals = dummyMeals.where((meal) {
      if (_selectedFilters[Filter.glutonFree]! && !meal.isGlutenFree) {
        return false;
      }
       if (_selectedFilters[Filter.LactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
       if (_selectedFilters[Filter.VegetatianFree]! && !meal.isVegetarian) {
        return false;
      }
       if (_selectedFilters[Filter.VeganFree]! && !meal.isVegan) {
        return false;
      }
      return true;
    }).toList();

    Widget activePage = CategoriesScreen(
      onToggleFavorite: _toggleMealFavoriteStatus,
      availableMeals: availableMeals,
    );

    var activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      // final favoriteMeals = ref.watch(favoriteMealsProvider);
      activePage = MealsScreen(
        meals: _favoriteMeals,
        onToggleFavorite: _toggleMealFavoriteStatus,
      );
      activePageTitle = 'Your Favorites';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(
        onSelectScreen: _setScreen,
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectedPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
