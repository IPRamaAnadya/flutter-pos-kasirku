import 'package:firebase_auth/firebase_auth.dart';
import 'package:pos/data/data.dart';
import 'package:pos/domain/entities/store.dart';

import '../../datasources/local/stores/datasource.dart';

abstract class StoreRepository {
  Future<bool> createStore(StoreEntity store);
}

class StoreRepositoryImpl implements StoreRepository {

 final StoreRemoteDatasource _remote;
 final StoreLocalDatasource _local;

 StoreRepositoryImpl(this._remote, this._local);

  @override
  Future<bool> createStore(StoreEntity store) async {
    final userID = FirebaseAuth.instance.currentUser?.uid ?? "";

    return await _remote.addStore(userID, StoreModel.fromEntity(store)).then((res) async {
      await _local.saveStore(StoreModel.fromEntity(store));
      return true;
    });
  }

}