import 'package:diet_recomm/models/meal_model.dart';
import 'package:diet_recomm/screens/meal_details.dart';
import 'package:diet_recomm/widgets/meal_item_trait.dart';
import 'package:flutter/material.dart';




class MealItem extends StatelessWidget {
  const MealItem({super.key,required this.meal});

  final HealthGoal meal;

  

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      clipBehavior: Clip.hardEdge,
      elevation: 2,
      child: InkWell(
        onTap: () {
       Navigator.push(context, MaterialPageRoute(builder: (context) {
            return MealDetailsScreen(meal: meal);
       },));
        },
        child: Stack(
          children: [
             FadeInImage(
              placeholder: const AssetImage('assets/images/diet_bg.jpg'),
              image:NetworkImage(meal.image!),
              fit: BoxFit.cover,
              height: 200,
              width: double.infinity,
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.black54,
                padding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 44),
                child:  Column(
                  children: [
                    Text(
                      meal.name!,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MealItemTrait(
                            icon: Icons.schedule,
                            label: '${10} min'),
                        SizedBox(
                          width: 12,
                        ),
                       
                        
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
