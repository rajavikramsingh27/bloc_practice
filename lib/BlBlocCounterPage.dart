
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlBlocCounterPage extends StatelessWidget {
  const BlBlocCounterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /*
    BlocProvider manage's bloc lifecycle,
     */
    return BlocProvider(
      create: (BuildContext context) => BlBlocCounterBloc()..add(InitEvent()),
      child: Builder(builder: (context) => _buildPage(context)),
    );
  }

  Widget _buildPage(BuildContext context) {
    // Section one
    final bloc = BlocProvider.of<BlBlocCounterBloc>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Bloc-Bloc Example')),
      body: Center(
        //Section two
        child: BlocBuilder<BlBlocCounterBloc, BlBlocCounterState>(
          builder: (context, state) {
            return Text(
              'Pressed ${bloc.state.count} times',
              style: TextStyle(fontSize: 30.0),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => bloc.add(CounterIncrementEvent()),
      ),
    );
  }
}







class BlBlocCounterBloc extends Bloc<BlBlocCounterEvent, BlBlocCounterState> {
  BlBlocCounterBloc() : super(BlBlocCounterState().init()) {
    on<BlBlocCounterEvent>((event, emit) async {
      try {
        // emit(await init());

        if (event is InitEvent) {
          emit(await init());
        } else if (event is CounterIncrementEvent) {
          emit(increment());
        }
      } on Exception {
        emit(await error());
      }
    });
  }

  Future<BlBlocCounterState> init() async {
    return state.clone();
  }

  ///自增
  BlBlocCounterState increment() {
    return state.clone()..count = ++state.count;
  }



  Future<BlBlocCounterState> error() async {
    return state.clone()..count = -1;
  }
}



abstract class BlBlocCounterEvent {}

class InitEvent extends BlBlocCounterEvent {}

class CounterIncrementEvent extends BlBlocCounterEvent {}



class BlBlocCounterState {
  late int count;

  BlBlocCounterState init() {
    return BlBlocCounterState()..count = 0;
  }

  BlBlocCounterState clone() {
    return BlBlocCounterState()..count = count;
  }

}


