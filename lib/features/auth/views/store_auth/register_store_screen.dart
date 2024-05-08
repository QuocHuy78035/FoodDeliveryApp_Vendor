import 'dart:io';
import 'dart:typed_data';
import 'package:ddnangcao_project/features/auth/controllers/auth_controller.dart';
import 'package:ddnangcao_project/features/main/views/navbar_custom.dart';
import 'package:ddnangcao_project/utils/size_lib.dart';
import 'package:ddnangcao_project/widgets/base_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../utils/color_lib.dart';

class RegisterStoreScreen extends StatefulWidget {
  final String email;

  const RegisterStoreScreen({super.key, required this.email});

  @override
  State<RegisterStoreScreen> createState() => _RegisterStoreScreenState();
}

class _RegisterStoreScreenState extends State<RegisterStoreScreen> {
  String name = "";
  String address = "";
  String timeOpen = "";
  String timeClose = "";
  File? _image;

  Position? _currentLocation;
  late bool servicePermission = true;
  late LocationPermission permission;

  String currentAddress = '';

  Future<void> _getCurrentLocationAndAddress() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    try {
      _currentLocation = await _getCurrentLocation();
      sharedPreferences.setDouble("latitude", _currentLocation!.latitude);
      sharedPreferences.setDouble("longitude", _currentLocation!.longitude);
      await _getAddress();
    } catch (e) {
      print("Error getting current location and address: $e");
    }
  }

  Future<Position> _getCurrentLocation() async {
    if (!servicePermission) {
      print("Service disabled");
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    return await Geolocator.getCurrentPosition();
  }

  Future<void> _getAddress() async {
    try {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      List<Placemark> placesmarks = await placemarkFromCoordinates(
          _currentLocation!.latitude, _currentLocation!.longitude);
      if (placesmarks.isNotEmpty) {
        Placemark placemark = placesmarks[0];
        if (mounted) {
          setState(() {
            currentAddress =
                "${placemark.street}, ${placemark.subAdministrativeArea}, ${placemark.administrativeArea}, ${placemark.country}, ";
          });
          sharedPreferences.setString("address", currentAddress);
        }
      } else {
        setState(() {
          currentAddress = "Không thể tìm thấy địa chỉ.";
        });
      }
    } catch (e) {
      print("Error getting address: $e");
      setState(() {
        currentAddress = "Lỗi khi lấy địa chỉ.";
      });
    }
  }

  _selectCameraImage() async {
    final ImagePicker _imagePicker = ImagePicker();

    final im = await _imagePicker.pickImage(source: ImageSource.camera);
    if (im != null) {
      setState(() {
        _image = File(im.path);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _initializeState();
  }

  Future<void> _initializeState() async {
    try {
      await _getCurrentLocationAndAddress();
    } catch (e) {
      print("Error initializing state: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    bool locationAvailable =
        _currentLocation != null && currentAddress.isNotEmpty;

    return locationAvailable == true
        ? Scaffold(
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: Colors.blue,
                  toolbarHeight: 200,
                  flexibleSpace: LayoutBuilder(
                    builder: (context, constrain) {
                      return FlexibleSpaceBar(
                        background: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                ColorLib.primaryColor,
                                Colors.yellow.shade900
                              ],
                            ),
                          ),
                          child: Center(
                            child: Container(
                              height: 120,
                              width: 120,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(
                                  10,
                                ),
                              ),
                              child: _image != null
                                  ? Image.memory(
                                      _image?.readAsBytesSync() as Uint8List,
                                      fit: BoxFit.cover,
                                    )
                                  : IconButton(
                                      icon: const Icon(Icons.image),
                                      onPressed: () {
                                        _selectCameraImage();
                                      },
                                    ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        BaseInput(
                          onChanged: (value) {
                            name = value;
                          },
                          hintText: 'Store Name',
                          type: 'Store Name',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        BaseInput(
                          onChanged: (value) {
                            print(value);
                            currentAddress = value;
                          },
                          initialValue: currentAddress,
                          hintText: 'Address',
                          type: 'Address',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: GetSize.getWidth(context) * .4,
                              child: BaseInput(
                                onChanged: (value) {
                                  timeOpen = value;
                                },
                                hintText: 'Time Open',
                                type: 'Time Open',
                              ),
                            ),
                            SizedBox(
                              width: GetSize.getWidth(context) * .4,
                              child: BaseInput(
                                onChanged: (value) {
                                  timeClose = value;
                                },
                                hintText: 'Time Close',
                                type: 'Time Close',
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (locationAvailable) {
                                EasyLoading.show(status: "Please wait");
                                AuthController auth = AuthController();
                                await auth.registerStore(
                                    name,
                                    currentAddress,
                                    _image,
                                    timeOpen,
                                    timeClose,
                                    "${_currentLocation?.latitude}",
                                    "${_currentLocation?.longitude}");
                                EasyLoading.dismiss();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const CustomerHomeScreen(),
                                  ),
                                );
                              }
                              //_registerStoreVendor();
                              //FirebaseAuth.instance.signOut();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorLib.primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  10,
                                ),
                              ),
                            ),
                            child: const Text(
                              'Save',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        : const Center(
            child: Text("Waiting for get location"),
          );
  }
}
