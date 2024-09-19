import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/models/shop_app/favorites_model.dart';
import 'package:salla/modules/shop_app/search/cubit/search_cubit.dart';
import 'package:salla/modules/shop_app/search/cubit/search_state.dart';
import 'package:salla/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var searchController = TextEditingController();

    return BlocProvider(
      create: (BuildContext context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchState>(
        listener: (context, state) {},
        builder: (context, state) {
          var searchCubit = SearchCubit.get(context);
          var searchModel = searchCubit.model;

          return Scaffold(
            appBar: AppBar(
              title: const Text('Search'),
            ),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    defaultFormField(
                      controller: searchController,
                      type: TextInputType.text,
                      validate: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter text to search';
                        }
                        return null;
                      },
                      onSubmit: (String text) {
                        searchCubit.search(text);
                      },
                      label: 'Search',
                      prefix: Icons.search,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    if (state is SearchLoadingState)
                      const LinearProgressIndicator(),
                    const SizedBox(
                      height: 10.0,
                    ),
                    if (state is SearchSuccessState && searchModel != null)
                      Expanded(
                        child: ListView.separated(
                          itemBuilder: (context, index) {
                            var product = searchModel.data?.data?[index];
                            if (product != null) {
                              return buildListProduct(
                                product,
                                context,
                                isOldPrice: false,
                              );
                            } else {
                              return const SizedBox.shrink();
                            }
                          },
                          separatorBuilder: (context, index) => myDivider(),
                          itemCount: searchModel.data?.data?.length ?? 0,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
