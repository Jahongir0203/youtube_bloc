part of 'counter_cubit.dart';

 class CounterState extends Equatable {
  int counterValue;
 bool ? isIncremented;
  CounterState({required this.counterValue, this.isIncremented});

  Map<String, dynamic> toMap() {
   return {
    'counterValue': counterValue,
    'wasIncremented': isIncremented,
   };
  }

  factory CounterState.fromMap(Map<String, dynamic> map) {
   if (map == null) return CounterState(counterValue: 0) ;

   return CounterState(
    counterValue: map['counterValue'],
    isIncremented: map['wasIncremented'],
   );
  }

  String toJson() => json.encode(toMap());

  factory CounterState.fromJson(String source) =>
      CounterState.fromMap(json.decode(source));

  @override
  List<Object?> get props => [this.counterValue ,this.isIncremented];
}


