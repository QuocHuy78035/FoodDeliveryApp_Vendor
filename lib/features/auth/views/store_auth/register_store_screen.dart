import 'dart:io';
import 'dart:typed_data';
import 'package:csc_picker/csc_picker.dart';
import 'package:ddnangcao_project/widgets/base_input.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class RegisterStoreScreen extends StatefulWidget {
  const RegisterStoreScreen({super.key});

  @override
  State<RegisterStoreScreen> createState() => _RegisterStoreScreenState();
}

class _RegisterStoreScreenState extends State<RegisterStoreScreen> {
  String cityValue = '';
  String countryValue = '';
  String stateValue = '';
  String businessName = '';
  String email = '';
  String phoneNumber = '';
  String taxNumber = "1";

  File? _image;
  final List<String> _taxOption = ['Yes', 'No'];
  String? _taxStatus;

  _selectCameraImage() async {
    final ImagePicker _imagePicker = ImagePicker();

    final im = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (im != null) {
      setState(() {
        _image = File(im.path);
      });
    }
  }

  // _registerStoreVendor() async {
  //   EasyLoading.show(status: "PLEASE WAIT");
  //   String res = await vendorController
  //       .registerVendor(businessName, widget.email, phoneNumber, countryValue,
  //       stateValue, cityValue, taxNumber, _taxStatus!, _image)
  //       .whenComplete(() {
  //     EasyLoading.dismiss();
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => const LandingScreen(),
  //       ),
  //     );
  //   });
  //   if (res == "Success") {
  //     return showSnackBar(context, "Register store Success");
  //   } else {
  //     return showSnackBar(context, "Register store Fail");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        colors: [Colors.yellow.shade900, Colors.yellow],
                      ),
                    ),
                    child: Center(
                      child: Container(
                        height: 90,
                        width: 90,
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
                      businessName = value;
                    },
                    hintText: 'Business Name',
                    type: 'name',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // TextFieldCustom(
                  //   onChanged: (value) {
                  //     email = value;
                  //   },
                  //   hintText: 'Email Address',
                  //   type: TextInputType.emailAddress,
                  // ),
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  BaseInput(
                    onChanged: (value) {
                      phoneNumber = value;
                    },
                    hintText: 'Phone Number',
                    type: 'number',
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  CSCPicker(
                    ///Enable disable state dropdown [OPTIONAL PARAMETER]
                    showStates: true,

                    /// Enable disable city drop down [OPTIONAL PARAMETER]
                    showCities: true,

                    ///Enable (get flag with country name) / Disable (Disable flag) / ShowInDropdownOnly (display flag in dropdown only) [OPTIONAL PARAMETER]
                    flagState: CountryFlag.DISABLE,

                    ///Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER] (USE with disabledDropdownDecoration)
                    dropdownDecoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        color: Colors.white,
                        border:
                            Border.all(color: Colors.grey.shade300, width: 1)),

                    ///Disabled Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER]  (USE with disabled dropdownDecoration)
                    disabledDropdownDecoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                      color: Colors.grey.shade300,
                      border: Border.all(color: Colors.grey.shade300, width: 1),
                    ),

                    ///placeholders for dropdown search field
                    countrySearchPlaceholder: "Country",
                    stateSearchPlaceholder: "State",
                    citySearchPlaceholder: "City",

                    ///labels for dropdown
                    countryDropdownLabel: "Country",
                    stateDropdownLabel: "State",
                    cityDropdownLabel: "City",

                    ///Default Country
                    ///defaultCountry: CscCountry.India,

                    ///Country Filter [OPTIONAL PARAMETER]
                    countryFilter: const [
                      CscCountry.Vietnam
                    ],

                    ///Disable country dropdown (Note: use it with default country)
                    //disableCountry: true,

                    ///selected item style [OPTIONAL PARAMETER]
                    selectedItemStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),

                    ///DropdownDialog Heading style [OPTIONAL PARAMETER]
                    dropdownHeadingStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.bold),

                    ///DropdownDialog Item style [OPTIONAL PARAMETER]
                    dropdownItemStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),

                    ///Dialog box radius [OPTIONAL PARAMETER]
                    dropdownDialogRadius: 10.0,

                    ///Search bar radius [OPTIONAL PARAMETER]
                    searchBarRadius: 10.0,

                    ///triggers once country selected in dropdown
                    onCountryChanged: (value) {
                      setState(() {
                        ///store value in country variable
                        countryValue = value;
                      });
                    },

                    ///triggers once state selected in dropdown
                    onStateChanged: (value) {
                      setState(() {
                        ///store value in state variable
                        //stateValue = value;
                      });
                    },

                    ///triggers once city selected in dropdown
                    onCityChanged: (value) {
                      setState(() {
                        ///store value in city variable
                        //cityValue = value;
                      });
                    },

                    ///Show only specific countries using country filter
                    // countryFilter: ["United States", "Canada", "Mexico"],
                  ),

                  ///print newly selected country state and city in Text Widget
                  TextButton(
                      onPressed: () {
                        setState(() {
                          //address = "$cityValue, $stateValue, $countryValue";
                        });
                      },
                      child: Text("Print Data")),
                  //Text(address)

                  // Padding(
                  //   padding: const EdgeInsets.all(14),
                  //   child: SelectState(
                  //     onCountryChanged: (value) {
                  //       setState(() {
                  //         countryValue = value;
                  //       });
                  //     },
                  //     onStateChanged: (value) {
                  //       setState(() {
                  //         stateValue = value;
                  //       });
                  //     },
                  //     onCityChanged: (value) {
                  //       setState(() {
                  //         cityValue = value;
                  //       });
                  //     },
                  //   ),
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Tax Registered?',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Flexible(
                        child: SizedBox(
                          width: 150,
                          child: DropdownButtonFormField<String>(
                            hint: const Text('Select'),
                            items: _taxOption
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _taxStatus = value;
                              });
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                  _taxStatus == 'Yes'
                      ? BaseInput(
                          onChanged: (value) {
                            taxNumber = value;
                          },
                          hintText: 'Tax Number',
                          type: 'string',
                        )
                      : Container(),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: () {
                        //_registerStoreVendor();
                        //FirebaseAuth.instance.signOut();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
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
    );
  }
}
