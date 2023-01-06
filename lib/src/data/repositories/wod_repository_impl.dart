import 'package:way_to_fit/src/core/config/network.dart';
import 'package:way_to_fit/src/data/models/wod.dart';
import 'package:way_to_fit/src/domain/repositories/wod_repository.dart';

class WodRepositoryImpl implements WodRepository {
  @override
  Future<Wod> createWod(Wod wod) async {
    final result = await firestore
        .collection(Collections.wods.name)
        .withConverter(
          fromFirestore: Wod.fromFirestore,
          toFirestore: (Wod wod, options) => wod.toFirestore(),
        )
        .add(wod);

    return wod.copyWith(id: result.id);
  }

  @override
  Future<void> readWod() {
    // TODO: implement readWod
    throw UnimplementedError();
  }

  @override
  Future<void> readWods() {
    // TODO: implement readWods
    throw UnimplementedError();
  }

  @override
  Future<void> setWodInactive() {
    // TODO: implement setWodInactive
    throw UnimplementedError();
  }
}
