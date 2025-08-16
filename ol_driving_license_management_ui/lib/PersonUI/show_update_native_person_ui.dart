import 'package:flutter/material.dart';
import 'package:ol_driving_license_management_providers/PersonProviders/find_person_provider.dart';
import 'package:ol_driving_license_management_providers/PersonProviders/update_person_provider.dart';
import 'package:ol_driving_license_management_widgets/PersonsWidgets/show_update_native_person.dart';
import 'package:provider/provider.dart';

import 'package:ol_driving_license_management_providers/Settings/ensure_provider.dart';

class ShowUpdateNativePersonUI extends StatelessWidget {
  const ShowUpdateNativePersonUI({super.key, required this.personID});

  final int personID;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PVFindNativePerson(),
      child: EnsureProvider(
        create: (_) => PVUpdateNativePerson(),
        child: _UIShowUpdateNativePerson(personID: personID),
      ),
    );
  }
}

class _UIShowUpdateNativePerson extends StatefulWidget {
  const _UIShowUpdateNativePerson({required this.personID});

  final int personID;

  @override
  State<_UIShowUpdateNativePerson> createState() =>
      _UIShowUpdateNativePersonState();
}

class _UIShowUpdateNativePersonState extends State<_UIShowUpdateNativePerson> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final pv = Provider.of<PVFindNativePerson>(context, listen: false);
      await pv.find(personID: widget.personID);

      if (pv.nativePersonDTO == null) return;

      context.read<PVUpdateNativePerson>().loadNativePerson(
        pv.nativePersonDTO!,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Updating Native Person")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          padding: const EdgeInsets.all(5),
          color: Colors.grey[100],
          child: ListView(
            children: [
              Consumer<PVFindNativePerson>(
                builder: (context, value, child) {
                  if (value.nativePersonDTO == null) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  return WDShowUpdateNativePerson(
                    nativePersonDTO: value.nativePersonDTO,
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
                        await context.read<PVUpdateNativePerson>().save();

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
