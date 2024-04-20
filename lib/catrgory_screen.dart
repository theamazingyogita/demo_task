import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yogita_agarwal_task_impero_it/base_model.dart';
import 'package:yogita_agarwal_task_impero_it/bloc/base_bloc.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final baseBloc = context.read<BaseBloc>();
    return BlocConsumer<BaseBloc, BaseState>(
      buildWhen: (previous, current) =>
          previous.category != current.category ||
          previous.subCategories != current.subCategories,
      listenWhen: (previous, current) =>
          previous.category != current.category ||
          previous.subCategories != current.subCategories,
      listener: (context, state) {},
      builder: (context, state) {
        return NotificationListener(
          onNotification: (ScrollNotification scrollInfo) {
            if (scrollInfo is ScrollEndNotification) {
              if (scrollInfo.metrics.pixels ==
                  scrollInfo.metrics.maxScrollExtent) {
                baseBloc.add(LoadMoreDataEvent());
              }
            }
            return false;
          },
          child: ListView.separated(
            separatorBuilder: (context, index) {
              return const SizedBox(height: 0);
            },
            shrinkWrap: true,
            padding: const EdgeInsets.only(left: 20, top: 20),
            itemCount: state.subCategories.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              SubCategories subCategory = state.subCategories[index];
              return Flex(
                direction: Axis.vertical,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      '${subCategory.name}',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.zero,
                    margin: EdgeInsets.zero,
                    height: 220,
                    child: ListView.separated(
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 12),
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemCount: subCategory.product!.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        Product? product = subCategory.product?[index];
                        return Stack(
                          children: [
                            Flex(
                              direction: Axis.vertical,
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.network(
                                        product?.imageName.toString() ?? '',
                                        fit: BoxFit.cover,
                                        height: 180,
                                        width: 180,
                                      ),
                                    ),
                                    Positioned(
                                      top: 12,
                                      left: 12,
                                      child: Container(
                                        padding: const EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          color: const Color(0xff1dc7ea),
                                        ),
                                        child: Text(
                                          '${product?.priceCode.toString()}',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 4),
                                  child: Text(
                                    '${product?.name}',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
