import 'dart:io';

import 'package:cn1_d_wallet/common/enum/gender-type.dart';
import 'package:cn1_d_wallet/models/file-model.dart';
import 'package:cn1_d_wallet/models/users/account.model.dart';
import 'package:cn1_d_wallet/pages/profiles/widgets/textfield-profile.dart';
import 'package:cn1_d_wallet/providers/user-profile-provider.dart';
import 'package:cn1_d_wallet/services/files-service.dart';
import 'package:cn1_d_wallet/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common/constant/app-colors.dart';
import '../../common/constant/app_styles.dart';

class PersonalScreen extends StatefulWidget {
  PersonalScreen({super.key});

  @override
  State<PersonalScreen> createState() => _PersonalScreenState();
}

class _PersonalScreenState extends State<PersonalScreen> {
  late UserProfileProvider _userProfileProvider;
  late final SharedPreferences prefs;

  String _avatar =
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSeeJ6oLaKkQiCeiH6DHrRu492XWtwaf44wJkt6hLBBUg&s";
  String _fullname = "";
  String _email = "";
  String _phone = "";
  String _address = "";
  DateTime? _selectedDate;
  String _selectedItem = GenderType[0];

  @override
  void initState() {
    super.initState();
    initDefaultValue();
  }

  initDefaultValue() async {
    prefs = await SharedPreferences.getInstance();
    _userProfileProvider =
        // ignore: use_build_context_synchronously
        Provider.of<UserProfileProvider>(context, listen: false);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _userProfileProvider.userProfile!.dob != null
          ? DateTime.parse(_userProfileProvider.userProfile!.dob!)
          : DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      helpText: 'SELECT DATE AND YEAR',
      cancelText: 'CANCEL',
      confirmText: 'SELECT',
      errorFormatText: 'Invalid date format',
      errorInvalidText: 'Invalid date',
    );
    if (pickedDate != null &&
        pickedDate !=
            (_userProfileProvider.userProfile!.dob != null
                ? DateTime.parse(_userProfileProvider.userProfile!.dob!)
                : DateTime.now())) {
      _userProfileProvider.setDob = pickedDate.toIso8601String();
    }
  }

  Future<void> _getImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final imageFile = File(pickedFile.path);
      FileModel? fileModel = await FilesService(context: context, prefs: prefs)
          .uploadFile(imageFile);
      _userProfileProvider.setAvatar = fileModel!.url;
      // ignore: use_build_context_synchronously
      await _userProfileProvider.updateUserProfile(context, prefs);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Fill Your Profile",
          style: AppStyles.h4,
        ),
        elevation: 0,
      ),
      backgroundColor: AppColors.primaryBackground,
      body: Consumer<UserProfileProvider>(
          builder: (conetxt, userProfileProvider, child) {
        final AccountModel? userProfile = userProfileProvider.userProfile;

        if (userProfile != null) {
          _address = userProfile.address ?? _address;
          _avatar = userProfile.avatar ?? _avatar;
          _selectedDate = userProfile.dob != null
              ? DateTime.parse(userProfile.dob!)
              : DateTime.now();
          _email = userProfile.email ?? _email;
          _fullname = userProfile.name ?? _fullname;
          _phone = userProfile.phone ?? _phone;
          _selectedItem = userProfile.gender == null
              ? GenderType[0]
              : userProfile.gender == "MALE"
                  ? GenderType[0]
                  : GenderType[1];
        }

        return Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          width: double.infinity,
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: Stack(
                        children: [
                          SizedBox(
                            height: 120,
                            width: 120,
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(_avatar),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: InkWell(
                                onTap: () {
                                  _getImageFromGallery();
                                },
                                child: Container(
                                  height: 30,
                                  width: 30,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryColor,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: const Icon(
                                    Icons.edit,
                                    color: AppColors.primaryBackground,
                                    size: 20,
                                  ),
                                )),
                          ),
                        ],
                      ),
                    ),
                    TextfieldProfileWidget(
                      onChanged: (value) {},
                      hindText: "Full Name",
                      textDefault: _fullname,
                      isEnabled: false,
                    ),
                    TextfieldProfileWidget(
                      onChanged: (value) {},
                      hindText: "Email",
                      isUseIcon: true,
                      iconDefault: Icon(Icons.email),
                      textDefault: _email,
                      isEnabled: false,
                    ),
                    TextfieldProfileWidget(
                      onChanged: (value) {
                        _userProfileProvider.setPhone = value;
                      },
                      hindText: "Phone",
                      isUseIcon: true,
                      iconDefault: Icon(Icons.phone),
                      textDefault: _phone,
                    ),
                    TextfieldProfileWidget(
                      onChanged: (value) {
                        _userProfileProvider.setAddress = value;
                      },
                      hindText: "Address",
                      textDefault: _address,
                      // iconDefault: Ico,
                    ),
                    // TextfieldProfileWidget(
                    //   onChanged: (value) {},
                    //   hindText: "Date of Birth",
                    //   isUseIcon: true,
                    //   iconDefault: Icon(Icons.calendar_month),
                    //   textDefault: _dob,
                    // ),
                    InkWell(
                      onTap: () => _selectDate(context),
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        padding: const EdgeInsets.all(16),
                        decoration: const BoxDecoration(
                          color: AppColors.backgroudSecondColor,
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.calendar_month,
                                color: AppColors.greyText),
                            const SizedBox(width: 10),
                            Text(
                              "${DateFormat('dd/MM/yyyy').format(_selectedDate!)}",
                              style: AppStyles.h5,
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: DropdownButtonFormField(
                        value: _selectedItem,
                        onChanged: (value) {
                          _userProfileProvider.setGender = value!;
                        },
                        items: GenderType.map<DropdownMenuItem<String>>(
                            (String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        decoration: const InputDecoration(
                          labelText: "Gender",
                          labelStyle: TextStyle(color: AppColors.greyText),
                          filled: true,
                          fillColor: AppColors.backgroudSecondColor,
                          contentPadding: EdgeInsets.all(20),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColors.primaryColor),
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                child: AppButton(
                  text: "Save",
                  onTap: () async {
                    await _userProfileProvider.updateUserProfile(
                        context, prefs);
                  },
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
