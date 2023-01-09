part of 'wod_list_bloc.dart';

class WodListState extends Equatable {
  final bool isMoreData;
  final int pageSize;

  final List<Wod> wods;
  final NetworkStatus status;
  final String error;

  const WodListState(
      {this.isMoreData = true,
      this.pageSize = 20,
      this.wods = const <Wod>[],
      this.status = NetworkStatus.initial,
      this.error = ""});

  @override
  List<Object> get props => [isMoreData, pageSize, wods, status, error];

  WodListState copyWith({
    bool? isMoreData,
    int? pageSize,
    List<Wod>? wods,
    NetworkStatus? status,
    String? error,
  }) {
    return WodListState(
      isMoreData: isMoreData ?? this.isMoreData,
      pageSize: pageSize ?? this.pageSize,
      wods: wods ?? this.wods,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}
