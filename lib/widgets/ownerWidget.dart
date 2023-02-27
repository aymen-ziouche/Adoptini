import 'package:adoptini/providers/ownerProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OwnerWidget extends StatelessWidget {
  
  const OwnerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ownerProvider = Provider.of<OwnerProvider>(context);
    final owner = ownerProvider.user;
    return owner != null
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  CircleAvatar(
                    radius: 22.0,
                    backgroundImage: NetworkImage(owner.profilePicture),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              owner.name,
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        const Text(
                          'Owner',
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          )
        : const Text('Loading owner...');
  }
}
