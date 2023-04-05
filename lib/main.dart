import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_bloc/logic/counter_cubit.dart';
import 'package:youtube_bloc/logic/internet_cubit.dart';

import 'constantas/enums.dart';

void main() {
  runApp(MyApp(connectivityy: Connectivity(),));
}

class MyApp extends StatelessWidget {
  late Connectivity connectivityy;

  MyApp({super.key, required this.connectivityy});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<InternetCubit>(
            create: (context) => InternetCubit(connectivity: connectivityy)),
        BlocProvider<CounterCubit>(create: (context) =>
            CounterCubit(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<InternetCubit, InternetState>(
      listener: (context, state) {
          if (state is InternetConnected &&
              state.connectionType == ConnectionType.Wifi) {
           context.read<CounterCubit>().Increment();
          } else if (state is InternetConnected &&
              state.connectionType == ConnectionType.Mobile) {
            context.read<CounterCubit>().Decrement();
          }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              BlocBuilder<InternetCubit, InternetState>(
                builder: (context, state) {
                  if (state is InternetConnected &&
                      state.connectionType == ConnectionType.Wifi) {
                    return Text('Wifi');
                  } else if (state is InternetConnected &&
                      state.connectionType == ConnectionType.Mobile) {
                    return Text('Mobile');
                  } else {
                    return Text('Disconnected');
                  }
                },
              ),
              BlocConsumer<CounterCubit, CounterState>(
                builder: (context, state) {
                  return Text(
                    state.counterValue.toString(),
                    style: Theme
                        .of(context)
                        .textTheme
                        .headlineMedium,
                  );
                },

                listener: (context, state) {
                  if (state.isIncremented == true) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Incremented'),
                      duration: Duration(milliseconds: 300),
                    )
                    );
                  } else if (state.isIncremented == false) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Decremented'),
                      duration: Duration(milliseconds: 300),
                    )
                    );
                  }
                },
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FloatingActionButton(
                    onPressed: () {
                      context.read<CounterCubit>().Decrement();
                    },
                    tooltip: 'Decrement',
                    child: Icon(Icons.remove),
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      context.read<CounterCubit>().Increment();
                    },
                    tooltip: 'Increment',
                    child: Icon(Icons.add),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
