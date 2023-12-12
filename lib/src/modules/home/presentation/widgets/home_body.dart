import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/enums/error_weather_code.dart';
import '../../../../common/extensions/build_context_x.dart';
import '../../../../common/theme/app_decorations.dart';
import '../../../../common/utils/debouncer.dart';
import '../application/cubits/home_cubit.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _longController = TextEditingController();
  final TextEditingController _latController = TextEditingController();
  final _debounceLong = Debounce(milliseconds: 300);
  final _debounceLat = Debounce(milliseconds: 300);

  @override
  void dispose() {
    _debounceLong.dispose();
    _debounceLat.dispose();
    super.dispose();
    _cityController.dispose();
    _longController.dispose();
    _latController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: TextButton(
                      onPressed: () async {
                        context.read<HomeCubit>().changeInput();
                        if (state.isTextInput) {
                          _cityController.clear();
                        } else {
                          _longController.clear();
                          _latController.clear();
                        }
                      },
                      child: Column(
                        children: [
                          const Icon(Icons.change_circle_outlined),
                          Text(state.isTextInput
                              ? context.s.home_switch_input_type_city_long_lat
                              : context.s.home_switch_input_type_city_name)
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  inputWidget(context, state),
                  (state.weatherData != null &&
                          state.errorCode == ErrorCode.errorCodeNoError)
                      ? weatherData(context, state)
                      : Container()
                ],
              ),
            ));
  }

  Widget inputWidget(BuildContext context, HomeState state) {
    return Container(
      child: state.isTextInput
          ? TextFormField(
              controller: _cityController,
              autofocus: true,
              onChanged: (text) async {
                _debounceLong.run(() async {
                  await context.read<HomeCubit>().setCity(text);
                });
              },
              decoration: AppDecorations.defaultInputDecoration(
                  labelText: context.s.home_input_city_name_title,
                  hintText: context.s.home_input_city_name_hint,
                  errorText: getErrorTextFromErrorCode(state.errorCode)))
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                  Expanded(
                      flex: 1,
                      child: TextFormField(
                        controller: _longController,
                        autofocus: true,
                        keyboardType: TextInputType.number,
                        onChanged: (text) async {
                          _debounceLong.run(() async {
                            await context.read<HomeCubit>().setLong(text);
                          });
                        },
                        decoration: AppDecorations.defaultInputDecoration(
                            labelText: context.s.home_input_long_title,
                            errorText:
                                getErrorTextFromErrorCode(state.errorCode)),
                      )),
                  const SizedBox(width: 5),
                  Expanded(
                      flex: 1,
                      child: TextFormField(
                        controller: _latController,
                        keyboardType: TextInputType.number,
                        onChanged: (text) async {
                          _debounceLat.run(() async {
                            await context.read<HomeCubit>().setLat(text);
                          });
                        },
                        decoration: AppDecorations.defaultInputDecoration(
                            labelText: context.s.home_input_lat_title,
                            errorText:
                                state.errorCode != ErrorCode.errorCodeNoError
                                    ? ' '
                                    : null),
                      ))
                ]),
    );
  }

  String? getErrorTextFromErrorCode(ErrorCode errorCode) {
    switch (errorCode) {
      case ErrorCode.errorCodeNoError:
        return null;
      case ErrorCode.errorCodePleaseInputCity:
        return context.s.home_error_please_input_city;
      case ErrorCode.errorCodeCityNotFound:
        return context.s.home_error_city_not_found;
      case ErrorCode.errorInvalidInputNumber:
        return context.s.home_error_invalid_input;
    }
  }

  Widget weatherData(BuildContext context, HomeState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 10),
        Text(
          '${context.s.home_weather_description} ${state.weatherData?.currentWeather ?? ''}',
        ),
        const SizedBox(height: 10),
        Text(
          '${context.s.home_weather_temperature} ${state.weatherData?.currentTemperature ?? ''}${context.s.common_celsius}',
        ),
        const SizedBox(height: 10),
        Text(
          '${context.s.home_weather_city} ${state.weatherData?.locationName ?? ''}',
        ),
      ],
    );
  }
}
