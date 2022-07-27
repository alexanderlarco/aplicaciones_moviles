import 'package:flutter/material.dart';
import 'sql_helper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        // Remove the debug banner
        debugShowCheckedModeBanner: false,
        title: 'Kindacode.com',
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
        home: const HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // All journals
  List<Map<String, dynamic>> _journals = [];

  bool _isLoading = true;
  // This function is used to fetch all data from the database
  void _refreshJournals() async {
    final data = await SQLHelper.getItems();
    setState(() {
      _journals = data;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshJournals(); // Loading the diary when the app starts
  }

  final TextEditingController _prendaController = TextEditingController();
  final TextEditingController _descripcionController = TextEditingController();
  final TextEditingController _codigoController = TextEditingController();
  final TextEditingController _clienteController = TextEditingController();
  final TextEditingController _fechaController = TextEditingController();

  // This function will be triggered when the floating button is pressed
  // It will also be triggered when you want to update an item
  void _showForm(int? id) async {
    if (id != null) {
      // id == null -> create new item
      // id != null -> update an existing item
      final existingJournal =
      _journals.firstWhere((element) => element['id'] == id);
      _prendaController.text = existingJournal['prenda'];
      _descripcionController.text = existingJournal['descripcion'];
      _codigoController.text = existingJournal['codigo'];
      _clienteController.text = existingJournal['cliente'];
      _fechaController.text = existingJournal['fecha'];
      
    }

    showModalBottomSheet(
        context: context,
        elevation: 5,
        isScrollControlled: true,
        builder: (_) {
          var edgeInsets2 = EdgeInsets.only(
                top: 15,
                left: 15,
                right: 15,
                // this will prevent the soft keyboard from covering the text fields
                bottom: MediaQuery.of(context).viewInsets.bottom + 120,
              );
          var edgeInsets = edgeInsets2;
          return Container(
              padding: edgeInsets,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextField(
                    controller: _prendaController,
                    decoration: const InputDecoration(hintText: 'Prenda'),
                  ),
                    const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _descripcionController,
                    decoration: const InputDecoration(hintText: 'Descripcion'),
                  ),
                    const SizedBox(
                    height: 20,
                  ),
                   TextField(
                    controller:_codigoController,
                    decoration: const InputDecoration(hintText: 'codigo'),
                   ),
                   const SizedBox(
                    height: 10,
                   ),

                   TextField(
                    controller:_clienteController,
                    decoration: const InputDecoration(hintText: 'cliente'),
                   ),
                  const SizedBox(
                    height: 10,
                   ),

                   TextField(
                    controller:_fechaController,
                    decoration: const InputDecoration(hintText: 'fecha'),
                   ),
                   const SizedBox(
                    height: 10,
                   ),

                  ElevatedButton(
                    onPressed: () async {
                      // Save new journal
                      if (id == null) {
                        await _addItem();
                      }

                      if (id != null) {
                        await _updateItem(id);
                      }

                      // Clear the text fields
                      _prendaController.text= '';
                      _descripcionController.text = '';
                      _codigoController.text = '';
                      _clienteController.text = '';
                      _fechaController.text = ' ';

                      // Close the bottom sheet
                      // ignore: use_build_context_synchronously
                      Navigator.of(context).pop();
                    },
                    child: Text(id == null ? 'Create New' : 'Update'),
                  )
                ],
              ),
            );
        });
  }

// Insert a new journal to the database
  Future<void> _addItem() async {
    await SQLHelper.createItem(
        _prendaController.text, 
        _descripcionController.text,
        _codigoController.text,
        _clienteController.text,
        _fechaController.text);

    _refreshJournals();
  }

  // Update an existing journal
  Future<void> _updateItem(int id) async {
    await SQLHelper.updateItem(
        id, 
       _prendaController.text,
       _descripcionController.text, 
       _codigoController.text,
       _clienteController.text,
       _fechaController.text);
    _refreshJournals();
  }

  // Delete an item
  void _deleteItem(int id) async {
    await SQLHelper.deleteItem(id);
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Successfully deleted a journal!'),
    ));
    _refreshJournals();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kindacode.com'),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _journals.length,
              itemBuilder: (context, index) => Card(
                color: Colors.orange[200],
                margin: const EdgeInsets.all(15),
                child: ListTile(
                    title: Text(_journals[index]['title']),
                    subtitle: Text(_journals[index]['descripcion']),
                
                    
                    trailing: SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () => _showForm(_journals[index]['id']),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () =>
                                _deleteItem(_journals[index]['id']),
                          ),
                        ],
                      ),
                    )),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _showForm(null),
      ),
    );
  }
}