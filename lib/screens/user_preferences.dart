

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diet_recomm/core/colors.dart';
import 'package:diet_recomm/screens/tabs.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserPreferences extends StatefulWidget {
  const UserPreferences({super.key});

  @override
  State<UserPreferences> createState() => _UserPreferencesState();
}

class _UserPreferencesState extends State<UserPreferences> {

    final _formkey = GlobalKey<FormState>();

    String ? username;
    String? gender;
    String? weight;
    String ? height;
    String ? dietrypreferences;
    String? healthgoal;
    String ? allergies;
    String ? age;
  File? pickedimage;
  @override
  Widget build(BuildContext context) {

    final List<String> dietPreferenceslist = [
    'Vegetarian',
    'Vegan',
    'Pescatarian',
    'Keto',
    'Paleo',
    'Omnivore',
    'Gluten-Free',
    'Lactose-Free'
  ];

  final List<String> allergieslist = [
    'Peanuts',
    'Tree Nuts',
    'Dairy',
    'Eggs',
    'Fish',
    'Shellfish',
    'Wheat',
    'Soy'
  ];

   final List<String> healthGoalslist = [
    'Weight Loss',
    'Muscle Gain',
    'Improve Stamina',
    'Increase Flexibility',
    'General Fitness',
    'Improve Mental Health',
    'Boost Immunity'
  ];
    void pickimage() async {
      final imagepicker =
          await ImagePicker().pickImage(source: ImageSource.camera);

      if (imagepicker != null) {
        setState(() {
          pickedimage = File(imagepicker.path);
        });
      }
    }


    void save() async
    {

          if(pickedimage==null)
          {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please provide your picture')));

                return;
          }
          final valid = _formkey.currentState!.validate();

          if(!valid)
          {
              return;
          }

           final storageref =   FirebaseStorage.instance
            .ref()
            .child('user_images')
            .child('${FirebaseAuth.instance.currentUser!.uid}.jpg');

        await storageref.putFile(pickedimage!);

        final imageurl = await storageref.getDownloadURL();
          await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).set({

                    'username': username,
                    'age' : age,
                    'gender': gender,
                    'weight' : weight,
                    'height' : height,
                    'deitary_pref': dietrypreferences,
                    'allergies': allergies,
                    'health_goals' : healthgoal,
                    'image': imageurl 
          });


    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'NutriFit',
          style: TextStyle(
              color: Color.fromARGB(255, 44, 76, 102),
              fontSize: 30,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic),
        ),
      ),

      //PROFILE PHOTUU AND USERNAME WAGERAH
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 300,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF3383CD), Color(0xFF11249F)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                ),
                Positioned(
                  top: 50,
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 70,
                        backgroundImage: pickedimage != null
                            ? FileImage(pickedimage!)
                            : null,
                        backgroundColor: Colors.black,
                        child: const Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        username!=null? username! :'Username',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              offset: const Offset(0, 2),
                              blurRadius: 4,
                              color: Colors.black.withOpacity(0.3),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 150,
                  right: 20,
                  child: FloatingActionButton(
                    onPressed: () {
                     pickimage();
                    },
                    mini: true,
                    backgroundColor: Colors.white,
                    child: const Icon(Icons.edit, color: Colors.blue),
                  ),
                ),
              ],
            ),

            const SizedBox(
              height: 16,
            ),

            // Personal Details Section
            SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                
                    const Text(
                      'Personal Details',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                
                    const SizedBox(height: 12),
                
                     TextFormField(
                      
                      onChanged: (value) {
                        setState(() {
                          
                        username = value;
                        });
                      },
                      validator: (value) {
                          if(value==null || value.length<4)
                          {
                              return 'Please enter valid username';
                          }

                          return null;
                      },
                      style: const TextStyle(fontSize: 18, color: Colors.black),
                      decoration: const InputDecoration(
                        labelText: 'Username',
                        labelStyle: TextStyle(color: Colors.blueGrey),
                        border: OutlineInputBorder(),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      
                      onChanged: (value) {
                        setState(() {
                          age  = value;
                        });
                      },
                      style: const TextStyle(fontSize: 18, color: Colors.black),
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        
                        labelText: 'Age',
                        labelStyle: TextStyle(color: Colors.blueGrey),
                        border: OutlineInputBorder(),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                      ),

                      validator: (value) {
                          if(value==null || value.length>3)
                          {
                              return 'Please enter valid Age';
                          }

                          return null;
                      },
                    ),
                    const SizedBox(height: 12),
                
                     TextFormField(
                      
                      onChanged: (value) {
                        setState(() {
                            gender = value;
                        });
                      },
                      style: const TextStyle(fontSize: 18, color: Colors.black),
                      decoration: const InputDecoration(
                        labelText: 'Gender',
                        labelStyle: TextStyle(color: Colors.blueGrey),
                        border: OutlineInputBorder(),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                      ),
                      validator: (value) {
                          if(value==null)
                          {
                              return 'Please enter valid Gender';
                          }

                          return null;
                      },
                    ),
                    const SizedBox(height: 12),
                
                    TextFormField(
                      
                      onChanged: (value) {
                        setState(() {
                          weight = value;
                        });
                      },
                      style: const TextStyle(fontSize: 18, color: Colors.black),
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Weight',
                        labelStyle: TextStyle(color: Colors.blueGrey),
                        border: OutlineInputBorder(),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                      ),
                      validator: (value) {
                          if(value==null || value.isEmpty)
                          {
                              return 'Please enter valid weight';
                          }

                          return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      
                      onChanged: (value) {
                        setState(() {
                          height = value;
                        });
                      },
                      style: const TextStyle(fontSize: 18, color: Colors.black),
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Height',
                        labelStyle: TextStyle(color: Colors.blueGrey),
                        border: OutlineInputBorder(),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                      ),
                      validator: (value) {
                          if(value==null || value.isEmpty)
                          {
                              return 'Please enter valid height';
                          }

                          return null;
                      },
                    ),
                    const SizedBox(height: 24),
                
                    // Dietary Preferences Section
                    const Text(
                      'Dietary Preferences',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    const SizedBox(height: 12),
                     DropdownButton<String>(
                hint: const Text('Choose your diet preference'),
                value: dietrypreferences,
                onChanged: (String? newValue) {
                  setState(() {
                    dietrypreferences = newValue;
                  });
                },
                items: dietPreferenceslist.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              
                    const SizedBox(height: 12),
                    DropdownButton<String>(
                hint: const Text('Choose your allergy'),
                value: allergies,
                onChanged: (String? newValue) {
                  setState(() {
                    allergies = newValue;
                  });
                },
                items: allergieslist.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
             
                    const SizedBox(height: 24),
                
                    // Health Goals Section
                    const Text(
                      'Health Goals',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    const SizedBox(height: 12),
                      DropdownButton<String>(
                hint: const Text('Choose your health goal'),
                value: healthgoal,
                onChanged: (String? newValue) {
                  setState(() {
                    healthgoal = newValue;
                  });
                },
                items: healthGoalslist.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              
                  ],
                ),
              ),
            ),

            // Save Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  save();

                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                        return const Tabs();
                  },));
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(buttoncolor),
                  padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  ),
                  shape: WidgetStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  elevation: WidgetStateProperty.all<double>(2),
                ),
                child: const Text(
                  'Save Changes',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
