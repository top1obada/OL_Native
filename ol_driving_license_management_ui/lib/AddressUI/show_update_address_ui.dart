import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ol_driving_license_management_providers/AddressProviders/find_address_provider.dart';
import 'package:ol_driving_license_management_providers/AddressProviders/update_address_provider.dart';
import 'package:ol_driving_license_management_providers/Settings/ensure_provider.dart';
import 'package:ol_driving_license_management_widgets/AddressWidgets/show_update_address.dart';

class ShowUpdateAddressUI extends StatelessWidget {
  const ShowUpdateAddressUI({super.key, required this.addressID});

  final int addressID;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PVFindAddress(),
      child: EnsureProvider(
        create: (_) => PVUpdateAddress(),
        child: _UIShowUpdateAddress(addressID: addressID),
      ),
    );
  }
}

class _UIShowUpdateAddress extends StatefulWidget {
  const _UIShowUpdateAddress({required this.addressID});

  final int addressID;

  @override
  State<_UIShowUpdateAddress> createState() => _UIShowUpdateAddressState();
}

class _UIShowUpdateAddressState extends State<_UIShowUpdateAddress> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final pv = Provider.of<PVFindAddress>(context, listen: false);
      await pv.find(addressID: widget.addressID);

      if (pv.addressDTO == null) return;

      context.read<PVUpdateAddress>().loadAddress(pv.addressDTO!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Updating Address Information")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          padding: const EdgeInsets.all(5),
          color: Colors.grey[100],
          child: Column(
            children: [
              Consumer<PVFindAddress>(
                builder: (context, value, child) {
                  if (value.addressDTO == null) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  return WDShowUpdateAddress(addressDTO: value.addressDTO);
                },
              ),
              const SizedBox(height: 5),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () async {
                    final messenger = ScaffoldMessenger.of(context);
                    final result = await context.read<PVUpdateAddress>().save();

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
