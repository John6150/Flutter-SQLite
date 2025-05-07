import 'package:flutter/material.dart';
import 'package:sqlflite_class/controllers.dart';

class InputFieldWidget extends StatelessWidget {
  final String? name;
  final TextEditingController control;
  // String? age;
  // String? gender;
  final String? sample;
  const InputFieldWidget({
    super.key,
    required this.name,
    required this.control,
    // required this.age,
    // required this.gender,
    required this.sample,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: control,
      decoration: InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.all(9),
        // helper: Text('Name'),
        helperMaxLines: 10,
        hintText: sample,
        label: Text(name!),
        border: OutlineInputBorder(borderSide: BorderSide(width: 1.0)),
      ),
    );
  }
}

class DropDownWidget extends StatefulWidget {
  final String? title;
  List<DropdownMenuItem> dropDown;
  DropDownWidget({super.key, required this.title, required this.dropDown});

  @override
  State<DropDownWidget> createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      height: 40,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: const Color.fromARGB(139, 0, 0, 0),
          ),
          borderRadius: BorderRadius.all(Radius.circular(3)),
        ),
        padding: EdgeInsets.all(3),
        child: DropdownButton(
          hint: Text(widget.title!),
          focusColor: Colors.transparent,
          dropdownColor: const Color.fromARGB(255, 248, 221, 252),
          isDense: true,
          alignment: AlignmentDirectional.bottomCenter,
          isExpanded: true,
          padding: EdgeInsets.all(2),
          borderRadius: BorderRadius.all(Radius.circular(2)),
          style: TextStyle(color: Colors.black),
          icon: Icon(Icons.school),
          value: course,
          items: widget.dropDown,
          onChanged: (value) {
            setState(() {
              course = value;
              print(course);
            });

            // setState(() {
            //   _course = value;
            // });
          },
        ),
      ),
    );
  }
}
