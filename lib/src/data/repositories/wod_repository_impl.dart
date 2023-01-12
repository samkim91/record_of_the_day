import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:way_to_fit/src/core/config/logger.dart';
import 'package:way_to_fit/src/core/config/network.dart';
import 'package:way_to_fit/src/data/models/wod.dart';
import 'package:way_to_fit/src/domain/repositories/wod_repository.dart';

final CollectionReference<Wod> wodCollection =
    firestore.collection(Collections.wods.name).withConverter(
          fromFirestore: Wod.fromFirestore,
          toFirestore: (Wod wod, options) => wod.toFirestore(),
        );

class WodRepositoryImpl implements WodRepository {
  @override
  Future<Wod> createWod(Wod wod) async {
    final result = await wodCollection.add(wod);

    return wod.copyWith(id: result.id);
  }

  @override
  Future<Wod> readWod(String id) async {
    final reference = wodCollection.doc(id);

    final docSnap = await reference.get();
    final wod = docSnap.data();

    if (wod != null) {
      return wod;
    } else {
      logger.e("readWod: Not found");
      throw NullThrownError();
    }
  }

  @override
  Future<List<Wod>> readWods(Wod? lastWod, int pageSize) async {
    logger.d("readWods: $lastWod");

    final query = wodCollection
        .where("isActive", isEqualTo: true)
        .orderBy("createdAt", descending: true);

    if (lastWod != null) {
      query.startAfter([lastWod]);
    }

    final querySnap = await query.limit(pageSize).get();

    return querySnap.docs.map((e) => e.data()).toList();
  }

  @override
  Future<void> setWodInactive() {
    // TODO: implement setWodInactive
    throw UnimplementedError();
  }
}
