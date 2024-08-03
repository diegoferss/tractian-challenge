import 'package:tractian/support/services/json_reader.dart';
import 'package:tractian/support/services/service_locator/service_locator.dart';

import 'app_module.dart';

class CommonsModule extends AppModule {
  @override
  void registerDependencies() {
    ServiceLocator.registerFactory<JsonReader>(() {
      return JsonReaderImpl();
    });
  }
}
