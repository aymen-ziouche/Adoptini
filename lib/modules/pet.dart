class Pet {
  List<dynamic> favorites;
  final String petId;
  final String name;
  final String breed;
  final String age;
  final String gender;
  final String image;
  final String description;
  final String ownerId;
  final double latitude;
  final double longitude;

  Pet({
    required this.favorites,
    required this.petId,
    required this.name,
    required this.breed,
    required this.age,
    required this.gender,
    required this.image,
    required this.description,
    required this.ownerId,
    required this.latitude,
    required this.longitude,
  });
}