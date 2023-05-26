import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:projectakhir_praktpm/Views/detail.dart';
import 'package:projectakhir_praktpm/Views/favorite.dart';
import 'package:projectakhir_praktpm/Views/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';


class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  List<dynamic> agents = [];
  List<dynamic> searchResults = [];
  bool isSearching = false;

  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    Initial();
    fetchAgents();
  }

  void Initial() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<void> fetchAgents() async {
    final response = await http.get(Uri.parse('https://valorant-api.com/v1/agents?isPlayableCharacter=true'));
    if (response.statusCode == 200) {
      setState(() {
        agents = json.decode(response.body)['data'];
      });
    } else {
      throw Exception('Failed to fetch agents');
    }
  }

  void searchAgents(String query) {
    setState(() {
      if (query.isNotEmpty) {
        isSearching = true;
        searchResults = agents.where((agent) {
          return agent['displayName'].toLowerCase().contains(query.toLowerCase()) ||
              agent['role']['displayName'].toLowerCase().contains(query.toLowerCase());
        }).toList();
      } else {
        isSearching = false;
        searchResults = [];
      }
    });
  }

  void navigateToDetailPage(dynamic agent) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AgentDetailPage(agent: agent),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF000000),
      appBar: AppBar(
        title: Text('Dashboard'),
        backgroundColor: Color(0xFF000000),
      ),
      body: agents.isEmpty
          ? Center(
        child: CircularProgressIndicator(),
      )
          : Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
            child: TextField(
              onChanged: searchAgents,
              decoration: InputDecoration(
                hintText: 'Search by Name or Role Name',
                labelText: 'Search Agent',
                hintStyle: TextStyle(color: Colors.grey),
                labelStyle: TextStyle(color: Colors.grey),
                prefixIcon: Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: Colors.black,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                ),
              ),
              style: TextStyle(color: Colors.white),
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                Image.asset(
                  'assets/valobackground.jpg',
                  fit: BoxFit.cover,
                  height: double.infinity,
                  width: double.infinity,
                ),
                isSearching
                    ? buildSearchResults()
                    : buildAgentGrid(),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Color(0xFF000000),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: Icon(Icons.favorite, color: Colors.white),
              onPressed: navigateToFavoriteAgentsPage,
            ),
            IconButton(
              icon: Icon(Icons.logout, color: Colors.white),
              onPressed: navigateToLogout,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSearchResults() {
    return searchResults.isEmpty
        ? Center(
      child: Text('Tidak ada hasil.'),
    )
        : GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.8,
      ),
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        final agent = searchResults[index];
        return GestureDetector(
          onTap: () => navigateToDetailPage(agent),
          child: Card(
            margin: EdgeInsets.all(8),
            color: Color(0xFF232323),
            child: Stack(
              children: [
                Image.network(
                  agent['displayIcon'],
                  fit: BoxFit.cover,
                  height: double.infinity,
                  width: double.infinity,
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.all(8),
                    color: Color(0xFF000000).withOpacity(0.8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          agent['displayName'],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          agent['role']['displayName'],
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildAgentGrid() {
    return agents.isEmpty
        ? Center(
      child: CircularProgressIndicator(),
    )
        : GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.8,
      ),
      itemCount: agents.length,
      itemBuilder: (context, index) {
        final agent = agents[index];
        return GestureDetector(
          onTap: () => navigateToDetailPage(agent),
          child: Card(
            margin: EdgeInsets.all(8),
            color: Color(0xFF232323),
            child: Stack(
              children: [
                Image.network(
                  agent['displayIcon'],
                  fit: BoxFit.cover,
                  height: double.infinity,
                  width: double.infinity,
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.all(8),
                    color: Color(0xFF000000).withOpacity(0.8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          agent['displayName'],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          agent['role']['displayName'],
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void navigateToFavoriteAgentsPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FavoriteAgentsPage(),
      ),
    );
  }


  void navigateToLogout() async {
    await prefs.remove("username");

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LoginScreen(),
      ),
    );
  }
}