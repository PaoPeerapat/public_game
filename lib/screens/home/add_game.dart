import 'package:flutter/material.dart';
import '../../repositories/game_reposoty.dart';

class AddgamePage extends StatefulWidget {
  static const routeName = 'add_game';

  const AddgamePage({Key? key}) : super(key: key);

  @override
  State<AddgamePage> createState() => _AddgamePageState();
}

class _AddgamePageState extends State<AddgamePage> {
  var _isLoading = false;
  String? _errorMessage;

  final _gameNameController = TextEditingController();
  final _priceController = TextEditingController();

  validateForm() {
    return _gameNameController.text.isNotEmpty &&
        _priceController.text.isNotEmpty;
  }

  saveGame() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    await Future.delayed(Duration(seconds: 2));

    try {
      var gameName = _gameNameController.text;
      var price = double.parse(_priceController.text);

      await GameRepository().AddGame(
        name: gameName,
        price: price,
        rating: 0, // ส่งคะแนนเป็น 0 ไปเพราะต้องการให้มีค่า rating ตั้งต้น
      );

      if (mounted) Navigator.pop(context);
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ADD GAME'),
        backgroundColor: Colors.green,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 20),
                TextField(
                  controller: _gameNameController,
                  decoration: InputDecoration(
                    labelText: 'ชื่อเกม',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _priceController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    labelText: 'ราคา',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    if (validateForm()) {
                      saveGame();
                    }
                  },
                  child: Text('บันทึก'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (_isLoading)
            Container(
              color: Colors.black.withOpacity(0.2),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}
