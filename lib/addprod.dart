
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:litebite/app_theme.dart';

class Addprod extends StatefulWidget {
  const Addprod({super.key});

  @override
  State<Addprod> createState() => _AddprodState();
}

class _AddprodState extends State<Addprod> {
  final TextEditingController name = TextEditingController();
  final TextEditingController price = TextEditingController();
  final TextEditingController nameb = TextEditingController();
  final TextEditingController namec = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final ImagePicker picker = ImagePicker();

  File? selectedImage;

  List categ = [];

  String? selectedCategoryId;

  bool uploading = false;
  bool categoryLoading = false;

  @override
  void initState() {
    super.initState();
    getcateg();
  }

  // FETCH CATEGORIES FROM API

  Future<void> getcateg() async {
    setState(() {
      categoryLoading = true;
    });

    try {
      var res = await http.post(
        Uri.parse(
          'https://devtechnical.com/AllUser/categbite.php',
        ),
      );

      if (res.statusCode == 200) {
        var result = jsonDecode(res.body);

        if (!mounted) return;

        if (result is List) {
          setState(() {
            categ = result;
          });
        } else {
          showMessage("Invalid category response");
        }
      } else {
        showMessage("Failed to load categories");
      }
    } catch (e) {
      debugPrint("Category API Error: $e");

      if (mounted) {
        showMessage("Unable to load categories");
      }
    } finally {
      if (mounted) {
        setState(() {
          categoryLoading = false;
        });
      }
    }
  }

  // SELECT IMAGE FROM GALLERY

  Future<void> pickImage() async {
    try {
      final XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
        maxWidth: 1600,
      );

      if (image != null && mounted) {
        setState(() {
          selectedImage = File(image.path);
        });
      }
    } catch (e) {
      showMessage("Image selection failed");
    }
  }

  // CATEGORY DROPDOWN

  Widget categoryDropdown() {
    return DropdownButtonFormField<String>(
      value: selectedCategoryId,
      isExpanded: true,

      decoration: InputDecoration(
        labelText: "Select Category",
        labelStyle: const TextStyle(color: grey),

        prefixIcon: const Icon(
          Icons.category_outlined,
          color: orange,
        ),

        filled: true,
        fillColor: surface,

        contentPadding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 16,
        ),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: border),
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: border),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            color: orange,
            width: 1.5,
          ),
        ),
      ),

      hint: Text(
        categoryLoading
            ? "Loading categories..."
            : "Choose category",
        style: const TextStyle(
          color: grey,
          fontSize: 14,
        ),
      ),

      items: categ.map<DropdownMenuItem<String>>((item) {
        return DropdownMenuItem<String>(
          value: item['id'].toString(),
          child: Text(
            item['name'].toString(),
            style: const TextStyle(
              color: dark,
              fontSize: 14,
            ),
          ),
        );
      }).toList(),

      onChanged: categoryLoading
          ? null
          : (value) {
              setState(() {
                selectedCategoryId = value;
              });

              debugPrint("Category ID: $value");
            },

      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please select category";
        }
        return null;
      },
    );
  }

  // UPLOAD PRODUCT WITH IMAGE

  Future<void> addprod() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    if (selectedImage == null) {
      showMessage("Please select product image");
      return;
    }

    if (selectedCategoryId == null) {
      showMessage("Please select category");
      return;
    }

    setState(() {
      uploading = true;
    });

    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(
          'https://devtechnical.com/AllUser/addprodbite.php',
        ),
      );

      // TEXT FIELDS

      request.fields['name'] = name.text.trim();
      request.fields['price'] = price.text.trim();
      request.fields['nameb'] = nameb.text.trim();
      request.fields['namec'] = namec.text.trim();

      // SEND SELECTED CATEGORY ID

      request.fields['catid'] = selectedCategoryId!;

      debugPrint("Sending Category ID: $selectedCategoryId");

      // IMAGE FILE

      request.files.add(
        await http.MultipartFile.fromPath(
          'image',
          selectedImage!.path,
        ),
      );

      // SEND REQUEST

      var response = await request.send();

      var responseBody =
          await response.stream.bytesToString();

      debugPrint("API Response: $responseBody");

      var result = jsonDecode(responseBody);

      if (!mounted) return;

      if (response.statusCode == 200 &&
          result['Success'].toString() == 'true') {
        showMessage(
          result['message'] ?? 'Product added successfully',
        );

        // CLEAR FIELDS

        name.clear();
        price.clear();
        nameb.clear();
        namec.clear();

        setState(() {
          selectedImage = null;
          selectedCategoryId = null;
        });
      } else {
        showMessage(
          result['message'] ?? 'Product upload failed',
        );
      }
    } catch (e) {
      debugPrint("Upload Error: $e");

      if (mounted) {
        showMessage("Error uploading product: $e");
      }
    } finally {
      if (mounted) {
        setState(() {
          uploading = false;
        });
      }
    }
  }

  // SNACKBAR MESSAGE

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: dark,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // REUSABLE TEXT FIELD

  Widget buildField({
    required String label,
    required IconData icon,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,

      style: const TextStyle(
        color: dark,
        fontSize: 14,
      ),

      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: grey),

        prefixIcon: Icon(
          icon,
          color: orange,
          size: 21,
        ),

        filled: true,
        fillColor: surface,

        contentPadding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 16,
        ),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: border),
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: border),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            color: orange,
            width: 1.5,
          ),
        ),
      ),

      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return "Please enter $label";
        }

        if (label == "Price") {
          if (double.tryParse(value.trim()) == null ||
              double.parse(value.trim()) <= 0) {
            return "Enter a valid price";
          }
        }

        return null;
      },
    );
  }

  @override
  void dispose() {
    name.dispose();
    price.dispose();
    nameb.dispose();
    namec.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cream,

      appBar: AppBar(
        backgroundColor: cream,
        elevation: 0,

        iconTheme: const IconThemeData(color: dark),

        title: const Text(
          "Add Product",
          style: TextStyle(
            color: dark,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),

        child: Form(
          key: formKey,

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              // HEADER

              const Text(
                "Create New Product",
                style: TextStyle(
                  color: dark,
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 6),

              const Text(
                "Add your delicious food to the menu.",
                style: TextStyle(
                  color: grey,
                  fontSize: 13,
                ),
              ),

              const SizedBox(height: 22),

              // IMAGE PICKER

              GestureDetector(
                onTap: uploading ? null : pickImage,

                child: Container(
                  width: double.infinity,
                  height: 190,

                  decoration: BoxDecoration(
                    color: surface,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: selectedImage == null
                          ? border
                          : orange,
                      width: 1.5,
                    ),
                  ),

                  child: selectedImage != null
                      ? Stack(
                          children: [
                            ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(19),

                              child: Image.file(
                                selectedImage!,
                                width: double.infinity,
                                height: 190,
                                fit: BoxFit.cover,
                              ),
                            ),

                            Positioned(
                              right: 10,
                              top: 10,

                              child: Container(
                                padding: const EdgeInsets.all(8),

                                decoration: const BoxDecoration(
                                  color: orange,
                                  shape: BoxShape.circle,
                                ),

                                child: const Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                  size: 19,
                                ),
                              ),
                            ),
                          ],
                        )
                      : Column(
                          mainAxisAlignment:
                              MainAxisAlignment.center,

                          children: [
                            Container(
                              height: 65,
                              width: 65,

                              decoration: BoxDecoration(
                                color: orange.withOpacity(0.12),
                                shape: BoxShape.circle,
                              ),

                              child: const Icon(
                                Icons.add_a_photo_outlined,
                                color: orange,
                                size: 32,
                              ),
                            ),

                            const SizedBox(height: 12),

                            const Text(
                              "Upload Product Image",
                              style: TextStyle(
                                color: dark,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),

                            const SizedBox(height: 5),

                            const Text(
                              "Tap to select from gallery",
                              style: TextStyle(
                                color: grey,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                ),
              ),

              const SizedBox(height: 25),

              // PRODUCT INFORMATION

              const Text(
                "Product Information",
                style: TextStyle(
                  color: dark,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 15),

              // PRODUCT NAME

              buildField(
                label: "Name",
                icon: Icons.fastfood_outlined,
                controller: name,
              ),

              const SizedBox(height: 15),

              // PRICE

              buildField(
                label: "Price",
                icon: Icons.currency_exchange,
                controller: price,
                keyboardType:
                    const TextInputType.numberWithOptions(
                  decimal: true,
                ),
              ),

              const SizedBox(height: 15),

              // NAME B

              buildField(
                label: "Nameb",
                icon: Icons.description_outlined,
                controller: nameb,
              ),

              const SizedBox(height: 15),

              // NAME C

              buildField(
                label: "Namec",
                icon: Icons.description,
                controller: namec,
              ),

              const SizedBox(height: 15),

              // CATEGORY DROPDOWN

              categoryDropdown(),

              const SizedBox(height: 28),

              // ADD PRODUCT BUTTON

              SizedBox(
                width: double.infinity,
                height: 53,

                child: ElevatedButton(
                  onPressed: uploading ? null : addprod,

                  style: ElevatedButton.styleFrom(
                    backgroundColor: orange,
                    disabledBackgroundColor:
                        orange.withOpacity(0.6),
                    elevation: 0,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),

                  child: uploading
                      ? const SizedBox(
                          height: 23,
                          width: 23,

                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2.5,
                          ),
                        )
                      : const Row(
                          mainAxisAlignment:
                              MainAxisAlignment.center,

                          children: [
                            Icon(
                              Icons.add_circle_outline,
                              color: Colors.white,
                            ),

                            SizedBox(width: 9),

                            Text(
                              "Add Product",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
