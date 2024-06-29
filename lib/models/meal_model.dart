class Meals {
  Categories? Vegetarian;
    Categories? Vegan;
   Categories?  Pescatarian;
    Categories?Keto;
    Categories  ?Paleo;
    Categories?     Omnivore;
     Categories?   GlutenFree;
    Categories ?LactoseFree;
  
  Meals({this.Vegetarian ,this.GlutenFree,this.Keto,this.LactoseFree,this.Omnivore,this.Paleo,this.Pescatarian,this.Vegan});

  Meals.fromJson(Map<String, dynamic> json) {
    Vegetarian = json['Vegetarian'] != null
        ? Categories.fromJson(json['Vegetarian'])
        : null;

        Vegan = json['Vegan'] != null
        ? Categories.fromJson(json['Vegan'])
        : null;

        Pescatarian = json['Pescatarian'] != null
        ? Categories.fromJson(json['Pescatarian'])
        : null;

         Keto = json['Keto'] != null
        ? Categories.fromJson(json['Keto'])
        : null;

         Paleo = json['Paleo'] != null
        ? Categories.fromJson(json['Paleo'])
        : null;

         Omnivore = json['Omnivore'] != null
        ? Categories.fromJson(json['Omnivore'])
        : null;


        GlutenFree = json['GlutenFree'] != null
        ? Categories.fromJson(json['GlutenFree'])
        : null;


      LactoseFree = json['LactoseFree'] != null
        ? Categories.fromJson(json['LactoseFree'])
        : null;



  }

  
}

class Categories {
  List<HealthGoal>? weightLoss;
  List<HealthGoal>? muscleGain;
  List<HealthGoal>? improveStamina;
  List<HealthGoal>? improveFlexibility;
  List<HealthGoal>? generalFitness;
  List<HealthGoal>? improveMentalHealth;
  List<HealthGoal>? boostImmunity;

  Categories(
      {this.weightLoss,
      this.muscleGain,
      this.improveStamina,
      this.improveFlexibility,
      this.generalFitness,
      this.improveMentalHealth,
      this.boostImmunity});

  Categories.fromJson(Map<String, dynamic> json) {
    if (json['Weight Loss'] != null) {
      weightLoss = <HealthGoal>[];
      json['Weight Loss'].forEach((v) {
        weightLoss!.add(HealthGoal.fromJson(v));
      });
    }
    if (json['Muscle Gain'] != null) {
      muscleGain = <HealthGoal>[];
      json['Muscle Gain'].forEach((v) {
        muscleGain!.add(HealthGoal.fromJson(v));
      });
    }
    if (json['Improve Stamina'] != null) {
      improveStamina = <HealthGoal>[];
      json['Improve Stamina'].forEach((v) {
        improveStamina!.add(HealthGoal.fromJson(v));
      });
    }
    if (json['Improve Flexibility'] != null) {
      improveFlexibility = <HealthGoal>[];
      json['Improve Flexibility'].forEach((v) {
        improveFlexibility!.add(HealthGoal.fromJson(v));
      });
    }
    if (json['General Fitness'] != null) {
      generalFitness = <HealthGoal>[];
      json['General Fitness'].forEach((v) {
        generalFitness!.add(HealthGoal.fromJson(v));
      });
    }
    if (json['Improve Mental Health'] != null) {
      improveMentalHealth = <HealthGoal>[];
      json['Improve Mental Health'].forEach((v) {
        improveMentalHealth!.add(HealthGoal.fromJson(v));
      });
    }
    if (json['Boost Immunity'] != null) {
      boostImmunity = <HealthGoal>[];
      json['Boost Immunity'].forEach((v) {
        boostImmunity!.add(HealthGoal.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (weightLoss != null) {
      data['Weight Loss'] = weightLoss!.map((v) => v.toJson()).toList();
    }
    if (muscleGain != null) {
      data['Muscle Gain'] = muscleGain!.map((v) => v.toJson()).toList();
    }
    if (improveStamina != null) {
      data['Improve Stamina'] =
          improveStamina!.map((v) => v.toJson()).toList();
    }
    if (improveFlexibility != null) {
      data['Improve Flexibility'] =
          improveFlexibility!.map((v) => v.toJson()).toList();
    }
    if (generalFitness != null) {
      data['General Fitness'] =
          generalFitness!.map((v) => v.toJson()).toList();
    }
    if (improveMentalHealth != null) {
      data['Improve Mental Health'] =
          improveMentalHealth!.map((v) => v.toJson()).toList();
    }
    if (boostImmunity != null) {
      data['Boost Immunity'] =
          boostImmunity!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HealthGoal {
  String? name;
  String? image;
  List<String>? ingredients;
  List<String>? recipe;
  NutritionalInformation? nutritionalInformation;

  HealthGoal(
      {this.name,
      this.image,
      this.ingredients,
      this.recipe,
      this.nutritionalInformation});

  HealthGoal.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
    ingredients = json['ingredients'].cast<String>();
    recipe = json['recipe'].cast<String>();
    nutritionalInformation = json['nutritional_information'] != null
        ? NutritionalInformation.fromJson(json['nutritional_information'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['image'] = image;
    data['ingredients'] = ingredients;
    data['recipe'] = recipe;
    if (nutritionalInformation != null) {
      data['nutritional_information'] = nutritionalInformation!.toJson();
    }
    return data;
  }
}

class NutritionalInformation {
  int? calories;
  int? fat;
  int? protein;

  NutritionalInformation({this.calories, this.fat, this.protein});

  NutritionalInformation.fromJson(Map<String, dynamic> json) {
    calories = json['calories'];
    fat = json['fat'];
    protein = json['protein'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['calories'] = calories;
    data['fat'] = fat;
    data['protein'] = protein;
    return data;
  }
}
