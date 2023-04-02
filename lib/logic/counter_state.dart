part of 'counter_cubit.dart';

@immutable
 class CounterState extends Equatable {
  int counterValue;
 bool ? isIncremented;
  CounterState({required this.counterValue, this.isIncremented});

  @override
  List<Object?> get props => [this.counterValue ,this.isIncremented];
}


