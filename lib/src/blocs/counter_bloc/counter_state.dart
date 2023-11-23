part of 'counter_bloc.dart';

class CounterState extends Equatable {
  @override
  final int counter;
  final int transaction;

  const CounterState({this.counter = 5, this.transaction = 5});

  CounterState copyWith({
    int? counter,
    int? transaction
  }) => CounterState(
    counter: counter ?? this.counter,
    transaction: transaction ?? this.transaction
  );

  @override
  List<Object?> get props => [counter, transaction];
}
