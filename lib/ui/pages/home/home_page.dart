import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_app/router/routers.dart';
import 'package:new_app/ui/pages/home/home_cubit.dart';
import 'package:new_app/ui/pages/home/home_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  final String title = "Home";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final HomeCubit homeCubit = BlocProvider.of<HomeCubit>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) => Text(
                '${state.count}',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, Routes.setting);
                },
                child: const Text("Setting"))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          homeCubit.increment();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
