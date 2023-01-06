part of 'wod_create_bloc.dart';

enum WodCreateStatus { initial, processing, success, error }

extension WodCreateStatusEx on WodCreateStatus {
  bool get isInitial => this == WodCreateStatus.initial;

  bool get isProcessing => this == WodCreateStatus.processing;

  bool get isSuccess => this == WodCreateStatus.success;

  bool get isError => this == WodCreateStatus.error;
}

class WodCreateState extends Equatable {
  final Wod wod;
  final bool isValidTypeDetail;
  final bool isValidMovements;
  final String movement;

  final WodCreateStatus status;
  final String error;

  const WodCreateState({
    this.wod = const Wod(),
    this.isValidTypeDetail = true,
    this.isValidMovements = true,
    this.movement = '',
    this.status = WodCreateStatus.initial,
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
    WodCreateStatus? status,
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
