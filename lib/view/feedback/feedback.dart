import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:leo_rigging_dashboard/utils/appcolors.dart';
import 'package:leo_rigging_dashboard/widget/header.dart';
import '../../core/LoginResponce/global_user.dart';
import 'controller/feedback_controller.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final FeedbackController controller = Get.put(FeedbackController());
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    controller.fetchAds();
  }

  String _getInitials(String email) {
    final name = email.split('@').first;
    return name.length > 1 ? name.substring(0, 2).toUpperCase() : name.toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GlobalUser().currentUser!.admin.roles.feedbackView != true
          ? const Center(child: Text("Permission Denied"))
          : Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Header(title: "Feedback"),
                  const SizedBox(height: 16),
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: controller.fetchAds,
                      child: Obx(() {
                        switch (controller.status.value) {
                          case Status.loading:
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          case Status.error:
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Error loading feedback",
                                    style: TextStyle(
                                      color: AppColors.cRed100,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    controller.errorMessage.value.isEmpty
                                        ? "Unknown error"
                                        : controller.errorMessage.value,
                                    style: const TextStyle(
                                      color: AppColors.cGrey,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  ElevatedButton(
                                    onPressed: () => controller.fetchAds(),
                                    child: const Text("Retry"),
                                  ),
                                ],
                              ),
                            );
                          case Status.empty:
                            return const Center(
                              child: Text(
                                "No feedback available",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: AppColors.cGrey,
                                ),
                              ),
                            );
                          case Status.success:
                            return Scrollbar(
                              controller: _scrollController,
                              thumbVisibility: true,
                              radius: const Radius.circular(8),
                              child: GridView.builder(
                                controller: _scrollController,
                                itemCount: controller.feedbacks.length,
                                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 300,
                                  crossAxisSpacing: 16,
                                  mainAxisSpacing: 16,
                                  childAspectRatio: 3 / 3.5,
                                ),
                                itemBuilder: (context, index) {
                                  final item = controller.feedbacks[index];
                                  return InkWell(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (_) => Dialog(
                                          backgroundColor: AppColors.cWhite,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          child: SizedBox(
                                            width: 400,
                                            height: 500,
                                            child: Padding(
                                              padding: const EdgeInsets.all(16.0),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    item.user.email,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleLarge!
                                                        .copyWith(color: AppColors.cBlack),
                                                  ),
                                                  const SizedBox(height: 16),
                                                  Expanded(
                                                    child: SingleChildScrollView(
                                                      child: Text(
                                                        item.message,
                                                        style: Theme.of(context).textTheme.bodyMedium,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 16),
                                                  Align(
                                                    alignment: Alignment.centerRight,
                                                    child: TextButton(
                                                      onPressed: () => Navigator.pop(context),
                                                      child: const Text("Close"),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    borderRadius: BorderRadius.circular(8),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: AppColors.cGrey100,
                                        borderRadius: BorderRadius.circular(8),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(0.05),
                                            blurRadius: 6,
                                            offset: const Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                      padding: const EdgeInsets.all(8),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          ListTile(
                                            leading: CircleAvatar(
                                              backgroundColor: AppColors.cRed100,
                                              child: Text(
                                                _getInitials(item.user.email),
                                                style: const TextStyle(color: AppColors.cPrimary),
                                              ),
                                            ),
                                            title: Text(
                                              item.user.email,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: AppColors.cGrey,
                                              ),
                                            ),
                                            subtitle: Text(
                                              DateFormat('MMM d, yyyy h:mm a').format(item.createdAt),
                                              style: const TextStyle(fontSize: 12),
                                            ),
                                          ),
                                          const Divider(),
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                              child: Text(
                                                item.message,
                                                maxLines: 20,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(fontSize: 14),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                        }
                      }),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}