import 'package:pos/data/datasources/local/stores/datasource.dart';
import 'package:pos/data/models/store.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorePrefsDatasource implements StoreLocalDatasource {

  final String _store_key = "store";
  final String _store_list_key = "store_list";

  @override
  Future<void> deleteStore(String storeID) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(storeID);
  }

  @override
  Future<StoreModel?> getStore() async {
    final prefs = await SharedPreferences.getInstance();
    final res = await prefs.get(_store_key) as String?;

    if(res != null) {
      return StoreModel.fromRawJson(res);
    }

    return null;
  }

  @override
  Future<List<StoreModel>?> getStoresList() async {
    // TODO: implement saveStore
    throw UnimplementedError();
  }

  @override
  Future<void> saveStore(StoreModel store) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_store_key, store.toRawJson());
  }

  @override
  Future<void> updateStore(String storeID, StoreModel data) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_store_key, data.toRawJson());
  }

}