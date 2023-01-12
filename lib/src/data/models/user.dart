import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String? id;
  final DateTime? createdAt;
  final String nickName;

  final DateTime? startedAt;

  const User(this.id, this.createdAt, this.nickName, this.startedAt);

  // TODO: 2023/01/12 Gender, height, weight
  // final GenderType gender;
  // final Map<HeightType, String> height;
  // final Map<WeightType, int> weight;

  @override
  List<Object?> get props => [id, createdAt, nickName, startedAt];
}
