import 'package:adoptini/modules/pet.dart';
import 'package:flutter/material.dart';

class DetailsPage extends StatefulWidget {
  final Pet pet;

  const DetailsPage({
    Key? key,
    required this.pet,
  }) : super(key: key);
  static String id = "DetailsPage";

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          foregroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              widget.pet.image.isNotEmpty
                  ? Image.network(
                      widget.pet.image,
                      fit: BoxFit.cover,
                    )
                  : Placeholder(
                      color: Colors.white,
                    ),
              const SizedBox(height: 10),
              Text(
                widget.pet.name,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  widget.pet.description,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
