import 'package:flutter/material.dart';
import 'recommendation.dart';

class IngredientsPage extends StatefulWidget {
  const IngredientsPage({Key? key}) : super(key: key);

  @override
  State<IngredientsPage> createState() => _IngredientsPageState();
}

class _IngredientsPageState extends State<IngredientsPage> {
  final TextEditingController _ingredientController = TextEditingController();
  List<String> userIngredients = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ingredients Page'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          
          children: [
            const Text(
              'Enter Ingredients:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _ingredientController,
                    decoration: const InputDecoration(
                      hintText: 'Enter an ingredient',
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    if (_ingredientController.text.isNotEmpty) {
                      setState(() {
                        userIngredients.add(_ingredientController.text.trim());
                        _ingredientController.clear();
                      });
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Text(
              'Your Ingredients:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            Wrap(
              spacing: 8,
              children: userIngredients
                  .map((ingredient) => Chip(
                        label: Text(ingredient),
                        deleteIcon: const Icon(Icons.close),
                        onDeleted: () {
                          setState(() {
                            userIngredients.remove(ingredient);
                          });
                        },
                      ))
                  .toList(),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => RecommendationPage(
                        userIngredients: userIngredients,
                      ),
                    ),
                  );
                },
                child: const Icon(Icons.navigate_next, size: 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
