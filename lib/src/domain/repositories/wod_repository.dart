import '../../data/models/wod.dart';

abstract class WodRepository {
  Future<void> readWods();

  Future<void> readWod();

  Future<Wod> createWod(Wod wod);

  Future<void> setWodInactive();
}
