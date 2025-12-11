import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:newprojectfirebase/features/widgets/custom_elevated_button.dart';
import 'package:newprojectfirebase/selfie_verifying.dart';

class VerifyIdentityScreen extends StatefulWidget {
  const VerifyIdentityScreen({super.key});

  @override
  State<VerifyIdentityScreen> createState() => _VerifyIdentityScreenState();
}

class _VerifyIdentityScreenState extends State<VerifyIdentityScreen> {
  String selectedId = "";
  final ImagePicker picker = ImagePicker();
  XFile? selectedImage;

  // Pick from camera or gallery
  Future<void> pickImage(ImageSource source) async {
    final XFile? image = await picker.pickImage(source: source);

    if (image != null) {
      setState(() {
        selectedImage = image;
      });
    }

    Navigator.pop(context); 
    Navigator.pop(context); // close upload sheet
    openUploadBottomSheet(); // reopen to show "File Selected"
  }

  // Upload popup
  void openUploadBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets.add(const EdgeInsets.all(20)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Upload ID",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              InkWell(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    builder: (_) {
                      return Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              leading: const Icon(Icons.camera_alt_outlined),
                              title: const Text("Take Photo"),
                              onTap: () => pickImage(ImageSource.camera),
                            ),
                            ListTile(
                              leading: const Icon(Icons.photo_library_outlined),
                              title: const Text("Choose from Gallery"),
                              onTap: () => pickImage(ImageSource.gallery),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: Container(
                  height: 180,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: selectedImage == null
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.upload_outlined, size: 40, color: Colors.grey),
                              SizedBox(height: 10),
                              Text("Drag and Drop here", style: TextStyle(color: Colors.grey)),
                              SizedBox(height: 6),
                              Text("or", style: TextStyle(color: Colors.grey)),
                              SizedBox(height: 6),
                              Text(
                                "Upload photos",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.check_circle, color: Colors.green, size: 40),
                              const SizedBox(height: 10),
                              Text(
                                "File Selected",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.green.shade700,
                                ),
                              )
                            ],
                          ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              CustomElevatedButton(
                width: double.infinity,
                height: 50,
                backgroundColor: const Color(0xFF4E86A0),
                borderRadius: 10,
                onPressed: selectedImage == null
                    ? null
                    : () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const SelfieVerificationScreen(),
                          ),
                        );
                      },
                child: const Text(
                  "Continue",
                  style: TextStyle(color: Colors.white, fontSize: 17),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  // ID type button using CustomElevatedButton
  Widget idButton(String label, IconData icon) {
    bool active = selectedId == label;

    return CustomElevatedButton(
      width: double.infinity,
      height: 50,
      borderRadius: 12,
      backgroundColor: active ? Colors.blue.shade200 : Colors.grey.shade200,
      foregroundColor: Colors.black87,
      onPressed: () {
        setState(() {
          selectedId = label;
          selectedImage = null; // RESET
        });
        openUploadBottomSheet();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(icon, size: 22, color: Colors.black87),
          const SizedBox(width: 10),
          Text(label, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // iOS-style back arrow + title
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios, size: 24),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(width: 8),
                const Text(
                  "Verify Your Identity",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),

            const SizedBox(height: 8),
            const Text(
              "Upload your valid ID to continue your journey",
              style: TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 30),

            const Text(
              "Select ID type",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            idButton("Passport", Icons.badge_outlined),
            const SizedBox(height: 10),
            idButton("Citizenship ID", Icons.person_outline),
            const SizedBox(height: 10),
            idButton("School ID", Icons.school_outlined),
          ],
        ),
      ),
    );
  }
}
