import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:coba_bloc/model/weather.dart';
import 'weather_repository.dart';
part 'weather_state.dart';


class WeatherCubit extends Cubit<WeatherState> {
  final WeatherRepository _weatherRepository;
  WeatherCubit(this._weatherRepository) : super(WeatherInitial());
  
  Future<void> getWeather(String cityName)async {
    emit(WeatherLoading());
    try{
      final Weather weather = await _weatherRepository.fetchWeather(cityName);
      emit(WeatherLoaded(weather));
    }on NetworkException{
      emit(WeatherError("cant connect to the Network!!"));
    }
  }
}
