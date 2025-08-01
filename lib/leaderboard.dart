import 'package:flutter/material.dart';
import 'dart:async';
import 'components/navBar.dart';

class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({super.key});

  @override
  State<LeaderboardPage> createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {
  final TextEditingController _searchController = TextEditingController();
  String searchQuery = '';

  final List<Map<String, dynamic>> topTeams = [
    {'position': 1, 'team': 'Code Crusaders', 'college': 'MIT Manipal', 'points': 2850},
    {'position': 2, 'team': 'Byte Benders', 'college': 'IIT Delhi', 'points': 2700},
    {'position': 3, 'team': 'Bug Smashers', 'college': 'NIT Trichy', 'points': 2600},
    {'position': 4, 'team': 'Debug Ninjas', 'college': 'IIIT Hyderabad', 'points': 2550},
    {'position': 5, 'team': 'Tech Titans', 'college': 'VIT Vellore', 'points': 2450},
    {'position': 6, 'team': 'Algo Warriors', 'college': 'BITS Pilani', 'points': 2400},
  ];

  List<Map<String, dynamic>> get filteredTeams {
    if (searchQuery.isEmpty) return topTeams;
    return topTeams
        .where((team) =>
    team['team'].toLowerCase().contains(searchQuery.toLowerCase()) ||
        team['college'].toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();
  }

  Widget _infoCard(String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12.0),
        margin: const EdgeInsets.symmetric(horizontal: 6.0),
        decoration: BoxDecoration(
          color: Colors.grey.shade900.withOpacity(0.4),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: Colors.grey.shade700.withOpacity(0.5)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 30.0),
            const SizedBox(height: 8.0),
            Text(value, style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600, color: Colors.white)),
            const SizedBox(height: 4.0),
            Text(title, style: TextStyle(fontSize: 14.0, color: Colors.grey.shade400)),
          ],
        ),
      ),
    );
  }

  Widget _teamCard(Map<String, dynamic> team) {
    final int position = team['position'] as int;
    final bool isTopThree = position <= 3;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade900.withOpacity(0.4),
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: Colors.grey.shade700.withOpacity(0.5)),
      ),
      child: Row(
        children: [
          isTopThree
              ? const Icon(Icons.emoji_events, color: Colors.amber, size: 26.0)
              : CircleAvatar(
            radius: 14.0,
            backgroundColor: Colors.grey.shade800,
            child: Text(
              '#$position',
              style: const TextStyle(color: Colors.white70, fontSize: 12.0),
            ),
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  team['team'],
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600, color: Colors.grey.shade300),
                ),
                Text(
                  team['college'],
                  style: TextStyle(color: Colors.grey.shade500),
                ),
              ],
            ),
          ),
          Text(
            '${team['points']} pts',
            style: const TextStyle(fontSize: 16.0, color: Color(0xFF64FFDA), fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 768;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Navbar(isMobile: isMobile),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text.rich(
                    TextSpan(
                      text: 'Leader',
                      style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 24.0),
                      children: const [
                        TextSpan(
                          text: 'board',
                          style: TextStyle(color: Colors.redAccent),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'Real-time rankings of teams competing in Manipal Hackathon 2025',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey.shade500),
                  ),
                  const SizedBox(height: 20.0),
                  Row(
                    children: [
                      _infoCard('Active Teams', '156', Icons.groups, Colors.cyan),
                      _infoCard('Problem Statements', '12', Icons.report_problem, Colors.purpleAccent),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(12.0),
                          margin: const EdgeInsets.symmetric(horizontal: 6.0),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade900.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(12.0),
                            border: Border.all(color: Colors.grey.shade700.withOpacity(0.5)),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.timer, color: Colors.pinkAccent, size: 30.0),
                              const SizedBox(height: 8.0),
                              CountdownInfoCard(),
                              const SizedBox(height: 4.0),
                              Text(
                                'Time Remaining',
                                style: TextStyle(fontSize: 14.0, color: Colors.grey.shade400),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24.0),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 12.0),
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade900,
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(color: Colors.grey.shade700),
                    ),
                    child: TextField(
                      controller: _searchController,
                      onChanged: (value) => setState(() => searchQuery = value),
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        hintText: 'Search teams or colleges...',
                        hintStyle: TextStyle(color: Colors.grey),
                        border: InputBorder.none,
                        icon: Icon(Icons.search, color: Colors.cyanAccent),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  ListView.builder(
                    itemCount: filteredTeams.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => _teamCard(filteredTeams[index]),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CountdownInfoCard extends StatefulWidget {
  const CountdownInfoCard({super.key});

  @override
  State<CountdownInfoCard> createState() => _CountdownInfoCardState();
}

class _CountdownInfoCardState extends State<CountdownInfoCard> {
  late Duration duration;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    duration = DateTime(2025, 10, 14, 11, 0, 0).difference(DateTime.now());
    timer = Timer.periodic(const Duration(seconds: 1), (_) => updateTimer());
  }

  void updateTimer() {
    if (!mounted) return;
    setState(() {
      duration = duration - const Duration(seconds: 1);
      if (duration.isNegative) duration = Duration.zero;
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  String twoDigits(int n) => n.toString().padLeft(2, '0');

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final textSize = width < 400 ? 18.0 : width < 768 ? 20.0 : 24.0;

    if (duration.inSeconds <= 0) {
      return Text(
        "Started!",
        style: TextStyle(
          fontSize: textSize,
          color: Colors.greenAccent,
          fontWeight: FontWeight.bold,
        ),
      );
    }

    final timeStr =
        "${twoDigits(duration.inHours)}:${twoDigits(duration.inMinutes.remainder(60))}:${twoDigits(duration.inSeconds.remainder(60))}";

    return Text(
      timeStr,
      style: TextStyle(
        fontSize: textSize,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontFamily: 'Xavier3',
      ),
    );
  }
}
