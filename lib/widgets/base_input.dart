import 'package:ddnangcao_project/utils/color_lib.dart';
import 'package:flutter/material.dart';

class BaseInput extends StatefulWidget {
  final String type;
  final String hintText;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final bool? isPass;
  final String? initialValue;
  final bool? isNumberType;

  const BaseInput(
      {super.key,
      required this.type,
      required this.hintText,
      this.onChanged,
      this.validator,
        this.initialValue,
        this.isNumberType = false,
      this.isPass = false});

  @override
  State<BaseInput> createState() => _BaseInputState();
}

class _BaseInputState extends State<BaseInput> {
  bool isHiddenPass = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.type,
          style: const TextStyle(fontSize: 20),
        ),
        TextFormField(
          obscureText: widget.isPass == true ? isHiddenPass : false,
          onChanged: widget.onChanged,
          validator: widget.validator,
          keyboardType: widget.isNumberType == true ? TextInputType.number : null,
          initialValue: widget.initialValue,

          decoration: InputDecoration(
            suffixIcon: widget.isPass == true
                ? GestureDetector(
                    onTap: () {
                      setState(() {
                        isHiddenPass = !isHiddenPass;
                      });
                    },
                    child: isHiddenPass == true
                        ? const Icon(Icons.visibility)
                        : const Icon(Icons.visibility_off),
                  )
                : null,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            hintText: widget.hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10)
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: ColorLib.greyColor
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                  color: ColorLib.primaryColor
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                  color: ColorLib.primaryColor
              ),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        )
      ],
    );
  }
}
