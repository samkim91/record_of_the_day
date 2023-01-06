part of 'wod_create_bloc.dart';

class WodCreateState extends Equatable {
  final Wod wod;
  final bool isValidTypeDetail;
  final bool isValidMovements;
  final String movement;

  final NetworkStatus status;
  final String error;

  const WodCreateState({
    this.wod = const Wod(),
    this.isValidTypeDetail = true,
    this.isValidMovements = true,
    this.movement = '',
    this.status = NetworkStatus.initial,
    this.error = '',
  });

  @override
  List<Object> get props => [
        wod,
        isValidTypeDetail,
        isValidMovements,
        movement,
        status,
        error,
      ];

  WodCreateState copyWith({
    Wod? wod,
    bool? isValidTypeDetail,
    bool? isValidMovements,
    String? movement,
    NetworkStatus? status,
    String? error,
  }) {
    return WodCreateState(
      wod: wod ?? this.wod,
      isValidTypeDetail: isValidTypeDetail ?? this.isValidTypeDetail,
      isValidMovements: isValidMovements ?? this.isValidMovements,
      movement: movement ?? this.movement,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}
