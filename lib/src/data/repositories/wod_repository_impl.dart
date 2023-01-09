import 'package:way_to_fit/src/core/config/network.dart';
import 'package:way_to_fit/src/data/models/wod.dart';
import 'package:way_to_fit/src/domain/repositories/wod_repository.dart';

class WodRepositoryImpl implements WodRepository {
  final database = firestore.collection(Collections.wods.name).withConverter(
        fromFirestore: Wod.fromFirestore,
        toFirestore: (Wod wod, options) => wod.toFirestore(),
      );

  @override
  Future<Wod> createWod(Wod wod) async {
    final result = await database.add(wod);

    return wod.copyWith(id: result.id);
  }

  @override
  Future<Wod> readWod(String id) async {
    final reference = database.doc(id);

    final docSnap = await reference.get();
    final wod = docSnap.data();

    if (wod != null) {
      return wod;
    } else {
      throw NullThrownError();
    }
  }

  @override
  Future<List<Wod>> readWods() async {
    final reference = await database.where("isActive", isEqualTo: true).get();

    return reference.docs.map((e) => e.data()).toList();
  }

  @override
  Future<void> setWodInactive() {
    // TODO: implement setWodInactive
    throw UnimplementedError();
  }
}
