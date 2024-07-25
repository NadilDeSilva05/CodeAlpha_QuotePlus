import 'package:flutter/material.dart';
//import 'package:quote_plus/api.dart';
//import 'package:quote_plus/quote_model.dart';
import 'package:share_plus/share_plus.dart'; // Dependency for sharing functionality
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // Import font_awesome_flutter package

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool inProgress = false;
  QuoteModel? quote;

  @override
  void initState() {
    _fetchQuote();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white, // Light background color
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Quote Plus",
                  style: TextStyle(
                    color: Color.fromARGB(255, 0, 15, 128),
                    fontFamily: 'Roboto',
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.blueGrey[100], // Light container color
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        quote?.q ?? "Fetching a quote...",
                        style: TextStyle(
                          fontSize: 24,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 1, 24, 137),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        quote?.a ?? "",
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Roboto',
                          fontStyle: FontStyle.italic,
                          color: Colors.blueGrey[600],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                if (inProgress)
                  const CircularProgressIndicator(
                    color: Color.fromARGB(255, 43, 54, 59),
                  )
                else
                  ElevatedButton(
                    onPressed: _fetchQuote,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orangeAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                    ),
                    child: Text(
                      "Generate",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                const SizedBox(height: 12),
                if (quote != null) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _shareButton(
                        icon: FontAwesomeIcons.facebookF,
                        color: const Color.fromARGB(255, 21, 101, 192),
                        onPressed: () {
                          Share.share(
                              'Check this out: ${quote?.q} — ${quote?.a}');
                        },
                      ),
                      _shareButton(
                        icon: FontAwesomeIcons.twitter,
                        color: Colors.lightBlue,
                        onPressed: () {
                          Share.share(
                              'Check this out: ${quote?.q} — ${quote?.a}');
                        },
                      ),
                      _shareButton(
                        icon: FontAwesomeIcons.linkedinIn,
                        color: const Color.fromARGB(255, 25, 118, 210),
                        onPressed: () {
                          Share.share(
                              'Check this out: ${quote?.q} — ${quote?.a}');
                        },
                      ),
                      _shareButton(
                        icon: FontAwesomeIcons.whatsapp,
                        color: Colors.green,
                        onPressed: () {
                          Share.share(
                              'Check this out: ${quote?.q} — ${quote?.a}');
                        },
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _shareButton({
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return IconButton(
      icon: Icon(icon, color: color),
      iconSize: 36,
      onPressed: onPressed,
    );
  }

  _fetchQuote() async {
    setState(() {
      inProgress = true;
    });
    try {
      final fetchedQuote = await Api.fetchRandomQuote();
      setState(() {
        quote = fetchedQuote;
      });
    } catch (e) {
      debugPrint("Failed to generate quote");
    } finally {
      setState(() {
        inProgress = false;
      });
    }
  }
}
