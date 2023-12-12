import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/utils/getit_utils.dart';
import '../../../../core/interfaces/weather_repository_interface.dart';
import '../application/cubits/home_cubit.dart';
import '../widgets/home_body.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        body: SafeArea(
          child: BlocProvider<HomeCubit>(
              create: (context) => HomeCubit(getIt<IWeatherRepository>()),
              child: const HomeBody()),
        ),
      ),
    );
  }
}
