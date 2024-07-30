import 'package:get_it/get_it.dart';
import 'package:tractian/support/services/service_locator/app_module.dart';
import 'package:tractian/support/services/service_locator/commons_module.dart';

class ServiceLocator {
  ServiceLocator._();

  static final _provider = GetIt.instance;

  static T get<T extends Object>({dynamic param1}) {
    return _provider.get<T>(param1: param1);
  }

  static void registerFactory<T extends Object>(T Function() constructor) {
    _provider.registerFactory<T>(constructor);
  }

  static void registerFactoryParam<T extends Object, P>(T Function(P param) constructor) {
    _provider.registerFactoryParam<T, P, void>((param, _) => constructor(param));
  }

  static void registerSingleton<T extends Object>(T instance) {
    _provider.registerSingleton<T>(instance);
  }
}

void initializeDependencies() {
  final modules = <AppModule>[
    CommonsModule(),
  ];

  for (final module in modules) {
    module.registerDependencies();
  }
}
