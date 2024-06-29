import 'dart:convert';

import 'package:diet_recomm/models/meal_model.dart';
import 'package:diet_recomm/widgets/meal_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    Future<Meals> getdata() async {
    final response = await rootBundle.loadString('assets/data.json');
    Map<String, dynamic> jsonMap = await json.decode(response);
    return Meals.fromJson(jsonMap);
  }
    return  Scaffold(
          body: FutureBuilder(
            future: getdata(),
            builder: (context,snapshot) {
              if(snapshot.hasData) {
                return ListView.builder(
                itemCount: snapshot.data!.Vegetarian!.weightLoss!.length ,
                itemBuilder: (context, index) {
                  return MealItem(meal: snapshot.data!.Vegetarian!.weightLoss![index],);
                
                
              },);
              }

              return const Center(child: CircularProgressIndicator(),);
            }
          ),
    );
  }
}