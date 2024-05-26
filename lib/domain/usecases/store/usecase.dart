import 'package:pos/data/repositories/store/repository.dart';
import 'package:pos/domain/entities/store.dart';

class StoreUsecase {
  final StoreRepository _repository;
  StoreUsecase(this._repository);

  Future<bool> createStore(StoreEntity store) => _repository.createStore(store);
}