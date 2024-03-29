import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../blocs/product_bloc/product_bloc.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    final productBloc = BlocProvider.of<ProductBloc>(context);

    productBloc.add(ProductFetchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if(state is ProductLoading){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          else if(state is ProductError){
            return const Center(child: Text("No data Found"));
          }
          else {
            return SafeArea(
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.sizeOf(context).width,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                        border: Border(
                            bottom: BorderSide(
                                color: Colors.grey
                            )
                        )
                    ),
                    child: Row(
                      children: [
                        const Padding(
                          padding:
                          EdgeInsets.symmetric(horizontal: 15.0),
                          child: Icon(Icons.search,size: 20,)
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 15.0),
                          child: Container(
                            height: 20,
                            color: Colors.grey.shade300,
                            width: 1,
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            controller: searchController,
                            style: const TextStyle(color: Colors.black),
                            onChanged: (text) {
                              context.read<ProductBloc>().add(ProductSearchEvent(query: text));
                            },
                            decoration: InputDecoration(
                                isDense: true,
                                border: InputBorder.none,
                                hintText: "Search",
                                hintStyle: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey.shade400)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Expanded(
                    child:  state.productList!.isNotEmpty?
                    ListView.builder(
                      physics: const ScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: state.productList?.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white
                            ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Text(state.productList![index].name,
                                    style: const TextStyle(
                                      color: Colors.black
                                    ),),
                                    const SizedBox(height: 5,),
                                    Text(state.productList![index].measurement,
                                      style: const TextStyle(
                                          color: Colors.black
                                      ),),
                                    const SizedBox(height: 5,),
                                    Text(state.productList![index].price.toString(),
                                      style: const TextStyle(
                                          color: Colors.black
                                      ),),
                                    const SizedBox(height: 5,),
                                    QrImageView(data: state.productList![index].name,
                                    size: 100,)
                                  ],
                                ),
                              )),
                        );
                      },
                    ):
                    const Center(child: Text("No data Found")),
                  )
                ],
              )
            );
          }
        },
      ),
    );
  }
}
