import 'package:pos/data/data.dart';

abstract class StoreLocalDatasource {
  Future<void> saveStore(StoreModel store);
  Future<StoreModel?> getStore();
  Future<List<StoreModel>?> getStoresList();
  Future<void> updateStore(String storeID, StoreModel data);
  Future<void> deleteStore(String storeID);
}