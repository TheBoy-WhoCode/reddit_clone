import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:reddit_clone/features/community/controller/community_controller.dart';

import '../../../core/common/loader.dart';

class CreateCommunityScreen extends StatefulHookConsumerWidget {
  const CreateCommunityScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CreateCommunityScreenState();
}

class _CreateCommunityScreenState extends ConsumerState<CreateCommunityScreen> {
  // late TextEditingController communityNameController;
  void createCommunity(TextEditingController communityNameController) {
    ref.read(communityControllerProvider.notifier).createCommunity(
          communityNameController.text.trim(),
          context,
        );
  }

  @override
  Widget build(BuildContext context) {
    final communityNameController = useTextEditingController();
    final isLoading = ref.watch(communityControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create a Community'),
      ),
      body: isLoading
          ? const Loader()
          : Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text("Community name"),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: communityNameController,
                    decoration: const InputDecoration(
                      hintText: "r/Community_name",
                      filled: true,
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(18),
                    ),
                    maxLength: 21,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () => createCommunity(communityNameController),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      "Create Community",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
