import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:ownorent/ui/shared/custom_textfield.dart';
import 'package:ownorent/ui/shared/dropdown.dart';
import 'package:ownorent/ui/views/house_location.dart';
import 'package:ownorent/utils/bedroom_number.dart';
import 'package:ownorent/utils/house_types.dart';
import 'package:ownorent/utils/payment_type.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../core/services/authentication.dart';
import '../../core/viewmodels/house_viewmodel.dart';
import '../../core/viewmodels/user_viewmodel.dart';
import '../../utils/colors.dart';
import '../../utils/font_size.dart';
import '../../utils/router.dart';
import '../shared/icon_circle.dart';

class HouseDescription extends StatefulWidget {
  const HouseDescription({super.key});

  @override
  State<HouseDescription> createState() => _HouseDescriptionState();
}

class _HouseDescriptionState extends State<HouseDescription> {
  TextEditingController _desc = TextEditingController();
  TextEditingController _price = TextEditingController();
  bool? isPrice;
  @override
  Widget build(BuildContext context) {
    AuthenticationService _auth = Provider.of<AuthenticationService>(context);
    HouseViewmodel _houseViewmodel = Provider.of<HouseViewmodel>(context);
    UserViewmodel _userViewModel = Provider.of<UserViewmodel>(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: ownorentWhite,
        leading: IconButton(
          onPressed: () {
            RouteController().pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: ownorentPurple,
          ),
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: ownorentWhite,
        padding: EdgeInsets.only(left: 10, right: 5),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconCircle(
                icon: Icons.add_home,
                color: ownorentPurple,
              ),
              Container(
                margin: EdgeInsets.only(top: 7),
                child: Text(
                  "Describe your listing",
                  style: TextStyle(
                      color: ownorentPurple,
                      fontWeight: FontWeight.w500,
                      fontSize: TextSize().h2(context)),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 6),
                child: Text(
                  "Tell potential buyers about the house you want to put on the market",
                  style: TextStyle(
                      color: ownorentPurpleGrey,
                      fontSize: TextSize().h3(context)),
                ),
              ),
              Container(
                height: 10,
              ),
              CeoDropdown(
                items: paymentType,
                value: _houseViewmodel.paymentType,
                hint: "Listing type",
                onChanged: (value) {
                  _houseViewmodel.setPaymentType(value);
                },
              ),
              Container(
                height: 5,
              ),
              CeoDropdown(
                items: houseTypes,
                value: _houseViewmodel.houseType,
                hint: "House type",
                onChanged: (value) {
                  _houseViewmodel.setHouseType(value);
                },
              ),
              Container(
                height: 5,
              ),
              CeoDropdown(
                items: getBedroomNumber(),
                value: _houseViewmodel.bedroomNumber,
                hint: "No of rooms",
                onChanged: (value) {
                  _houseViewmodel.setBedroomNumber(value);
                },
              ),
              Container(
                height: 5,
              ),
              CeoDropdown(
                items: getBedroomNumber(),
                value: _houseViewmodel.bathroomNumber,
                hint: "No of bathrooms",
                onChanged: (value) {
                  _houseViewmodel.setBathroomNumber(value);
                },
              ),
              Container(
                height: 5,
              ),
              Center(
                child: CustomTextField(
                  hintText: "Price",
                  controller: _price,
                  errorText: isPrice == false ? "Invalid price" : null,
                  onChanged: (String value) {
                    if (value.isNumber() && value.length > 2) {
                      setState(() {
                        isPrice = true;
                      });
                    } else {
                      setState(() {
                        isPrice = false;
                      });
                    }
                  },
                ),
              ),
              Container(
                height: 5,
              ),
              Center(
                child: CustomTextField(
                  hintText: "Describe this house in your own words",
                  controller: _desc,
                  maxChar: 250,
                  minLines: 5,
                ),
              ),
              Container(
                height: 10,
              ),
              Center(
                  child: Container(
                width: MediaQuery.of(context).size.width / 1.1,
                height: 60,
                margin: EdgeInsets.only(bottom: 10, top: 25),
                decoration: BoxDecoration(
                  color: _houseViewmodel.bathroomNumber != null &&
                          _houseViewmodel.bedroomNumber != null &&
                          _houseViewmodel.houseType != null &&
                          _houseViewmodel.paymentType != null &&
                          isPrice == true
                      ? ownorentPurple
                      : ownorentPurpleGrey,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: MaterialButton(
                  onPressed: _houseViewmodel.bathroomNumber != null &&
                          _houseViewmodel.bedroomNumber != null &&
                          _houseViewmodel.houseType != null &&
                          _houseViewmodel.paymentType != null &&
                          isPrice == true
                      ? () {
                          String descp =
                              "${_houseViewmodel.bedroomNumber}-bedroom ${_houseViewmodel.houseType} available for ${_houseViewmodel.paymentType}.";
                          if (_desc.text == "" || _desc.text == null) {
                            _houseViewmodel.setDesc(descp);
                            _houseViewmodel.setPrice(_price.text);
                            print(_houseViewmodel.description);
                          } else {
                            _houseViewmodel.setDesc(_desc.text);
                            _houseViewmodel.setPrice(_price.text);
                          }
                          RouteController().push(context, HouseLocation());
                        }
                      : null,
                  child: Text(
                    "Next",
                    style: TextStyle(
                        color: ownorentWhite, fontSize: TextSize().h3(context)),
                  ),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
