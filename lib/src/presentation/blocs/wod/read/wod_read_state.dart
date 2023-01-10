part of 'wod_read_bloc.dart';

class WodReadState extends Equatable {
  final Wod wod;
  final NetworkStatus status;
  final String error;

  const WodReadState({
    this.wod = const Wod(),
    this.status = NetworkStatus.initial,
    this.error = "",
  });

  @override
  List<Object> get props => [
        wod,
        status,
        error,
      ];

  WodReadState copyWith({
    Wod? wod,
    NetworkStatus? status,
    String? error,
  }) {
    return WodReadState(
      wod: wod ?? this.wod,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}
