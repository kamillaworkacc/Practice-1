class SpaceLocation {
  final String id;
  final String name;
  final String description;
  final double latitude;
  final double longitude;
  final String type;
  final String emoji;

  const SpaceLocation({
    required this.id,
    required this.name,
    required this.description,
    required this.latitude,
    required this.longitude,
    required this.type,
    required this.emoji,
  });

  static List<SpaceLocation> get famousLocations => [
    const SpaceLocation(
      id: '1',
      name: 'Kennedy Space Center 🚀',
      description: 'NASA\'s primary launch center for human spaceflight. Visit the iconic launch pads!',
      latitude: 28.5721,
      longitude: -80.6480,
      type: 'space_station',
      emoji: '🚀',
    ),
    const SpaceLocation(
      id: '2',
      name: 'Hayden Planetarium 🌌',
      description: 'World-famous planetarium in New York\'s American Museum of Natural History.',
      latitude: 40.7814,
      longitude: -73.9740,
      type: 'planetarium',
      emoji: '🌌',
    ),
    const SpaceLocation(
      id: '3',
      name: 'Griffith Observatory 🔭',
      description: 'Iconic observatory in Los Angeles with stunning views and telescopes.',
      latitude: 34.1184,
      longitude: -118.3004,
      type: 'observatory',
      emoji: '🔭',
    ),
    const SpaceLocation(
      id: '4',
      name: 'Cité de l\'Espace 🛰️',
      description: 'Space museum and planetarium in Toulouse, France.',
      latitude: 43.5870,
      longitude: 1.4932,
      type: 'planetarium',
      emoji: '🛰️',
    ),
    const SpaceLocation(
      id: '5',
      name: 'Baikonur Cosmodrome 🌍',
      description: 'World\'s first and largest operational space launch facility in Kazakhstan.',
      latitude: 45.9650,
      longitude: 63.3050,
      type: 'space_station',
      emoji: '🌍',
    ),
    const SpaceLocation(
      id: '6',
      name: 'Jodrell Bank Observatory 📡',
      description: 'Historic radio observatory in the UK, home to the Lovell Telescope.',
      latitude: 53.2367,
      longitude: -2.3061,
      type: 'observatory',
      emoji: '📡',
    ),
    const SpaceLocation(
      id: '7',
      name: 'Adler Planetarium ⭐',
      description: 'First planetarium built in the Western Hemisphere, located in Chicago.',
      latitude: 41.8662,
      longitude: -87.6071,
      type: 'planetarium',
      emoji: '⭐',
    ),
    const SpaceLocation(
      id: '8',
      name: 'Tokyo Skytree Planetarium 🌟',
      description: 'Modern planetarium in Tokyo with cutting-edge projection technology.',
      latitude: 35.7101,
      longitude: 139.8107,
      type: 'planetarium',
      emoji: '🌟',
    ),
    const SpaceLocation(
      id: '9',
      name: 'European Space Agency HQ 🛸',
      description: 'ESA headquarters in Paris, coordinating European space exploration.',
      latitude: 48.8494,
      longitude: 2.3537,
      type: 'space_station',
      emoji: '🛸',
    ),
    const SpaceLocation(
      id: '10',
      name: 'Arecibo Observatory 🪐',
      description: 'Historic radio telescope in Puerto Rico (before collapse, now memorial site).',
      latitude: 18.3450,
      longitude: -66.7528,
      type: 'observatory',
      emoji: '🪐',
    ),
  ];
}

