import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../design/theme_colors.dart';
import 'home_view_model.dart';

class HomeView extends StatelessWidget {
  final HomeViewModel homeViewModel = HomeViewModel();

  HomeView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Remona'),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                gradient: LinearGradient(
                  colors: [
                    ThemeColors.greenPrimaryColor.withOpacity(0.3),
                    ThemeColors.whiteColor.withOpacity(0.8),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Obx(
                                () => Text(
                                  homeViewModel.homeModel.value.host['name'] ??
                                      '',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              Obx(
                                () => Text(
                                  homeViewModel.homeModel.value.host['url'] ??
                                      '',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Obx(
                            () => Row(
                              mainAxisAlignment:
                                  homeViewModel.homeModel.value.host['url'] ==
                                          ''
                                      ? MainAxisAlignment.center
                                      : MainAxisAlignment.end,
                              children: [
                                ElevatedButton(
                                  onPressed: () =>
                                      _showDialog(context: context),
                                  child: homeViewModel
                                              .homeModel.value.host['url'] ==
                                          ''
                                      ? const Text('Add host')
                                      : const Text('Configure'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async => {
          // await homeViewModel.fetchData(),
          // await homeViewModel.getGaleryContentPath(),
          await homeViewModel.uploadGalleryFiles(),
        },
        tooltip: 'Increment',
        child: const Icon(
          Icons.sync,
          color: ThemeColors.whiteColor,
        ),
      ),
    );
  }

  Future<void> _showDialog({required BuildContext context}) async {
    final TextEditingController nameController = TextEditingController(
        text: homeViewModel.homeModel.value.host['name'] ?? '');
    final TextEditingController urlController = TextEditingController(
        text: homeViewModel.homeModel.value.host['url'] ?? '');
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Configure'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: urlController,
                decoration: const InputDecoration(labelText: 'URL'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                await homeViewModel
                    .saveHost(nameController.text, urlController.text)
                    .then(
                      (value) => Navigator.of(context).pop(),
                    );
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
