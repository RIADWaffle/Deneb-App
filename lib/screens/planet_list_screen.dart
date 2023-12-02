// ignore_for_file: prefer_const_constructors

import 'package:deneb/utils/button.dart';
import 'package:deneb/utils/planet_card.dart';
import 'package:flutter/material.dart';
import '../class/planetary_system.dart';
import '../class/celestial_body.dart';
import '../screens/celestial_body_detail_screen.dart';
import '../screens/add_celestial_body_screen.dart';
import '../class/database_helper.dart';

class PlanetListScreen extends StatefulWidget {
  final PlanetarySystem system;

  PlanetListScreen({super.key, required this.system});

  @override
  _PlanetListScreenState createState() => _PlanetListScreenState();
}

class _PlanetListScreenState extends State<PlanetListScreen> {
  final DatabaseHelper databaseHelper = DatabaseHelper();
  List<CelestialBody> _celestialBodies = [];
  List<CelestialBody> _filteredCelestialBodies = [];

  @override
  void initState() {
    super.initState();
    _loadCelestialBodies();
  }

  Future<void> _loadCelestialBodies() async {
    final celestialBodies =
        await databaseHelper.getCelestialBodiesBySystemId(widget.system.id!);
    setState(() {
      _celestialBodies = celestialBodies;
      _filteredCelestialBodies = celestialBodies;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 245, 230, 187),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 245, 230, 187),
        title: Text(
          '${widget.system.name} - Celestial Bodies',
          style: TextStyle(
              fontSize: 18), // Puedes ajustar el tamaño según tus preferencias
        ),
        actions: [
          IconButton(
            onPressed: () {
              _handleSearch(context);
            },
            icon: Icon(
              Icons.search_rounded,
              size: 32,
            ),
          ),
        ],
      ),
      body: _buildCelestialBodyList(context),
    );
  }

  Widget _buildCelestialBodyList(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * .65,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _celestialBodies.length,
            itemBuilder: (context, index) {
              return PlanetCard(
                title: _celestialBodies[index].name,
                image: _celestialBodies[index].imagePath,
                onPressed: () async {
                  final deletedCelestialBody = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CelestialBodyDetailScreen(
                        celestialBody: _celestialBodies[index],
                      ),
                    ),
                  );

                  // Si se eliminó un cuerpo celeste, actualizamos el estado
                  if (deletedCelestialBody != null) {
                    setState(() {
                      _celestialBodies.remove(deletedCelestialBody);
                      _filteredCelestialBodies.remove(deletedCelestialBody);
                    });
                  }
                },
              );
            },
          ),
        ),
        SizedBox(
          height: 30,
        ),
        ButtonR(
            title: "Add a celestial body",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      AddCelestialBodyScreen(system: widget.system),
                ),
              ).then((value) {
                // Refresh the list after adding a system
                setState(() {});
              });
            }),
      ],
    );
  }

  void _handleSearch(BuildContext context) {
    showSearch(
      context: context,
      delegate: CelestialBodySearchDelegate(_celestialBodies),
    );
  }
}

class CelestialBodySearchDelegate extends SearchDelegate<CelestialBody?> {
  final List<CelestialBody> celestialBodies;

  CelestialBodySearchDelegate(this.celestialBodies) : super();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildSearchResults(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildSearchResults(context);
  }

  Widget _buildSearchResults(BuildContext context) {
    final filteredCelestialBodies = celestialBodies
        .where((celestialBody) => celestialBody.majorityNature
            .toLowerCase()
            .contains(query.toLowerCase()))
        .toList();

    return _buildCelestialBodyList(context, filteredCelestialBodies);
  }

  Widget _buildCelestialBodyList(
    BuildContext context,
    List<CelestialBody> celestialBodies,
  ) {
    return ListView.builder(
      itemCount: celestialBodies.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(celestialBodies[index].name),
          onTap: () {
            close(context, celestialBodies[index]);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CelestialBodyDetailScreen(
                  celestialBody: celestialBodies[index],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
