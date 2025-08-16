import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EnsureProvider<T extends ChangeNotifier> extends StatelessWidget {
  final Widget child;
  final T Function(BuildContext context) create;

  const EnsureProvider({super.key, required this.child, required this.create});

  @override
  Widget build(BuildContext context) {
    return _isProviderFound(context)
        ? child
        : ChangeNotifierProvider<T>(create: create, child: child);
  }

  bool _isProviderFound(BuildContext context) {
    try {
      var result = Provider.of<T?>(context, listen: false);

      return result != null;
    } catch (_) {
      return false;
    }
  }
}
