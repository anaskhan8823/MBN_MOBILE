import 'package:dalil_2020_app/core/dio_helper.dart';
import 'package:dalil_2020_app/models/area_model.dart';
import 'package:dalil_2020_app/models/country_and_code_model.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/end_points.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../models/city_model.dart';
import '../../../../../models/error_model.dart';
part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit() : super(LocationInitial());
  String? selectedCity;
  String? selectedarea;
  String? selectedCountry;
  String? selectedValue;
  int? countryId;
  int? cityId;
  int? areaid;
  List<CityModel> cityModel = [];
  List<CountryModel> countriesAndCode = [];
  void clearCitySelection() {
    cityId = null;
    selectedCity = null;
    selectedValue = null;
    emit(LocationInitial()); // or whatever state makes sense for your app
  }

  void clearAreaSelection() {
    areaid = null;
    selectedCity = null;
    selectedarea = null;
    emit(LocationInitial()); // or whatever state makes sense for your app
  }

  void clearCountrySelection() {
    countryId = null;
    cityId = null;
    selectedCountry = null;
    selectedCity = null;
    selectedValue = null;
    emit(ChangePlace()); // or whatever state makes sense for your app
  }

  void changeCountryOnly(String? name) {
    selectedValue = name;
    emit(ChangePlace());
  }

  void changeCityAndId(String? value, int id) {
    cityId = id;
    selectedCity = value;
    emit(ChangePlace());
  }

  void changeCityAndIdcpy(String? value, int id) {
    cityId = id;
    selectedCountry = value;
    emit(ChangePlace());
  }

  void changeCountrycopy(String? code, int? id, String? selectedCountry) {
    countryId = id;
    selectedValue = code;
    selectedCountry = selectedCountry; // problem here
    emit(ChangePlace());
  }

  void changeCountry(
    String? code,
    int? id,
  ) async {
    countryId = id;
    selectedValue = code;

    await getCityAndId(id ?? 0);
    emit(ChangePlace());
  }

  Future<Either<Failure, List<CountryModel>>> getCountryAndDialCode() async {
    try {
      emit(LocationLoading());
      final response = await DioHelper.get(COUNTRY_AND_CODE);

      if (response.isSuccess) {
        final List<CountryModel> list = List<CountryModel>.from(
            (response.data?['data'] ?? [])
                .map((e) => CountryModel.fromJson(e)));

        countriesAndCode
          ..clear()
          ..addAll(list); // store all countries

        // agar chaho pehla country default select kar sakte ho
        if (list.isNotEmpty) {
          countryId = list[0].id;
          selectedCountry = list[0].name;
          selectedValue = list[0].countryCode;
        }

        emit(LocationSuccess());
        return right(list); // return list of countries
      } else {
        return left(ServerFailure.fromResponse(response));
      }
    } catch (e) {
      return left(ServerFailure.fromCatchError(e));
    }
  }

  Future<Either<Failure, List<CityModel>>> getCityAndId(int countryId) async {
    print("jjjj");
    try {
      emit(LocationLoading());
      final response = await DioHelper.get(CITY_AND_ID);
      if (response.isSuccess) {
        final List<CityModel> allCities = List<CityModel>.from(
            (response.data?['data'] ?? []).map((e) => CityModel.fromJson(e)));
        final List<CityModel> filteredCities = allCities
            .where((city) => int.tryParse(city.countryId ?? '') == countryId)
            .toList();

        cityModel
          ..clear()
          ..addAll(filteredCities);

        print("model: $cityModel");

        emit(LocationSuccess());

        // --- Fetch neighborhoods for the first city automatically (optional) ---
        if (filteredCities.isNotEmpty) {
          final firstCityId = filteredCities.first.id;
          await fetchNeighborhoodsByCity(firstCityId ?? 0);
        }

        return right(cityModel);
      } else {
        return left(ServerFailure.fromResponse(response));
      }
    } catch (e) {
      return left(ServerFailure.fromCatchError(e));
    }
  }
  // Add this inside your LocationCubit class

  List<Neighborhood> neighborhoods =
      []; // add a new list to store neighborhoods

  Future<void> fetchNeighborhoodsByCity(int cityId) async {
    try {
      emit(LocationLoading());
      final response = await DioHelper.get('$NEIGHBORHOODS?city_id=$cityId');

      if (response.isSuccess) {
        final model = NeighborhoodsModel.fromJson(response.data);

        neighborhoods
          ..clear()
          ..addAll(model.data);

        emit(LocationSuccess());
      } else {
        emit(LocationError());
      }
    } catch (e) {
      emit(LocationError());
    }
  }

  Future<void> clear() async {
    selectedValue = null;
    selectedCity = null;
    cityId = null;
    countryId = null;
  }
}
