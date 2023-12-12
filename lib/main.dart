import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'src/common/utils/getit_utils.dart';
import 'src/common/utils/global_bloc_observer.dart';
import 'src/core/datasources/local/storage.dart';
import 'src/modules/app/app_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Storage.setup();
  configureDependencies();
  if (!kReleaseMode) {
    Bloc.observer = GlobalBlocObserver();
  }
  runApp(const AppWidget());
}
