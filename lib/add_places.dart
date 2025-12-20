import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:newprojectfirebase/features/widgets/custom_elevated_button.dart';
import 'package:newprojectfirebase/features/widgets/custom_textformfield.dart';

class AddPlacesScreen extends StatefulWidget {
  const AddPlacesScreen({super.key});

  @override
  State<AddPlacesScreen> createState() => _AddPlacesScreenState();
}

class _AddPlacesScreenState extends State<AddPlacesScreen> {
  String? destinationName;
  String? description;
  File? selectedImage; // stores selected image
  final ImagePicker _picker = ImagePicker();

  
  Future<void> pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text(
          "Add Places",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ---------------- Destination ----------------
            const Text(
              "Destination",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            CustomTextform(
              labelText: "Enter the destination name",
              onChanged: (val) {
                destinationName = val;
              },
            ),

            const SizedBox(height: 16),

            // ---------------- About Destination ----------------
            const Text(
              "About the Destination",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            CustomTextform(
              labelText: "Brief description of the destination",
              maxLines: 5,
              keyboardType: TextInputType.multiline,
              onChanged: (val) {
                description = val;
              },
            ),

            const SizedBox(height: 16),

            // ---------------- Upload Image ----------------
            const Text(
              "Upload Image",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: pickImage, // open gallery on tap
              child: Container(
                height: 160,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey),
                ),
                child: selectedImage != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(
                          selectedImage!,
                          fit: BoxFit.cover,
                        ),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.upload_outlined, size: 32, color: Colors.grey),
                          SizedBox(height: 8),
                          Text(
                            "Drag and Drop here",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "or",
                            style: TextStyle(color: Colors.grey),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "Upload photos of destination",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
              ),
            ),

SizedBox(height: MediaQuery.of(context).size.height * 0.2),

            // ---------------- Proceed Button ----------------
            CustomElevatedButton(
              width: double.infinity,
              backgroundColor: const Color(0xFF3D8DB5),
              onPressed: () {
                // TODO: Handle proceed action
              },
              child: const Text(
                "Proceed",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
