import 'package:bloc/bloc.dart';
import 'package:dartx/dartx.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../common/enums/error_weather_code.dart';
import '../../../../../common/utils/validator.dart';
import '../../../../../core/interfaces/weather_repository_interface.dart';
import '../../../../../core/models/weather_model.dart';

part 'home_state.dart';

part 'home_cubit.freezed.dart';

class HomeCubit extends Cubit<HomeState> {
  final IWeatherRepository _iWeatherRepository;

  HomeCubit(this._iWeatherRepository) : super(const HomeState());

  Future<void> setCity(String? city) async {
    if (!city.isNotNullOrEmpty) {
      emit(state.copyWith(
        errorCode: ErrorCode.errorCodePleaseInputCity,
      ));
      return;
    }
    emit(state.copyWith(
      inputCityName: city,
    ));
    await getWeatherFromCityName();
  }

  Future<void> getWeatherFromCityName() async {
    if (!state.inputCityName.isNotNullOrEmpty) {
      return;
    }
    WeatherModel? weather =
        await _iWeatherRepository.getWeatherFromCityName(state.inputCityName!);
    if (weather == null) {
      emit(state.copyWith(
          errorCode: ErrorCode.errorCodeCityNotFound, weatherData: null));
      return;
    }
    emit(state.copyWith(
        errorCode: ErrorCode.errorCodeNoError, weatherData: weather));
  }

  Future<void> setLong(String longitude) async {
    if (!checkIfLongLatValid(longitude)) {
      return;
    }
    emit(state.copyWith(long: longitude.toDouble()));
    await getWeatherFromLongLat();
  }

  Future<void> setLat(String latitude) async {
    if (!checkIfLongLatValid(latitude)) {
      return;
    }
    emit(state.copyWith(lat: latitude.toDouble()));
    await getWeatherFromLongLat();
  }

  bool checkIfLongLatValid(String number) {
    if (!number.isNotNullOrEmpty) {
      emit(state.copyWith(
        errorCode: ErrorCode.errorCodePleaseInputCity,
      ));
      return false;
    }
    if (!Validator.isValidNumber(number)) {
      emit(state.copyWith(
        errorCode: ErrorCode.errorInvalidInputNumber,
      ));
      return false;
    }
    return true;
  }

  Future<void> getWeatherFromLongLat() async {
    if (state.long < 0 || state.lat < 0) {
      return;
    }

    WeatherModel? weather =
        await _iWeatherRepository.getWeatherFromLongLat(state.long, state.lat);
    if (weather == null) {
      emit(state.copyWith(
          errorCode: ErrorCode.errorCodeCityNotFound, weatherData: null));
      return;
    }
    emit(state.copyWith(
        errorCode: ErrorCode.errorCodeNoError, weatherData: weather!));
  }

  void changeInput() {
    emit(state.copyWith(
        isTextInput: !state.isTextInput,
        long: -1,
        lat: -1,
        inputCityName: '',
        weatherData: null,
        errorCode: ErrorCode.errorCodeNoError));
  }
}
