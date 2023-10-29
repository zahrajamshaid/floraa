
class Plant {
  final int id;
  final String plantName;

  final double probability;
  final Map<String, dynamic>? plantDetails; // Use a Map for plant details

  Plant({
    required this.id,
    required this.plantName,
    required this.probability,
    this.plantDetails,
  });

  Plant.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        plantName = json['name'],
        probability = json['probability'],
        plantDetails = json['plant_details'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'plantName': plantName,
        'probability': probability,
        'plantDetails': plantDetails,
      };
}