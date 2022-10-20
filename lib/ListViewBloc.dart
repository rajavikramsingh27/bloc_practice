import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListViewBloc extends StatelessWidget {
  const ListViewBloc({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocProvider(
        create: (BuildContext context) => ListBLoC()..add(InitEvent()),
        child: Builder(
            builder: (context) {
              final bloc = BlocProvider.of<ListBLoC>(context);
              return BlocBuilder<ListBLoC, ListState>(builder: (context, state) {
                return ListView.builder(
                  itemCount: bloc.state.arrayOfNumbers!.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      child: Container(
                        padding: const EdgeInsets.only(
                          bottom: 16,
                          top: 16,
                        ),
                        decoration: const BoxDecoration(
                            border:  Border(
                                bottom: BorderSide(
                                    color: Colors.blue,
                                    width: 1.5
                                )
                            )
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              bloc.state.arrayOfNumbers![index].toString(),
                              style: const TextStyle(
                                  fontSize: 30,
                                  color: Colors.black,
                                  fontFamily: 'times new roman'
                              ),
                            ),
                            if (bloc.state.arrayOfSelect![index])
                              const Icon(
                                Icons.check_circle,
                                color: Colors.blue,
                              ),
                          ],
                        ),
                      ),
                      onTap: () => bloc.add(SelectEvent(index)),
                    );
                  },
                );
              });
            }
        ),
      ),
    );
  }
}



class ListBLoC extends Bloc<ListEvent, ListState> {
  ListBLoC() : super(ListState()) {
    on<ListEvent>((event, emit) async {
      try {
        if (event is InitEvent) {
          emit(init());
          // emit(ListState());
          // emit(await loadArrayOfSelect());
        }
        else if (event is CounterIncrementEvent) {
          // emit(increment());
        }
        else if (event is SelectEvent) {
          emit(increment(event.index!));

          // emit(ListState(arrayOfSelect: [false, false, true, true, true, false, false, false, false, true]));
        }
      } on Exception {
        emit(await error());
      }
    });
  }

  init() {
    // return ListState().arrayOfSelect = [false, false, false, false, false, false, false, false, false, false];

    return ListState(
      arrayOfNumbers: [1, 2, 3, 4, 5, 6, 7, 8, 9, 11],
      arrayOfSelect: [false, true, false, false, false, false, false, false, false, false]
    );

    return ListState();
  }



  ListState increment(int index) {
    List<bool> arrayGet = [];

    for (int i = 0; i<state.arrayOfSelect!.length; i++) {
      arrayGet.add(state.arrayOfSelect![i]);
    }

    arrayGet[index] = !arrayGet[index];

    return ListState(
      arrayOfSelect: arrayGet
    );
  }

  error() {
    // return state.clone()..arrayOfNumbers = [];
  }

}



abstract class ListEvent {}

class InitEvent extends ListEvent {}

class CounterIncrementEvent extends ListEvent {}

class SelectEvent extends ListEvent {
  int? index;

  SelectEvent(this.index);
}

class ListState {
  late List<int>? arrayOfNumbers;
  late List<bool>? arrayOfSelect;

  ListState({
    this.arrayOfNumbers = const [1, 2, 3, 4, 5, 6, 7, 8, 9, 10],
    this.arrayOfSelect = const [true, false, false, false, false, false, false, false, false, false]
  });

  @override
  List<Object> get props => [arrayOfNumbers!, arrayOfSelect!];
}


