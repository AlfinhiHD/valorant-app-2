import 'package:flutter/material.dart';

class AgentDetailPage extends StatefulWidget {
  final dynamic agent;

  AgentDetailPage({required this.agent});

  @override
  _AgentDetailPageState createState() => _AgentDetailPageState();
}

class _AgentDetailPageState extends State<AgentDetailPage> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    isFavorite = FavoriteAgents().isFavorite(widget.agent);
  }

  void toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });

    // Menambahkan atau menghapus agent dari daftar favorite
    if (isFavorite) {
      FavoriteAgents().addToFavorites(widget.agent);
    } else {
      FavoriteAgents().removeFromFavorites(widget.agent);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black, // Warna hitam
        title: Text(widget.agent['displayName'] ?? ''),
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : null,
            ),
            onPressed: toggleFavorite,
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 200,
              height: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(widget.agent['fullPortrait'] ?? ''),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.agent['displayName'] ?? '',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 15),
                  Container(
                    color: Colors.grey[900], // Background hitam
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Role',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          widget.agent['role'] != null
                              ? widget.agent['role']['displayName']
                              : 'Initiator',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Description',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          widget.agent['description'] ?? '',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Abilities',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    color: Colors.black, // Background hitam
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Abilities', // Tambahkan kata "Abilities"
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          widget.agent['abilities'] != null &&
                                              widget.agent['abilities'].length > 0
                                              ? widget.agent['abilities'][0]['displayIcon']
                                              : '',
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    widget.agent['abilities'] != null &&
                                        widget.agent['abilities'].length > 0
                                        ? widget.agent['abilities'][0]['displayName']
                                        : '',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                children: [
                                  Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          widget.agent['abilities'] != null &&
                                              widget.agent['abilities'].length > 1
                                              ? widget.agent['abilities'][1]['displayIcon']
                                              : '',
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    widget.agent['abilities'] != null &&
                                        widget.agent['abilities'].length > 1
                                        ? widget.agent['abilities'][1]['displayName']
                                        : '',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                children: [
                                  Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          widget.agent['abilities'] != null &&
                                              widget.agent['abilities'].length > 2
                                              ? widget.agent['abilities'][2]['displayIcon']
                                              : '',
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    widget.agent['abilities'] != null &&
                                        widget.agent['abilities'].length > 2
                                        ? widget.agent['abilities'][2]['displayName']
                                        : '',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FavoriteAgents {
  static final FavoriteAgents _instance = FavoriteAgents._internal();

  factory FavoriteAgents() {
    return _instance;
  }

  FavoriteAgents._internal();

  List<dynamic> favoriteAgents = [];

  void addToFavorites(dynamic agent) {
    favoriteAgents.add(agent);
  }

  void removeFromFavorites(dynamic agent) {
    favoriteAgents.remove(agent);
  }

  bool isFavorite(dynamic agent) {
    return favoriteAgents.contains(agent);
  }
}