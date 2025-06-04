// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:laylah_app/utils/constants/exports.dart';
import 'package:permission_handler/permission_handler.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  Future<void> _pickImage(BuildContext context) async {
    if (Platform.isAndroid) {
      if (await Permission.photos.isGranted ||
          await Permission.storage.isGranted ||
          await Permission.mediaLibrary.isGranted) {
        final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
        if (pickedFile != null) {
          setState(() {
            _selectedImage = File(pickedFile.path);
          });
        } else {
          debugPrint("No image selected.");
        }
      } else {
        final permissionStatus = await Permission.storage.request();
        final mediaImageStatus = await Permission.photos.request();
        final readMediaStatus = await Permission.mediaLibrary.request();

        if (permissionStatus.isGranted ||
            mediaImageStatus.isGranted ||
            readMediaStatus.isGranted) {
          _pickImage(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Permission to access gallery is required")),
          );
        }
      }
    } else {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _selectedImage = File(pickedFile.path);
        });
      } else {
        debugPrint("No image selected.");
      }
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => getData());
  }

  Future<void> getData() async {
    final profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);
    await profileProvider.fetchUserData(context);
    final data = profileProvider.getUserData?.data;

    if (data != null) {
      _nameController.text = data.userName ?? '';
      _emailController.text = data.email ?? '';
      _phoneController.text = data.phone ?? '';
      _addressController.text = data.address ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    final isLoading = profileProvider.getUserData?.data == null;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          'Edit Profile',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        backgroundColor: MyAppColors.dullRedColor,
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
        ),
      ),
      body: isLoading
          ? SingleChildScrollView(
              padding: EdgeInsets.only(bottom: 40),
              child: Column(
                children: [
                  _buildShimmerHeader(),
                  SizedBox(height: 40),
                  _buildShimmerForm(),
                  SizedBox(height: 30),
                  _buildShimmerButton(),
                ],
              ),
            )
          : SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(bottom: 40),
                child: Column(
                  children: [
                    _buildProfileHeader(context),
                    SizedBox(height: 40),
                    _buildProfileForm(context),
                    SizedBox(height: 30),
                    _buildSaveButton(),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 170,
          decoration: BoxDecoration(
            color: MyAppColors.dullRedColor,
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(28)),
          ),
        ),
        Positioned(
          top: 100,
          left: 0,
          right: 0,
          child: Center(
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                GestureDetector(
                  onTap: () => _pickImage(context), 
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 3),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      radius: 56,
                      backgroundColor: Colors.white,
                      child: ClipOval(
                        child: _selectedImage != null
                            ? Image.file(
                                _selectedImage!,
                                width: 110,
                                height: 110,
                                fit: BoxFit.cover,
                              )
                            : Image.network(
                                'https://laylahnovel.com/API/${profileProvider.getUserData!.data!.image}',
                                width: 110,
                                height: 110,
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 4,
                  right: 4,
                  child: Container(
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: MyAppColors.dullRedColor,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 6,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.camera_alt,
                      size: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProfileForm(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            _buildInputField('Full Name', _nameController),
            SizedBox(height: 20),
            _buildInputField('Email', _emailController, isEmail: true),
            SizedBox(height: 20),
            _buildInputField('Phone', _phoneController),
            SizedBox(height: 20),
            _buildInputField('Address', _addressController),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(String label, TextEditingController controller,
      {bool isEmail = false}) {
    TextInputType keyboardType = TextInputType.text;

    if (isEmail) {
      keyboardType = TextInputType.emailAddress;
    } else if (label.toLowerCase().contains("phone")) {
      keyboardType = TextInputType.phone;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15,
              color: Colors.grey[800],
            )),
        SizedBox(height: 10),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'This field is required';
            }
            if (isEmail &&
                !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$')
                    .hasMatch(value.trim())) {
              return 'Enter a valid email';
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: controller.text,
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.symmetric(horizontal: 18, vertical: 16),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: MyAppColors.dullRedColor),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSaveButton() {
    final profileProvider = Provider.of<ProfileProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: ElevatedButton.icon(
        onPressed: profileProvider.loading
            ? null
            : () async {
                if (_formKey.currentState!.validate()) {
                  final profileProvider =
                      Provider.of<ProfileProvider>(context, listen: false);
                  final userName = _nameController.text;
                  final email = _emailController.text;
                  final address = _addressController.text;
                  final phone = _phoneController.text;
                  final File? image = _selectedImage;

                  if (image != null) {
                    await profileProvider.updateProfile(
                        context, userName, email, phone, address, image);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Profile saved successfully')),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please select a profile image')),
                    );
                  }
                }
              },
        icon: profileProvider.loading
            ? null
            : Icon(Icons.save_rounded, color: Colors.white),
        label: profileProvider.loading
            ? Center(
                child: CupertinoActivityIndicator(),
              )
            : Text(
                'Save Changes',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
        style: ElevatedButton.styleFrom(
          backgroundColor: MyAppColors.dullRedColor,
          padding: EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          minimumSize: Size.fromHeight(52),
          elevation: 4,
        ),
      ),
    );
  }

  // ---------------- Shimmers effect ----------------

  Widget _buildShimmerHeader() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 170,
          decoration: BoxDecoration(
            color: MyAppColors.dullRedColor,
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(28)),
          ),
        ),
        Positioned(
          top: 100,
          left: 0,
          right: 0,
          child: Center(
            child: Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: CircleAvatar(
                radius: 60,
                backgroundColor: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildShimmerForm() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        children: List.generate(4, (index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: Container(
                  width: 100,
                  height: 15,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: Container(
                  height: 55,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildShimmerButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Container(
          height: 52,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
    );
  }
}
