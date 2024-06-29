import 'dart:ffi';

import 'package:diet_recomm/models/meal_model.dart';
import 'package:flutter/material.dart';


class MealDetailsScreen extends StatelessWidget {
  const MealDetailsScreen({super.key, required this.meal});

  final HealthGoal  meal;

  @override
  Widget build(BuildContext context) {
   

    
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.name!),
      
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              meal.image!,
              height: 300,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              height: 14,
            ),
            Text(
              'Ingredients',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 14,
            ),
            for (final ingredients in meal.ingredients!)
              Text(ingredients,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface)),
            const SizedBox(
              height: 24,
            ),
            Text(
              'Steps',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 14,
            ),
            for (final step in meal.recipe!)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                child: Text(step,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface)),
              ),

             const Text('Nutritions',style: TextStyle(
                color: Colors.deepPurple,
                fontSize: 25,
                fontWeight: FontWeight.bold
             ),),

             Padding(
               padding: const EdgeInsets.all(8.0),
               child: Text('Calories : ${meal.nutritionalInformation!.calories}',style: const TextStyle(
                  fontSize: 17
               ),),
             ),
             Padding(
               padding: const EdgeInsets.all(8.0),
               child: Text('Fat : ${meal.nutritionalInformation!.fat}',style: const TextStyle(
                fontSize: 17,
               ),),
             ),
             Padding(
               padding: const EdgeInsets.all(8.0),
               child: Text('Protien : ${meal.nutritionalInformation!.protein}',style: const TextStyle(
                fontSize: 17
               ),),
             ),
          ],
        ),
      ),
    );
  }
}
