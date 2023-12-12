part of 'home_cubit.dart';



@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    @Default(null) WeatherModel? weatherData,
    @Default(null) String? inputCityName,
    @Default(ErrorCode.errorCodeNoError) ErrorCode errorCode,
    @Default(-1) double long,
    @Default(-1) double lat,
    @Default(true) bool isTextInput
  }) = _HomeState;

  const HomeState._();
}
