import 'package:flutter/foundation.dart';
import 'package:pos/domain/entities/store.dart';
import 'package:pos/domain/usecases/store/usecase.dart';
import 'package:pos/main.dart';

class CreateStoreProvider extends ChangeNotifier {
  final StoreUsecase _usecase;
  CreateStoreProvider(this._usecase);
  
  Future<bool> createStore(String name) async {
    StoreEntity store = StoreEntity(id: uuid.v4(), name: name);
    return await _usecase.createStore(store);
  }
}