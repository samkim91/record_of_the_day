part of 'wod_create_bloc.dart';

class WodCreateState extends Equatable {
  final Wod wod;
  final bool isValidTypeDetail;
  final bool isValidMovements;
  final String movement;

  const WodCreateState({
    this.wod = const Wod(),
    this.isValidTypeDetail = true,
    this.isValidMovements = true,
    this.movement = '',
  });

  @override
  List<Object> get props => [
        wod,
        isValidTypeDetail,
        isValidMovements,
        movement,
      ];

  WodCreateState copyWith({
    Wod? wod,
    bool? isValidTypeDetail,
    bool? isValidMovements,
    String? movement,
  }) {
    return WodCreateState(
      wod: wod ?? this.wod,
      isValidTypeDetail: isValidTypeDetail ?? this.isValidTypeDetail,
      isValidMovements: isValidMovements ?? this.isValidMovements,
      movement: movement ?? this.movement,
    );
  }
}
