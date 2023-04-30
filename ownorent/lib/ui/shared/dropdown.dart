import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../../utils/font_size.dart';

class CeoDropdown extends StatefulWidget {
  final String? hint;
  final List? items;
  final String? value;
  Function? onChanged;
  CeoDropdown({Key? key, this.hint, this.items, this.value, this.onChanged})
      : super(key: key);
  @override
  CeoDropdownState createState() => CeoDropdownState();
}

class CeoDropdownState extends State<CeoDropdown> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: greyOne),
        width: MediaQuery.of(context).size.width / 1.1,
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        child: Theme(
          data: Theme.of(context).copyWith(canvasColor: ownorentWhite),
          child: DropdownButton(
            menuMaxHeight: MediaQuery.of(context).size.height / 2.5,
            value: widget.value,
            style: TextStyle(color: ownorentBlack),
            isExpanded: true,
            iconEnabledColor: ownorentPurple,
            iconDisabledColor: ownorentPurple,
            hint: Text(
              widget.hint!,
              style: TextStyle(
                  color: ownorentPurpleGrey,
                  fontSize: TextSize().p(context),
                  fontWeight: FontWeight.w500),
            ),
            underline: Text(''),
            onChanged: (value) {
              widget.onChanged!(value);
            },
            items: widget.items?.map((val) {
              return DropdownMenuItem(
                value: val,
                child: Text(
                  val,
                  style: TextStyle(
                      fontSize: TextSize().p(context), color: ownorentPurple),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
