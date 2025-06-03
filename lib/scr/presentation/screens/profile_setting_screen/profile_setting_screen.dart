import 'package:auto_route/auto_route.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:e_commerce_frontend/scr/core/common_domain/enum/user_gender_enum.dart';
import 'package:e_commerce_frontend/scr/core/utils/helpers/responsive_ui_helper/responsive_ui_config.dart';
import 'package:e_commerce_frontend/scr/core/utils/loading_dialog/loading_dialog.dart';
import 'package:e_commerce_frontend/scr/core/utils/theme/theme_provider.dart';
import 'package:e_commerce_frontend/scr/core/utils/toast/flutter_toast.dart';
import 'package:e_commerce_frontend/scr/core/utils/values/colors.dart';
import 'package:e_commerce_frontend/scr/data/models/request/user_request_model/user_request_model.dart';
import 'package:e_commerce_frontend/scr/presentation/bloc/user_profile_setting/user_profile_setting_bloc.dart';
import 'package:e_commerce_frontend/scr/presentation/widgets/text_form_field_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

@RoutePage()
class ProfileSettingScreen extends StatefulWidget {
  const ProfileSettingScreen({super.key});

  @override
  State<ProfileSettingScreen> createState() => _ProfileSettingScreenState();
}

class _ProfileSettingScreenState extends State<ProfileSettingScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  void _handleUpdate(BuildContext context, UserRequestModel userRequestModel) {
    if (_formKey.currentState!.validate()) {
      // If the form is valid, proceed with the update
      context.read<UserProfileSettingBloc>().add(
        UpdateUserProfilePartially(userInfo: userRequestModel),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    context.read<UserProfileSettingBloc>().add(const LoadUser());
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    final responsive = ResponsiveUiConfig(context);
    return BlocConsumer<UserProfileSettingBloc, UserProfileSettingState>(
      listener: (context, state) {
        switch (state) {
          case UserProfileUpdated():
            _fullNameController.text = state.userInfo.name;
            _phoneNumberController.text = state.userInfo.phoneNumber;
            context.router.pop();
            showToast(
              msg: 'Updated profile successfully!',
              textColor: Colors.green,
            );
          case UserProfileError():
            context.router.pop();
            showToast(msg: state.message, textColor: Colors.red);
          case UserProfileLoaded():
            _fullNameController.text = state.userInfo.name;
            _phoneNumberController.text = state.userInfo.phoneNumber;
            context.router.pop();
          default:
            showLoadingDialog(context: context, isDarkMode: isDarkMode);
            break;
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor:
                isDarkMode ? ColorDark.background : ColorLight.background,
            title: Text(
              'Profile Settings',
              style: TextStyle(
                color: isDarkMode ? ColorDark.titleText : ColorLight.titleText,
                fontWeight: FontWeight.bold,
                fontSize: responsive.setWidth(18),
              ),
            ),
            centerTitle: true,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_new,
                color:
                    isDarkMode ? ColorDark.iconPrimary : ColorLight.iconPrimary,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          body: switch (state) {
            UserProfileUpdated() => _BuildBody(
              formKey: _formKey,
              email: state.userInfo.email,
              phoneNumber: _phoneNumberController,
              fullName: _fullNameController,
              imageUrl: state.userInfo.image,
              selectedDate: state.userInfo.birthday,
              selectedGender: state.userInfo.gender,
              isDarkMode: isDarkMode,
              responsive: responsive,
              onDateChange: (date) {
                context.read<UserProfileSettingBloc>().add(
                  UpdateDate(date: date),
                );
              },
              onGenderChange: (gender) {
                context.read<UserProfileSettingBloc>().add(
                  UpdateGender(gender: gender),
                );
              },
            ),
            UserProfileLoaded() => _BuildBody(
              formKey: _formKey,
              email: state.userInfo.email,
              phoneNumber: _phoneNumberController,
              fullName: _fullNameController,
              imageUrl: state.userInfo.image,
              selectedDate: state.userInfo.birthday,
              selectedGender: state.userInfo.gender,
              isDarkMode: isDarkMode,
              responsive: responsive,
              onDateChange: (date) {
                context.read<UserProfileSettingBloc>().add(
                  UpdateDate(date: date),
                );
              },
              onGenderChange: (gender) {
                context.read<UserProfileSettingBloc>().add(
                  UpdateGender(gender: gender),
                );
              },
            ),
            _ => const Center(child: CircularProgressIndicator()),
          },
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
            child: switch (state) {
              UserProfileLoaded() => _BuildSubmitButton(
                fullName: state.userInfo.name,
                phoneNumber: state.userInfo.phoneNumber,
                selectedDate: state.userInfo.birthday,
                selectedGender: state.userInfo.gender,
                responsive: responsive,
                isDarkMode: isDarkMode,
                handleUpdate: _handleUpdate,
              ),
              UserProfileUpdated() => _BuildSubmitButton(
                fullName: state.userInfo.name,
                phoneNumber: state.userInfo.phoneNumber,
                selectedDate: state.userInfo.birthday,
                selectedGender: state.userInfo.gender,
                responsive: responsive,
                isDarkMode: isDarkMode,
                handleUpdate: _handleUpdate,
              ),
              _ => _BuildSubmitButton(
                fullName: '',
                phoneNumber: '',
                selectedDate: DateTime.now(),
                selectedGender: Gender.other,
                responsive: responsive,
                isDarkMode: isDarkMode,
                handleUpdate: null,
              ),
            },
          ),
        );
      },
    );
  }
}

class _BuildBody extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final String email;
  final TextEditingController fullName;
  final TextEditingController phoneNumber;
  final String imageUrl;
  final bool isDarkMode;
  final ResponsiveUiConfig responsive;
  final DateTime? selectedDate;
  final Gender? selectedGender;
  final Function(DateTime?)? onDateChange;
  final Function(Gender?)? onGenderChange;

  const _BuildBody({
    required this.formKey,
    this.selectedDate,
    this.selectedGender,
    required this.email,
    required this.fullName,
    required this.phoneNumber,
    required this.imageUrl,
    required this.isDarkMode,
    required this.responsive,
    this.onDateChange,
    this.onGenderChange,
    super.key,
  });

  @override
  _BuildBodyState createState() => _BuildBodyState();
}

class _BuildBodyState extends State<_BuildBody> {
  DateTime? _selectedDate;
  Gender? _selectedGender;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.selectedDate;
    _selectedGender = widget.selectedGender;
  }

  Future<void> selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
      widget.onDateChange?.call(pickedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Form(
          key: widget.formKey,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: widget.responsive.setHeight(40),
                ),
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 70,
                      backgroundColor: Colors.pink[100],
                      child:
                          widget.imageUrl.isEmpty
                              ? Icon(
                                Icons.person,
                                size: 80,
                                color: Colors.white,
                              )
                              : ClipOval(
                                child: Image.network(
                                  widget.imageUrl,
                                  width: 140,
                                  height: 140,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Icon(
                                      Icons.person,
                                      size: 80,
                                      color: Colors.white,
                                    );
                                  },
                                  loadingBuilder: (
                                    context,
                                    child,
                                    loadingProgress,
                                  ) {
                                    if (loadingProgress == null) return child;
                                    return Center(
                                      child: CircularProgressIndicator(
                                        value:
                                            loadingProgress
                                                        .expectedTotalBytes !=
                                                    null
                                                ? loadingProgress
                                                        .cumulativeBytesLoaded /
                                                    loadingProgress
                                                        .expectedTotalBytes!
                                                : null,
                                      ),
                                    );
                                  },
                                ),
                              ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {},
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.grey[800],
                          child: Icon(
                            Icons.camera_alt,
                            size: 15,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: widget.responsive.setHeight(20)),
              TextFormFieldCustom(
                label: 'Full Name',
                placeholder: 'Enter your Full Name',
                controller: widget.fullName,
                onChanged: (value) {
                  context.read<UserProfileSettingBloc>().add(
                    UpdateFullName(fullName: value),
                  );
                },
                isDarkMode: widget.isDarkMode,
                responsive: widget.responsive,
              ),
              SizedBox(height: widget.responsive.setHeight(16)),
              TextFormFieldCustom(
                label: 'Email',
                placeholder: 'Enter your Email',
                initialValue: widget.email,
                isDarkMode: widget.isDarkMode,
                responsive: widget.responsive,
                readOnly: true,
              ),
              SizedBox(height: widget.responsive.setHeight(15)),
              TextFormFieldCustom(
                label: 'Phone',
                placeholder: 'Enter your Phone Number',
                controller: widget.phoneNumber,
                onChanged: (value) {
                  context.read<UserProfileSettingBloc>().add(
                    UpdatePhone(phone: value),
                  );
                },
                isDarkMode: widget.isDarkMode,
                responsive: widget.responsive,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value != null && value.length != 10) {
                    return 'Phone number must be 10 digits';
                  }
                  return null;
                },
              ),
              SizedBox(height: widget.responsive.setHeight(16)),
              Row(
                children: [
                  Expanded(
                    child: DropdownButton2<Gender>(
                      isExpanded: true,
                      hint: Text(
                        "Select Gender",
                        style: TextStyle(
                          color:
                              widget.isDarkMode
                                  ? ColorDark.titleText
                                  : ColorLight.titleText,
                          fontWeight: FontWeight.bold,
                          fontSize: widget.responsive.setWidth(14),
                        ),
                      ),
                      items:
                          Gender.values
                              .map(
                                (Gender gender) => DropdownMenuItem<Gender>(
                                  value: gender,
                                  child: Text(
                                    gender.name,
                                    style: TextStyle(
                                      color:
                                          widget.isDarkMode
                                              ? ColorDark.titleText
                                              : ColorLight.titleText,
                                      fontWeight: FontWeight.bold,
                                      fontSize: widget.responsive.setWidth(14),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                      value: _selectedGender,
                      onChanged: (value) {
                        setState(() {
                          _selectedGender = value;
                        });
                        widget.onGenderChange?.call(value);
                      },
                      buttonStyleData: ButtonStyleData(
                        padding: EdgeInsets.all(widget.responsive.setWidth(5)),
                        decoration: BoxDecoration(
                          color:
                              widget.isDarkMode
                                  ? ColorDark.background
                                  : ColorLight.background,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color:
                                widget.isDarkMode
                                    ? ColorDark.titleText
                                    : ColorLight.titleText,
                          ),
                        ),
                      ),
                      iconStyleData: IconStyleData(
                        icon: Icon(Icons.arrow_forward_ios_outlined),
                        iconSize: widget.responsive.setWidth(14),
                        iconEnabledColor:
                            widget.isDarkMode
                                ? ColorDark.iconPrimary
                                : ColorLight.iconPrimary,
                        iconDisabledColor:
                            widget.isDarkMode
                                ? ColorDark.iconSecondary
                                : ColorLight.iconSecondary,
                      ),
                      dropdownStyleData: DropdownStyleData(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color:
                              widget.isDarkMode
                                  ? ColorDark.background2
                                  : ColorLight.background2,
                        ),
                        scrollbarTheme: ScrollbarThemeData(
                          radius: const Radius.circular(40),
                        ),
                      ),
                      menuItemStyleData: const MenuItemStyleData(
                        height: 40,
                        padding: EdgeInsets.only(left: 14, right: 14),
                      ),
                      underline: Container(),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: TextButton(
                      onPressed: selectDate,
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.all(
                          widget.responsive.setHeight(16),
                        ),
                        backgroundColor:
                            widget.isDarkMode
                                ? ColorDark.background2
                                : ColorLight.background2,
                        foregroundColor:
                            widget.isDarkMode
                                ? ColorDark.titleText
                                : ColorLight.titleText,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        _selectedDate == null
                            ? 'Select Date of Birth'
                            : '${_selectedDate!.year}-${_selectedDate!.month}-${_selectedDate!.day}',
                        style: TextStyle(
                          fontSize: widget.responsive.setWidth(14),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BuildSubmitButton extends StatelessWidget {
  final Function(BuildContext, UserRequestModel)? handleUpdate;
  final String fullName;
  final String phoneNumber;
  final DateTime? selectedDate;
  final Gender? selectedGender;
  final bool isDarkMode;
  final ResponsiveUiConfig responsive;
  const _BuildSubmitButton({
    required this.handleUpdate,
    required this.fullName,
    required this.phoneNumber,
    required this.selectedDate,
    required this.selectedGender,
    required this.isDarkMode,
    required this.responsive,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed:
          () =>
              handleUpdate != null
                  ? handleUpdate!(
                    context,
                    UserRequestModel(
                      name: fullName,
                      phoneNumber: phoneNumber.isEmpty ? null : phoneNumber,
                      gender: selectedGender,
                      birthday: selectedDate,
                    ),
                  )
                  : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: isDarkMode ? Colors.white : Colors.black,
        foregroundColor: isDarkMode ? Colors.black : Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      child: Text(
        'Save Change',
        style: TextStyle(fontSize: responsive.setWidth(16)),
      ),
    );
  }
}
