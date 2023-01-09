part of 'wod_list_bloc.dart';

class WodListState extends Equatable {
  final List<Wod> wods;
  final NetworkStatus status;
  final String error;

  const WodListState(
      {this.wods = const <Wod>[],
      this.status = NetworkStatus.initial,
      this.error = ""});

  @override
  List<Object> get props => [wods, status];

  WodListState copyWith({
    List<Wod>? wods,
    NetworkStatus? status,
    String? error,
  }) {
    return WodListState(
      wods: wods ?? this.wods,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}
