import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ddnangcao_project/providers/restaurant_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../utils/color_lib.dart';
import '../../../utils/size_lib.dart';
import '../../main/views/navbar_custom.dart';

class EditResScreen extends StatefulWidget {
  final String id;
  final String name;
  final String timeOpen;
  final String timeClose;
  final String? image;
  final String address;

  const EditResScreen(
      {super.key,
      required this.name,
        required this.address,
      required this.id,
      required this.timeOpen,
      required this.timeClose,
      required this.image});

  @override
  State<EditResScreen> createState() => _EditResScreenState();
}

class _EditResScreenState extends State<EditResScreen> {
  final TextEditingController resNameController = TextEditingController();
  final TextEditingController timeOpenController = TextEditingController();
  final TextEditingController timeCloseController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  File? _image;
  String nameChange = "";
  String timeOpenChange = "";
  String timeCloseChange = "";

  _selectCameraImage() async {
    final ImagePicker _imagePicker = ImagePicker();

    final im = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (im != null) {
      setState(() {
        _image = File(im.path);
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameChange = widget.name;
    timeOpenChange = widget.timeOpen;
    timeCloseChange = widget.timeClose;
    resNameController.text = widget.name;
    timeOpenController.text = widget.timeOpen;
    timeCloseController.text = widget.timeClose;
    addressController.text = widget.address;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Store"),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: GestureDetector(
              onTap: () async {
                if (nameChange != widget.name ||
                    timeOpenChange != widget.timeOpen ||
                    timeCloseChange != widget.timeClose ||
                    _image != null) {
                  EasyLoading.show();
                  await Provider.of<RestaurantProvider>(context, listen: false)
                      .editRes(widget.id, nameChange, timeOpenChange,
                          timeCloseChange, _image!);
                  EasyLoading.dismiss();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CustomerHomeScreen(),
                    ),
                  );
                }
              },
              child: Text(
                "Save",
                style: TextStyle(
                  fontSize: 18,
                  color: nameChange != widget.name ||
                          timeOpenChange != widget.timeOpen ||
                          timeCloseChange != widget.timeClose ||
                          _image != null
                      ? Colors.red
                      : Colors.grey,
                ),
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            _image == null
                ? SizedBox(
                    width: 130,
                    height: 130,
                    child: CachedNetworkImage(
                      fit: BoxFit.fill,
                      imageUrl: widget.image ?? "",
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) => Center(
                        child: CircularProgressIndicator(
                            value: downloadProgress.progress),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  )
                : Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 120,
                        width: 120,
                        child: Image.file(
                          _image!,
                          fit: BoxFit.fill,
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      )
                    ],
                  ),
            TextFormField(
              controller: resNameController,
              onChanged: (value) {
                nameChange = value;
                setState(() {
                  nameChange = value;
                });
              },
              decoration: const InputDecoration(
                  hintText: "Enter Store Name", labelText: "Store Name"),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: addressController,
              decoration: const InputDecoration(labelText: "Address"),
              readOnly: true,
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 50,
                  width: GetSize.getWidth(context) * .3,
                  child: TextFormField(
                    controller: timeOpenController,
                    onChanged: (value) {
                      timeOpenChange = value;
                    },
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        hintText: "Enter Time Open", labelText: "Time Open"),
                  ),
                ),
                const SizedBox(
                  width: 30,
                ),
                SizedBox(
                  height: 50,
                  width: GetSize.getWidth(context) * .3,
                  child: TextFormField(
                    controller: timeCloseController,
                    onChanged: (value) {
                      timeCloseChange = value;
                    },
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "Time Close",
                      hintText: "Enter Time Close",
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () async {
                    await _selectCameraImage();
                  },
                  child: Container(
                    height: 60,
                    width: GetSize.getWidth(context) / 2.5,
                    decoration: BoxDecoration(
                        border: Border.all(color: ColorLib.primaryColor)),
                    child: const Center(
                      child: Column(
                        children: [
                          Icon(
                            Icons.camera_alt,
                            color: ColorLib.primaryColor,
                          ),
                          Text("Choose Food Image")
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      )),
    );
  }
}
