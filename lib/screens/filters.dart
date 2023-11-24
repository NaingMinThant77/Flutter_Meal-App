import 'package:flutter/material.dart';

enum Filter {
  glutonFree,
  LactoseFree,
  VegetatianFree,
  VeganFree,
}

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key, required this.currentFilters});

  final Map<Filter, bool> currentFilters;

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _glutonFreeFilterSet = false;
  var _lactoseFreeFilterSet = false;
  var _vegetarianFilterSet = false;
  var _veganFilterSet = false;

  @override
  void initState() {
    super.initState();
    _glutonFreeFilterSet= widget.currentFilters[Filter.glutonFree]!;
    _lactoseFreeFilterSet= widget.currentFilters[Filter.LactoseFree]!;
    _vegetarianFilterSet= widget.currentFilters[Filter.VegetatianFree]!;
    _veganFilterSet= widget.currentFilters[Filter.VeganFree]!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Filters"),
      ),
      // drawer: MainDrawer(onSelectScreen: (identifier) {
      //   Navigator.of(context).pop();
      //   if (identifier == 'meals') {
      //     Navigator.of(context)
      //       .push(MaterialPageRoute(builder: (ctx) => const TabScreen()));
      //   }
      // }),
      body: WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pop({
            Filter.glutonFree: _glutonFreeFilterSet,
            Filter.LactoseFree: _lactoseFreeFilterSet,
            Filter.VegetatianFree: _vegetarianFilterSet,
            Filter.VeganFree: _veganFilterSet
          });
          return false;
        } ,
        child: Column(children: [
          SwitchListTile(
            value: _glutonFreeFilterSet, 
            onChanged: (isChecked) {
              setState(() {
                _glutonFreeFilterSet = isChecked;
              });
            },
            title: Text("Gluton Free",
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
            ),
            subtitle: Text("Only include gluton-free meals",
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
            ),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(left: 34, right: 22),
          ),
         SwitchListTile(
            value: _lactoseFreeFilterSet, 
            onChanged: (isChecked) {
              setState(() {
                _lactoseFreeFilterSet = isChecked;
              });
            },
            title: Text( 'Lactose-free',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
            ),
            subtitle: Text("Only include Lactose-free meals",
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
            ),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(left: 34, right: 22),
          ),
          SwitchListTile(
            value: _vegetarianFilterSet, 
            onChanged: (isChecked) {
              setState(() {
                _vegetarianFilterSet = isChecked;
              });
            },
            title: Text("Vegetatian Free",
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
            ),
            subtitle: Text("Only include Vegetatian-free meals",
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
            ),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(left: 34, right: 22),
          ),
          SwitchListTile(
            value: _veganFilterSet, 
            onChanged: (isChecked) {
              setState(() {
                _veganFilterSet = isChecked;
              });
            },
            title: Text( 'Vegan-free',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
            ),
            subtitle: Text("Only include Vegan-free meals",
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
            ),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(left: 34, right: 22),
          )
        ]),
      ),
    );
  }
}