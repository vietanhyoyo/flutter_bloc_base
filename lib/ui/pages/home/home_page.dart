import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_app/router/routers.dart';
import 'package:new_app/ui/pages/home/home_cubit.dart';
import 'package:new_app/ui/pages/home/home_state.dart';

class HomePage extends StatefulWidget {
   HomePage({super.key});

  final String title = "Home";
  final DateTime nowDate = DateTime.now();
  final alarmSettings = AlarmSettings(
    id: 42,
    dateTime: DateTime(DateTime.now().year, DateTime.now().month,
        DateTime.now().day, DateTime.now().hour, DateTime.now().minute + 1),
    assetAudioPath: 'assets/alarm.mp3',
    loopAudio: true,
    vibrate: true,
    volume: 0.8,
    fadeDuration: 3.0,
    notificationTitle: 'This is the title',
    notificationBody: 'This is the body',
    enableNotificationOnKill: true,
  );

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
