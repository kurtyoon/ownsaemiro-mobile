import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ownsaemiro/app/config/color_system.dart';
import 'package:ownsaemiro/app/utility/log_util.dart';
import 'package:ownsaemiro/core/screen/base_screen.dart';
import 'package:ownsaemiro/presentation/view_model/event/review_list_view_model.dart';
import 'package:ownsaemiro/presentation/widget/appbar/default_back_appbar.dart';
import 'package:shimmer/shimmer.dart';

class ReviewListScreen extends BaseScreen<ReviewListViewModel> {
  const ReviewListScreen({super.key});

  @override
  PreferredSizeWidget buildAppBar(BuildContext context) {
    return const PreferredSize(
      preferredSize: Size.fromHeight(60),
      child: DefaultBackAppBar(title: "후기 전체보기"),
    );
  }

  @override
  Widget buildBody(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 24),
        Expanded(
          child: Obx(
            () {
              if (viewModel.isLoading || viewModel.reviews.isEmpty) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: 20,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                          bottom: 16, left: 16, right: 16),
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  CircleAvatar(
                                    radius: 18,
                                    backgroundColor: Colors.grey[300]!,
                                  ),
                                  const SizedBox(height: 8),
                                  Container(
                                    width: 40,
                                    height: 10,
                                    color: Colors.grey[300]!,
                                  ),
                                ],
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Center(
                                  child: Container(
                                    height: 10,
                                    color: Colors.grey[300]!,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }

              return ListView.builder(
                shrinkWrap: true,
                itemCount: viewModel.reviews.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                        const EdgeInsets.only(bottom: 16, left: 16, right: 16),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              CircleAvatar(
                                radius: 18,
                                backgroundImage: NetworkImage(
                                    viewModel.reviews[index].image),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                viewModel.reviews[index].name,
                                style: const TextStyle(fontSize: 10),
                              ),
                            ],
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Center(
                              child: Text(
                                viewModel.reviews[index].content,
                                style: const TextStyle(fontSize: 12),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
