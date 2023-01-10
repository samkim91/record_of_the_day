import 'package:way_to_fit/src/data/models/wod.dart';

abstract class WodRepository {
  Future<List<Wod>> readWods(Wod? lastWod, int pageSize);

  Future<Wod> readWod(String id);

  Future<Wod> createWod(Wod wod);

  Future<void> setWodInactive();
}
