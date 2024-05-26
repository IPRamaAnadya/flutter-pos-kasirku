import '../../../models/store.dart';

abstract class StoreRemoteDatasource {
  Future<StoreModel?> getStore(String userID, String storeID);
  Future<List<StoreModel>?> getStoresList(String userID);
  Future<bool> addStore(String userID, StoreModel store);
  Future<bool> editStore(String userID, String storeID, StoreModel store);
  Future<bool> deleteStore(String userID, String storeID);
}