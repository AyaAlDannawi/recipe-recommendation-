import 'package:flutter/material.dart';

class RecommendationPage extends StatelessWidget {
  final List<String> userIngredients;

   RecommendationPage({Key? key, required this.userIngredients})
  : super(key: key);

  final List<Map<String, dynamic>> recipes = [
    {
      'name': 'Pasta with Tomato Sauce',
      'ingredients': ['pasta', 'tomato', 'garlic', 'olive oil'],
    },
    {
      'name': 'Omelette',
      'ingredients': ['eggs', 'milk', 'butter', 'salt'],
    },
    {
      'name': 'Chicken Salad',
      'ingredients': ['chicken', 'lettuce', 'tomato', 'cucumber'],
    },
    {
      'name': 'Garlic Bread',
      'ingredients': ['bread', 'garlic', 'butter'],
    },
  ];

  List<Map<String, dynamic>> getRecommendedRecipes() {
    List<Map<String, dynamic>> recommendations = [];

    for (var recipe in recipes) {
      List<String> recipeIngredients = recipe['ingredients'];
      List<String> missingIngredients = recipeIngredients
          .where((ingredient) => !userIngredients.contains(ingredient))
          .toList();

      if (missingIngredients.length < recipeIngredients.length) {
        recommendations.add({
          'name': recipe['name'],
          'missing': missingIngredients,
        });
      }
    }

    return recommendations;
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> recommendedRecipes = getRecommendedRecipes();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Recommendation Page'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
         
          children: [
            const Text(
              'Recommended Recipes:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: recommendedRecipes.length,
                itemBuilder: (context, index) {
                  final recipe = recommendedRecipes[index];
                  return Card(
                    child: ListTile(
                      title: Text(recipe['name']),
                      subtitle: Text(
                        recipe['missing'].isEmpty
                            ? 'You have all the ingredients!'
                            : 'Missing: ${recipe['missing'].join(', ')}',
                      ),
                    ),
                  );
                },
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Icon(Icons.navigate_before, size: 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
