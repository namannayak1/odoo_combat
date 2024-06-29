


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class ProfilePersonScreen extends StatelessWidget {
  const ProfilePersonScreen({super.key});

  @override
  Widget build(BuildContext context) {

    Future<Map<String,dynamic>?>getdata() async
    {
            try
            {
                final data = await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get();
                
                if(data.exists)
                {
                     return data.data();
                }
            } on FirebaseException  catch (e)
            {
                    throw Error();
            }
            return null;
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
        actions: [
          IconButton(onPressed: () async {

             await  FirebaseAuth.instance.signOut();
          }, icon: const Icon(Icons.logout))
        ],
      ),

         //PROFILE PHOTUU AND USERNAME WAGERAH
          body: FutureBuilder(
            future: getdata(),
            builder: (context,snapshot) {

              if(snapshot.hasData) {
                return SingleChildScrollView(
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
                              const CircleAvatar(
                                radius: 70,
                                backgroundImage: AssetImage('assets/images/Naman_pic.jpg'),
                                backgroundColor: Colors.white,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                snapshot.data!['username'],
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
                            const SizedBox(height: 8),
                              // Text(
                              //   'namannayak2003@gmail.com',
                              //   style: TextStyle(
                              //     fontSize: 16,
                              //     color: Colors.white70,
                              //     shadows: [
                              //       Shadow(
                              //         offset: const Offset(0, 1),
                              //         blurRadius: 2,
                              //         color: Colors.black.withOpacity(0.3),
                              //       ),
                              //     ],
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ],
                    ),
              
                const  SizedBox(height: 16,),
              
              
              const  Text(
                  'Personal Details',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87),
                ),
                const SizedBox(height: 16),
                Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child:  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          leading: const Icon(Icons.cake_outlined, color: Colors.black),
                          title: const Text('Age', style: TextStyle(fontWeight: FontWeight.w600)),
                          subtitle: Text(snapshot.data!['age'], style: const TextStyle(fontSize: 18)),
                        ),
                        const Divider(),
                        ListTile(
                          leading: const Icon(Icons.male, color: Colors.black),
                          title: const Text('Gender', style: TextStyle(fontWeight: FontWeight.w600)),
                          subtitle: Text(snapshot.data!['gender'], style: const TextStyle(fontSize: 18)),
                        ),
                        const Divider(),
                        ListTile(
                          leading: const Icon(Icons.fitness_center, color: Colors.black),
                          title: const Text('Weight', style: TextStyle(fontWeight: FontWeight.w600)),
                          subtitle: Text('${snapshot.data!['weight']}kg', style: const TextStyle(fontSize: 18)),
                        ),
                        const Divider(),
                        ListTile(
                          leading: const Icon(Icons.height, color: Colors.black),
                          title: const Text('Height', style: TextStyle(fontWeight: FontWeight.w600)),
                          subtitle: Text('${snapshot.data!['height']}cm', style: const TextStyle(fontSize: 18)),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              
                // Dietary Preferences Section
              const   Text(
                  'Dietary Preferences',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87),
                ),
                const SizedBox(height: 16),
                Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child:  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          leading: const Icon(Icons.restaurant_menu, color: Colors.black),
                          title: const Text('Diet Type', style: TextStyle(fontWeight: FontWeight.w600)),
                          subtitle: Text(snapshot.data!['deitary_pref'], style: const TextStyle(fontSize: 18)),
                        ),
                        const Divider(),
                         ListTile(
                          leading: const Icon(Icons.warning, color: Colors.black),
                          title: const Text('Allergies', style: TextStyle(fontWeight: FontWeight.w600)),
                          subtitle: Text(snapshot.data!['allergies'], style: const TextStyle(fontSize: 18)),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              
                // Health Goals Section
                const Text(
                  'Health Goals',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87),
                ),
                const SizedBox(height: 16),
                Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child:   Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          leading: const Icon(Icons.flag, color: Colors.black),
                          title: const Text('Goals', style: TextStyle(fontWeight: FontWeight.w600)),
                          subtitle: Text(snapshot.data!['health_goals'], style: const TextStyle(fontSize: 18)),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
                      ),
                    );
              }
              else if(snapshot.connectionState == ConnectionState.waiting)
              {
                    return const Center(child: CircularProgressIndicator(),);
              }

              return Text(snapshot.error.toString());
            }
          ),
    );
  }
}