part of 'wod_read_bloc.dart';

enum WodReadStatus { initial, processing, success, error }

class WodReadState extends Equatable {
  final Wod wod;
  final NetworkStatus status;

  const WodReadState(
      {this.wod = const Wod(), this.status = NetworkStatus.initial});

  @override
  List<Object> get props => [wod, status];
}
