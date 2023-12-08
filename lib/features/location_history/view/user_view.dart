
import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:on_space/constants/app_colors.dart';
import 'package:on_space/features/location_history/cubit/location_cubit.dart';
import 'package:on_space/features/location_history/cubit/merker_future.dart';
import 'package:on_space/features/location_history/models/location.dart';
import 'package:on_space/features/location_history/view/user_location_details_view.dart';
import 'package:on_space/widgets/custom_button_widget.dart';
import 'package:on_space/widgets/regular_text_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:timeago/timeago.dart' as timeago;


class UserView extends StatefulWidget {
  const UserView({required this.userCubit, super.key});

  final LocationCubit userCubit;

  @override
  State<UserView> createState() => _UserViewState();
}

class _UserViewState extends State<UserView> {
  GoogleMapController? _controller;
  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;
  String _mapStyle = '';
  final Map<MarkerId, Marker> markers = {};

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      rootBundle.loadString('assets/style/map_style.txt').then((string) {
        _mapStyle = string;
      });
    });
  }

  void _zoomIn() {
    _controller?.animateCamera(
      CameraUpdate.zoomIn(),
    );
  }

  void _zoomOut() {
    _controller?.animateCamera(
      CameraUpdate.zoomOut(),
    );
  }

  void showMarkerInfoWindow(MarkerId markerId) {
    _controller!.showMarkerInfoWindow(markerId);
  }

  Future<Set<Marker>> buildMarkers(List<LocationHistory> locationHistory, )
  async {
    final markers = <Marker>{};
    for (var i = 0; i < locationHistory.length; i++) {
      final location = locationHistory[i];

      final markerIcon = await _getBytesFromUrl(location.image, 80, 80);

      markers.add(
        Marker(
          markerId: MarkerId('${location.latitude}-${location.longitude}'),
          position: LatLng(location.latitude, location.longitude),
          infoWindow: InfoWindow(
            title: location.item,
            snippet: '${location.latitude}, ${location.longitude}',
          ),
          icon: BitmapDescriptor.fromBytes(markerIcon),
        ),
      );
    }

    return markers;
  }

  Future<Uint8List> _getBytesFromUrl(String url, int width, int height) async {
    final response = await http.get(Uri.parse(url));
    final imageBytes = response.bodyBytes;

    final completer = Completer<Uint8List>();

    await ui
        .instantiateImageCodec(imageBytes, targetWidth: width,
        targetHeight: height,)
        .then((codec) => codec.getNextFrame())
        .then((frame) {
      final image = frame.image;
      image.toByteData(format: ui.ImageByteFormat.png).then((byteData) {
        final resizedBytes = byteData!.buffer.asUint8List();
        completer.complete(resizedBytes);
      });
    })
        .catchError((error) {
      completer.completeError('Failed to resize image: $error');
    });

    return completer.future;
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const Padding(
          padding: EdgeInsets.only(left: 10),
          child: CustomButtonWidget(
            widget: Icon(
              Icons.search,
              size: 22,
              color: AppColors.blackAppColor,
            ),
            height: 40,
            width: 40,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: CustomButtonWidget(
              widget: Icon(
                Icons.settings_outlined,
                size: 20,
                color: AppColors.blackAppColor,
              ),
              height: 45,
              width: 45,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: BlocBuilder<LocationCubit, LocationState>(
            builder: (context, state) {
              if (state is InitialLocationState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is LocationHistoryLoaded) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    FutureBuilder(
                        future:
                            buildMarkers(state.locationHistory),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return const RegularTextWidget(text: 'Error');
                          } else if (!snapshot.hasData ||
                              snapshot.data!.isEmpty) {
                            return const Center(
                              child: Text('No markers to display'),
                            );
                          } else if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            return GoogleMap(
                              zoomControlsEnabled: false,
                              markers: snapshot.data!,
                              myLocationEnabled: true,
                              initialCameraPosition: CameraPosition(
                                target: state.locationHistory.isNotEmpty
                                    ? LatLng(
                                        state.locationHistory.first.latitude,
                                        state.locationHistory.first.longitude,
                                      )
                                    : const LatLng(0, 0),
                                zoom: 12,
                              ),
                              onMapCreated: (GoogleMapController controller) {
                                _controller = controller;
                                _controller?.setMapStyle(_mapStyle);
                              },
                            );
                          }
                        }),
                    Positioned(
                      bottom: 85,
                      left: 1,
                      right: 1,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomButtonWidget(
                                  height: 45,
                                  width: 45,
                                  widget: const Icon(
                                    Icons.add,
                                    color: AppColors.blackAppColor,
                                  ),
                                  onTap: _zoomIn,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomButtonWidget(
                                  height: 45,
                                  width: 45,
                                  onTap: _zoomOut,
                                  widget: const Icon(
                                    Icons.remove,
                                    color: AppColors.blackAppColor,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomButtonWidget(
                                  height: 45,
                                  width: 45,
                                  widget: Icon(
                                    Icons.location_on_outlined,
                                    color: AppColors.blackAppColor,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: AppColors.whiteAppColor,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 5),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CustomButtonWidget(
                                          color: AppColors.primaryAppColor,
                                          height: 35,
                                          width: 35,
                                          widget: Icon(
                                            Icons.add,
                                            color: AppColors.blackAppColor,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 10, right: 20,),
                                          child: RegularTextWidget(
                                            text: 'Add new tag',
                                            color: AppColors.blackAppColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: AppColors.whiteAppColor,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 5),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CustomButtonWidget(
                                          color: AppColors.primaryAppColor,
                                          height: 35,
                                          width: 35,
                                          widget: Icon(
                                            Icons.add,
                                            color: AppColors.blackAppColor,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                            left: 10,
                                            right: 20,
                                          ),
                                          child: RegularTextWidget(
                                            text: 'Add new item',
                                            color: AppColors.blackAppColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Container(
                              height: 200,
                              width: size.width,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/card_background.png',),
                                  fit: BoxFit.fill,
                                ),
                              ),
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 15, right: 10,),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 30,),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Colors.green
                                                      .withOpacity(0.4),
                                                ),
                                                child: const Padding(
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: 12,
                                                    vertical: 2,
                                                  ),
                                                  child: RegularTextWidget(
                                                    text: 'All',
                                                    fontWeight: FontWeight.w700,
                                                    color:
                                                        AppColors.blackAppColor,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 30,),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Colors.green
                                                      .withOpacity(0.4),
                                                ),
                                                child: const Padding(
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: 12,
                                                    vertical: 2,
                                                  ),
                                                  child: RegularTextWidget(
                                                    text: 'People',
                                                    fontWeight: FontWeight.w700,
                                                    color:
                                                        AppColors.blackAppColor,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 30,),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Colors.green
                                                      .withOpacity(0.4),
                                                ),
                                                child: const Padding(
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: 12,
                                                    vertical: 2,
                                                  ),
                                                  child: RegularTextWidget(
                                                    text: 'Items',
                                                    fontWeight: FontWeight.w700,
                                                    color:
                                                        AppColors.blackAppColor,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const Icon(
                                          Icons.more_horiz_outlined,
                                          color: AppColors.blackAppColor,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Flexible(
                                    child: SizedBox(
                                      child: MediaQuery.removePadding(
                                        context: context,
                                        removeBottom: true,
                                        removeTop: true,
                                        child: ListView.builder(
                                          physics:
                                          const ClampingScrollPhysics(),
                                          itemCount:
                                          state.locationHistory.length,
                                          shrinkWrap: true,
                                          itemBuilder: (context, index) {
                                            final time =
                                            DateTime.parse(state
                                                .locationHistory[index]
                                                .updatedAt,);
                                            return InkWell(
                                              onTap: (){
                                                Navigator.push(context,
                                                  PageTransition(child:
                                                  UserLocationDetailsView(
                                                    imageURl:
                                                    state.locationHistory
                                                    [index].image,
                                                    currentLocation:
                                                    state.locationHistory
                                                    [index].street,
                                                    itemName: state.
                                                    locationHistory[index].item,
                                                    locationId: state.
                                                    locationHistory[index].id,
                                                    streetName: state.
                                                    locationHistory[index].
                                                    street,
                                                  ),
                                                    type: PageTransitionType.
                                                    rightToLeft,
                                                  ),);
                                              },
                                              child: SizedBox(
                                                height: 50,
                                                width: size.width,
                                                child: Padding(
                                                  padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 15,),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          CircleAvatar(
                                                            backgroundImage:
                                                            NetworkImage(state.
                                                            locationHistory
                                                            [index].image,),
                                                            radius: 20,
                                                          ),
                                                          const SizedBox(
                                                            width: 8,
                                                          ),
                                                          Column(
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                            children: [
                                                              RegularTextWidget(
                                                                text: state.
                                                                locationHistory
                                                                [index].item,
                                                                color: AppColors
                                                                .blackAppColor,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w700,
                                                                size: 15,
                                                              ),
                                                              const SizedBox(
                                                                height: 2,
                                                              ),
                                                              RegularTextWidget(
                                                                text: state.
                                                                locationHistory
                                                                [index].street,
                                                                color: AppColors
                                                                 .blackAppColor,
                                                                size: 15,
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          RegularTextWidget(
                                                            text: 'Updated'
                                                                ' ${timeago.
                                                            format(time)}',
                                                            color: AppColors
                                                                .blackAppColor,
                                                            size: 12,
                                                          ),
                                                          const SizedBox(
                                                            width: 5,
                                                          ),
                                                          CustomButtonWidget(
                                                            onTap: (){
                                                          showMarkerInfoWindow(
                                                                  MarkerId('${
                                                                      state.

                                                             locationHistory
                                                                      [index].
                                                                      latitude}'
                                                                      '-${state.
                                                              locationHistory
                                                                  [index].
                                                                  longitude}'),
                                                          );
                                                            },
                                                            height: 30,
                                                            width: 30,
                                                            color: AppColors
                                                                .blackAppColor,
                                                            widget: const Icon(
                                                              Icons
                                                        .location_on_outlined,
                                                              color: AppColors

                                                              .whiteAppColor,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              } else if (state is LocationErrorState) {
                return Center(
                  child: RegularTextWidget(
                    text: 'Error: ${state.message}',
                    color: AppColors.blackAppColor,
                  ),
                );
              } else {
                return const RegularTextWidget(text: 'Unknown state');
              }
            },
          ),
        ),
      ),
    );
  }

}

