import 'package:hive/hive.dart';

import 'user_model.dart';

export 'user_model.dart';

void registerModelAdapter() {
  Hive.registerAdapter(UserModelAdapter());
}
