import '../../data/models/wod.dart';

abstract class WodRepository {
  Future<void> readWods();

  Future<void> readWod(String id);

  Future<Wod> createWod(Wod wod);

  Future<void> setWodInactive();
}
