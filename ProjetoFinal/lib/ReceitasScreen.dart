import 'package:flutter/material.dart';
import 'TheMealDBService.dart';

class ReceitasScreen extends StatefulWidget {
  @override
  _ReceitasScreenState createState() => _ReceitasScreenState();
}

class _ReceitasScreenState extends State<ReceitasScreen> {
  List<Map<String, dynamic>> _recipes = [];
  String _resultado = '';

  @override
  void initState() {
    super.initState();
    _loadRecipes();
  }

  void _loadRecipes() async {
    try {
      final recipes = await TheMealDBService().getAllRecipes();
      setState(() {
        _recipes = recipes;
        _resultado = recipes.isNotEmpty
            ? 'Receitas carregadas com sucesso!'
            : 'Nenhuma receita encontrada.';
      });
    } catch (e) {
      setState(() {
        _resultado = 'Erro ao carregar receitas: $e';
      });
    }
  }

  void _showRecipeDetails(String id) async {
    try {
      final details = await TheMealDBService().getRecipeDetails(id);
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(details['strMeal']),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.network(details['strMealThumb']),
              Text('Categoria: ${details['strCategory']}',
                  style: TextStyle(color: Colors.pink)),
              Text('Área: ${details['strArea']}',
                  style: TextStyle(color: Colors.pink)),
              SizedBox(height: 10),
              Text('Instruções:',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text(details['strInstructions']),
            ],
          ),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao carregar detalhes: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Receitas Disponíveis',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.pinkAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              _resultado,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.pink,
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: _recipes.isEmpty
                  ? Center(
                      child: Text(
                        'Nenhuma receita encontrada.',
                        style: TextStyle(color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      itemCount: _recipes.length,
                      itemBuilder: (context, index) {
                        final recipe = _recipes[index];
                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          elevation: 5,
                          child: ListTile(
                            contentPadding: EdgeInsets.all(10),
                            tileColor: Colors.pink.shade50,
                            title: Text(
                              recipe['strMeal'],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.pinkAccent,
                              ),
                            ),
                            leading: recipe['strMealThumb'] != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      recipe['strMealThumb'],
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : Icon(Icons.image, color: Colors.pinkAccent),
                            onTap: () => _showRecipeDetails(recipe['idMeal']),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
