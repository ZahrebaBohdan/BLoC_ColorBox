import 'package:flutter/material.dart';
import 'package:flutter_bloc_1/color_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ColorBloc _bloc = ColorBloc();

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BloC with stream'),
      ),
      body: Center(
        child: StreamBuilder(
          stream: _bloc.outputStateStream,
          initialData: Colors.grey,
          builder: (BuildContext context, AsyncSnapshot<Color> snapshot) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: AnimatedContainer(
                  height: 100,
                  width: 100,
                  color: snapshot.data,
                  duration: const Duration(milliseconds: 500)),
            );
          },
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            backgroundColor: Colors.green,
            onPressed: () {
              _bloc.inputEventSink.add(ColorEvent.event_green);
            },
          ),
          const SizedBox(
            width: 10,
          ),
          FloatingActionButton(
            backgroundColor: Colors.red,
            onPressed: () {
              _bloc.inputEventSink.add(ColorEvent.event_red);
            },
          ),
        ],
      ),
    );
  }
}
