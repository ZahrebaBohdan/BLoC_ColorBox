import 'package:flutter/material.dart';
import 'package:flutter_bloc_1/color_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ColorBloc _bloc = ColorBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BloC with stream'),
      ),
      body: Center(
        child: StreamBuilder(
          stream: _bloc.outputStateStream,
          builder: (BuildContext context, AsyncSnapshot<Color> snapshot) {
            return AnimatedContainer(
                height: 100,
                width: 100,
                color: snapshot.data,
                duration: const Duration(milliseconds: 500));
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
