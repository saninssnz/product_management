import 'package:flutter/material.dart';
import 'package:machine_test/src/presentation/pages/product_add_view/product_add_screen.dart';
import 'package:machine_test/src/presentation/pages/product_list_view/product_list_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                      const ProductAddScreen()));
                },
                child: Material(
                  elevation: 1,
                  borderRadius: BorderRadius.circular(40),
                  color: Colors.black,
                  child: const Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 50.0, vertical: 20),
                      child: Text(
                        "Add Product",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30,),
              InkWell(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                      const ProductListScreen()));
                },
                child: Material(
                  elevation: 1,
                  borderRadius: BorderRadius.circular(40),
                  color: Colors.black,
                  child: const Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 50.0, vertical: 20),
                      child: Text(
                        "List Product",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

      ),
    );
  }
}
