import 'package:booking_app/models/event.model.dart';
import 'package:booking_app/models/user.model.dart';
import 'package:booking_app/providers/auth.provider.dart';
import 'package:booking_app/providers/events.provider.dart';
import 'package:booking_app/screens/landing.screen.dart';
import 'package:booking_app/screens/user_booked_detail.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'event_details.screen.dart';
import '../widgets/item_card.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoading = false, _hasFailed = false;

  @override
  initState() {
    super.initState();
    fetchEvents();
  }

  fetchEvents() async {
    final EventsProvider eventsProvider =
        Provider.of<EventsProvider>(context, listen: false);
    _isLoading = true;
    _hasFailed = false;
    setState(() {});

    try {
      await eventsProvider.fetchEvents();
    } catch (e) {
    //  debugPrint("An error occured: $e\n");
      _hasFailed = true;
    }
    _isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final User? currentUser =
        Provider.of<AuthProvider>(context, listen: true).currentUser;

    final List<Event> events = Provider.of<EventsProvider>(context).events;

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.orange,
         
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                "Welcome to whatever this is ${currentUser?.name}",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            Expanded(
              child: _isLoading
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          CircularProgressIndicator(),
                          Text("Fetching events...Please wait")
                        ],
                      ),
                    )
                  : _hasFailed
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                  onPressed: fetchEvents,
                                  child: const Text("Try again")),
                              const Text("Failed to load events")
                            ],
                          ),
                        )
                      : events.isEmpty
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [Text("No events found!")],
                              ),
                            )
                          : GridView.builder(
                              itemCount: events.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 5,
                                childAspectRatio: 0.75,
                              ),
                              itemBuilder: (context, index) => ItemCard(
                                ticket: events[index],
                                press: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => DetailScreen(
                                        ticket: events[index],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const LandingScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                child: const Text(
                  'Log Out',
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              // const DrawerHeader(
              //   decoration: BoxDecoration(
              //     color: Colors.orange,
              //   ),
              //   child: Text('Booked Events'),
              // ),
              ListTile(
                title: const Text('Booked Events'),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const BookedEvent(),
                    ),
                  );
                },
              ),
            ],
          ),
        ));
  }
}
