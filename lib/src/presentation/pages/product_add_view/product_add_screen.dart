import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/product_bloc/product_bloc.dart';

class ProductAddScreen extends StatefulWidget {
  const ProductAddScreen({super.key});

  @override
  State<ProductAddScreen> createState() => _ProductAddScreenState();
}

class _ProductAddScreenState extends State<ProductAddScreen> {

  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController measurementController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                cursorColor: Colors.grey[350],
                controller: nameController,
                decoration: const InputDecoration(
                  hintText: "Product Name",
                  hintStyle: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 12),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                cursorColor: Colors.grey[350],
                controller: measurementController,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                ],
                decoration: const InputDecoration(
                  hintText: "Measurement",
                  hintStyle: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 12),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                cursorColor: Colors.grey[350],
                controller: priceController,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                ],
                decoration: const InputDecoration(
                  hintText: "Price",
                  hintStyle: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 12),
                ),
              ),
              SizedBox(height: 30,),
              BlocConsumer<ProductBloc, ProductState>(
                listener: (context, state) {
                  if (state is ProductAddedSuccessfully) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Product added successfully!')),
                    );
                  } else if (state is ProductError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error: ${state.errorMessage}')),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is ProductLoading) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return InkWell(
                    onTap: () {
                      if (state is! ProductLoading) {
                        context.read<ProductBloc>().add(AddProductEvent(
                          productName: nameController.text,
                          measurement: measurementController.text,
                          price: double.parse(priceController.text),
                        ));
                      }
                    },
                    child: Material(
                      elevation: 1,
                      borderRadius: BorderRadius.circular(40),
                      color: Colors.black,
                      child: const Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 20),
                          child: Text(
                            "Add",
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
