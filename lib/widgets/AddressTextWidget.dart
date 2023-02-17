import 'package:adoptini/providers/ownerProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';




class AddressTextWidget extends StatelessWidget {
  const AddressTextWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ownerProvider = Provider.of<OwnerProvider>(context);
    final owner = ownerProvider.user;
    final city = owner?.city ?? "...";
    return Text(
      city,
      style: TextStyle(
        fontSize: 16.0,
        color: Theme.of(context).primaryColor,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}