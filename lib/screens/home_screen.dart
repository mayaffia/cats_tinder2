import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cat_provider.dart';
import '../widgets/cat_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<CatProvider>(context, listen: false).fetchNewCat();
  }

  @override
  Widget build(BuildContext context) {
    final catProvider = Provider.of<CatProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'kototinder',
          style: TextStyle(
            color: const Color.fromARGB(255, 223, 105, 144),
            fontSize: 26.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child:
            catProvider.currentCat == null
                ? CircularProgressIndicator()
                : CatCard(),
      ),
    );
  }
}
