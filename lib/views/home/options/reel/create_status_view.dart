import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kongossa/controller/status_controller.dart';

class StatusCreationView extends GetView<StatusController> {
  const StatusCreationView({super.key});

  @override
  Widget build(BuildContext context) {
    // Assurer le nettoyage du formulaire si l'utilisateur quitte la page sans publier
    // ignore: deprecated_member_use
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildImageGrid(),
            const SizedBox(height: 20),
            OutlinedButton.icon(
              icon: const Icon(Icons.add_photo_alternate_outlined),
              label: const Text('Ajouter des images'),
              onPressed: controller.pickImages,
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 30),
            _buildVisibilitySelector(),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text('Créer un statut'),
      leading: IconButton(
        icon: const Icon(Icons.close),
        onPressed: () {
          // controller.clearCreationForm();
          Get.back();
        },
      ),
      actions: [
        // Le bouton "Publier" est réactif à l'état de chargement et à la sélection de fichiers
        Obx(() {
          final bool isLoading = controller.isCreating.value;
          final bool hasFiles = controller.filesToUpload.isNotEmpty;

          if (isLoading) {
            return const Padding(
              padding: EdgeInsets.only(right: 16.0),
              child: Center(
                  child: SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(color: Colors.white))),
            );
          }

          return TextButton(
            onPressed: hasFiles
                ? () =>
                    controller.createStatusWithFiles().then((_) => Get.back())
                : null,
            child: const Text('Publier',
                style: TextStyle(fontSize: 16, color: Colors.white)),
          );
        }),
      ],
    );
  }

  Widget _buildImageGrid() {
    return Obx(() {
      if (controller.filesToUpload.isEmpty) {
        return Container(
          height: 150,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[400]!),
          ),
          child: const Center(
            child: Text(
              'Vos images apparaîtront ici',
              style: TextStyle(color: Colors.grey),
            ),
          ),
        );
      }

      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: controller.filesToUpload.length,
        itemBuilder: (context, index) {
          final file = controller.filesToUpload[index];
          return Stack(
            fit: StackFit.expand,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.file(
                  File(file.path),
                  fit: BoxFit.cover,
                ),
              ),
              // Bouton de suppression
              Positioned(
                top: 4,
                right: 4,
                child: GestureDetector(
                  onTap: () => controller.removeImage(file),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      shape: BoxShape.circle,
                    ),
                    child:
                        const Icon(Icons.close, color: Colors.white, size: 18),
                  ),
                ),
              ),
            ],
          );
        },
      );
    });
  }

  Widget _buildVisibilitySelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Visibilité',
          style:
              Get.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Obx(() => Card(
              margin: EdgeInsets.zero,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: Colors.grey[300]!),
              ),
              child: Column(
                children: [
                  RadioListTile<String>(
                    title: const Text('Public'),
                    subtitle: const Text('Visible par tout le monde'),
                    value: 'public',
                    groupValue: controller.newStatusVisibility.value,
                    onChanged: (value) {
                      if (value != null)
                        controller.newStatusVisibility.value = value;
                    },
                  ),
                  Divider(
                      height: 1,
                      indent: 16,
                      endIndent: 16,
                      color: Colors.grey[200]),
                  RadioListTile<String>(
                    title: const Text('Privé'),
                    subtitle: const Text('Visible uniquement par vous'),
                    value: 'private',
                    groupValue: controller.newStatusVisibility.value,
                    onChanged: (value) {
                      if (value != null)
                        controller.newStatusVisibility.value = value;
                    },
                  ),
                ],
              ),
            )),
      ],
    );
  }
}
