
import 'package:bloc_example/home_screen.dart';
import 'package:bloc_example/logic/fetchlist/fetchlist_bloc.dart';
import 'package:bloc_example/logic/item/item_bloc.dart';
import 'package:bloc_example/screens/home_screen1.dart';
import 'package:bloc_example/services/item_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  final ItemRepository itemRepository= ItemRepository();
  runApp( MyApp(itemRepository: itemRepository,));
}

class MyApp extends StatelessWidget {
 MyApp({super.key, required this.itemRepository});
  final ItemRepository itemRepository;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<FetchlistBloc>(
            create: (context) => FetchlistBloc()..add(Fetchlists()),
          ),
          BlocProvider<ItemBloc>(create: (context) => ItemBloc(itemRepository)..add(LoadItems()),),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'CRUD',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: HomeScreen1(),
        ));
  }
}
