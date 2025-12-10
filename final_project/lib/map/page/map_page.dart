import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../../shared/theme/app_theme.dart';
import '../data/space_location.dart';
import '../../shared/widgets/glitter_particles.dart';
import '../../shared/widgets/kawaii_planet.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final MapController _mapController = MapController();
  bool _showList = false;
  SpaceLocation? _selectedLocation;
  List<SpaceLocation> _locations = SpaceLocation.famousLocations;
  
  static const LatLng _defaultCenter = LatLng(28.5721, -80.6480);

  @override
  void initState() {
    super.initState();
  }

  void _navigateToLocation(SpaceLocation location) {
    setState(() {
      _showList = false;
      _selectedLocation = location;
    });
    
    _mapController.move(
      LatLng(location.latitude, location.longitude),
      14.0,
    );
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Showing ${location.name} on map! 🗺️✨'),
        backgroundColor: AppTheme.spacePink,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppTheme.spaceDark,
                  AppTheme.spacePurple.withOpacity(0.3),
                ],
              ),
            ),
          ),
          GlitterParticles(
            particleCount: 20,
            color: AppTheme.spacePink.withOpacity(0.5),
            speed: 0.6,
          ),
          SafeArea(
            child: Column(
              children: [
                Card(
                  margin: const EdgeInsets.all(16),
                  color: AppTheme.spaceDark.withOpacity(0.9),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: AppTheme.spacePink,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Space Stations & Planetariums 🌍✨🪐',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            _showList ? Icons.map : Icons.list,
                            color: AppTheme.spacePink,
                          ),
                          onPressed: () {
                            setState(() {
                              _showList = !_showList;
                            });
                          },
                          tooltip: _showList ? 'Show Map 🗺️' : 'Show List 📋',
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: _showList ? _buildListView() : _buildMapView(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMapView() {
    return Stack(
      children: [
        FlutterMap(
          mapController: _mapController,
          options: MapOptions(
            initialCenter: _selectedLocation != null
                ? LatLng(_selectedLocation!.latitude, _selectedLocation!.longitude)
                : _defaultCenter,
            initialZoom: _selectedLocation != null ? 14.0 : 2.0,
            minZoom: 1.0,
            maxZoom: 18.0,
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.example.final_project',
              maxZoom: 19,
            ),
            MarkerLayer(
              markers: _locations.map((location) {
                return Marker(
                  point: LatLng(location.latitude, location.longitude),
                  width: 50,
                  height: 50,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedLocation = location;
                      });
                      _mapController.move(
                        LatLng(location.latitude, location.longitude),
                        14.0,
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: _selectedLocation?.id == location.id
                            ? AppTheme.spacePink
                            : AppTheme.spacePurple,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 3,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: (_selectedLocation?.id == location.id
                                    ? AppTheme.spacePink
                                    : AppTheme.spacePurple)
                                .withOpacity(0.5),
                            blurRadius: 10,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          location.emoji,
                          style: const TextStyle(fontSize: 24),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
        Positioned(
          top: 80,
          right: 16,
          child: KawaiiPlanet(
            size: 50,
            planetColor: AppTheme.spacePink,
            emoji: '🪐',
            hasFace: true,
          ),
        ),
        if (_selectedLocation != null)
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Card(
              color: AppTheme.spaceDark.withOpacity(0.95),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          _selectedLocation!.emoji,
                          style: const TextStyle(fontSize: 24),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            _selectedLocation!.name,
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                  color: AppTheme.spacePink,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close),
                          color: AppTheme.spacePink,
                          onPressed: () {
                            setState(() {
                              _selectedLocation = null;
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _selectedLocation!.description,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 16,
                          color: AppTheme.spacePurple,
                        ),
                        Text(
                          '${_selectedLocation!.latitude.toStringAsFixed(4)}, ${_selectedLocation!.longitude.toStringAsFixed(4)}',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppTheme.spacePurple,
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildListView() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: _locations.length,
      itemBuilder: (context, index) {
        final location = _locations[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: InkWell(
            onTap: () => _navigateToLocation(location),
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          AppTheme.spacePurple,
                          AppTheme.spacePink,
                        ],
                      ),
                    ),
                    child: Center(
                      child: Text(
                        location.emoji,
                        style: const TextStyle(fontSize: 30),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          location.name,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppTheme.spacePink,
                              ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          location.description,
                          style: Theme.of(context).textTheme.bodySmall,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              size: 16,
                              color: AppTheme.spacePurple,
                            ),
                            Text(
                              '${location.type.replaceAll('_', ' ').toUpperCase()}',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: AppTheme.spacePurple,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: AppTheme.spacePink,
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }
}


