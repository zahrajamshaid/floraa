import 'package:flutter/material.dart';
class Plant {
  final String commonName;
  final String scientificName;
  final AssetImage assetImage;

  Plant({
    required this.commonName,
    required this.scientificName,
    required this.assetImage,
  });
}
List<Plant> plantList = [
   Plant(
    commonName: 'sunflower',
    scientificName: 'Helianthus annuus',
    assetImage: const AssetImage('lib/images/plants/sunflower.png'),
  ),
   Plant(
    commonName: 'rose',
    scientificName: 'Rosa',
    assetImage: const AssetImage('lib/images/plants/rose.png'),
  ),
 
 
  Plant(
    commonName: 'tulip',
    scientificName: 'Tulipa',
    assetImage: const AssetImage('lib/images/plants/tulip.png'),
  ),
  Plant(
    commonName: 'lily',
    scientificName: 'Lilium',
    assetImage: const AssetImage('lib/images/plants/lily.png'),
  ),
  Plant(
    commonName: 'daisy',
    scientificName: 'Bellis perennis',
    assetImage: const AssetImage('lib/images/plants/daisy.png'),
  ),
  Plant(
    commonName: 'orchid',
    scientificName: 'Orchidaceae',
    assetImage: const AssetImage('lib/images/plants/orchid.png'),
  ),
  Plant(
    commonName: 'lavender',
    scientificName: 'Lavandula',
    assetImage: const AssetImage('lib/images/plants/lavender.png'),
  ),
  // Add more unique plants here...
];


