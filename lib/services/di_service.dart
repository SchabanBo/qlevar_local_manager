import 'package:get_it/get_it.dart';

import 'storage_service.dart';

final _getIt = GetIt.instance;

void setupDI() {
  _getIt.registerSingleton(StorageService());
}

T getService<T>() => _getIt<T>();

void addService<T extends Object>(T service) =>
    _getIt.registerSingleton<T>(service);

void removeService<T extends Object>() => _getIt.unregister<T>();
