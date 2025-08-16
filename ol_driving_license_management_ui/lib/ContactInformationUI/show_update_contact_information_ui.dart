import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ol_driving_license_management_providers/ContactInformationProviders/update_contact_information_provider.dart';
import 'package:ol_driving_license_management_providers/Settings/ensure_provider.dart';
import 'package:ol_driving_license_management_providers/ContactInformationProviders/find_contact_information_provider.dart';
import 'package:ol_driving_license_management_widgets/ContactInformationWidgets/show_update_contact_information.dart';

class ShowUpdateContactInformationUI extends StatelessWidget {
  const ShowUpdateContactInformationUI({super.key, required this.contactID});

  final int contactID;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PVFindContactInformation(),
      child: EnsureProvider(
        create: (_) => PVUpdateContactInformation(),
        child: _UIShowUpdateContactInformation(contactID: contactID),
      ),
    );
  }
}

class _UIShowUpdateContactInformation extends StatefulWidget {
  const _UIShowUpdateContactInformation({required this.contactID});

  final int contactID;

  @override
  State<_UIShowUpdateContactInformation> createState() =>
      _UIShowUpdateContactInformationState();
}

class _UIShowUpdateContactInformationState
    extends State<_UIShowUpdateContactInformation> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final pv = Provider.of<PVFindContactInformation>(context, listen: false);
      await pv.find(contactID: widget.contactID);

      if (pv.contactInformationDTO == null) return;

      context.read<PVUpdateContactInformation>().loadContactInformation(
        pv.contactInformationDTO!,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Updating Contact Information Screen")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          padding: const EdgeInsets.all(5),
          color: Colors.grey[100],
          child: Column(
            children: [
              Consumer<PVFindContactInformation>(
                builder: (context, value, child) {
                  if (value.contactInformationDTO == null) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  return WDShowUpdateContactInformation(
                    contactInformationDTO: value.contactInformationDTO,
                  );
                },
              ),
              const SizedBox(height: 5),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () async {
                    final messenger = ScaffoldMessenger.of(context);

                    final result =
                        await context.read<PVUpdateContactInformation>().save();

                    if (!mounted) return;

                    messenger.showSnackBar(
                      SnackBar(
                        content: Text(
                          result.success
                              ? "تم التحديث بنجاح"
                              : result.error ?? "فشل في التحديث",
                        ),
                        backgroundColor:
                            result.success ? Colors.green : Colors.red,
                        duration: const Duration(milliseconds: 1000),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text("Update"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
