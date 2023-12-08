import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:http/io_client.dart';
import 'package:on_space/features/location_history/models/location.dart';

abstract class LocationState {}

class InitialLocationState extends LocationState {}

class LocationHistoryLoaded extends LocationState {
  LocationHistoryLoaded(this.locationHistory);
  final List<LocationHistory> locationHistory;
}

class LocationErrorState extends LocationState {
  LocationErrorState(this.message);
  final String message;
}

class LocationCubit extends Cubit<LocationState> {
  LocationCubit() : super(InitialLocationState()) {
    fetchUserLocationHistory();
  }

  Future<void> fetchUserLocationHistory() async {
    try {
      final ioc =  HttpClient();
      ioc.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      final http =  IOClient(ioc);

      final response = await http.get(Uri.parse('https://www.jsonkeeper.com/b/N06K'));
      if (response.statusCode == 200) {

        final  jsonList = json.decode(response.body) as List<dynamic>;

        final locationHistory = _extractLocationHistory(jsonList);
        emit(LocationHistoryLoaded(locationHistory));
      } else {

        emit(LocationErrorState('Failed to load user location history'));
      }
    } catch (e) {
      emit(LocationErrorState('Failed to fetch location history.'));
    }
  }

  List<LocationHistory> _extractLocationHistory(List<dynamic> jsonList) {
    try {
      return jsonList
          .map((json) {
        final locationHistory = json['location_history'] as List<dynamic>;
        return locationHistory
            .map((location) => LocationHistory(
          longitude: double.parse(location['longitude'].toString()),
          latitude: double.parse(location['latitude'].toString()),
          image: location['image'].toString(),
          street: location['street'].toString(),
          item: location['item'].toString(),
          updatedAt: location['updated_at'].toString(),
          id: location['id'].toString(),
        ))
            .toList();
      })
          .expand((locations) => locations)
          .toList();
    } catch (e) {
      return List<LocationHistory>.empty();
    }
  }

}
