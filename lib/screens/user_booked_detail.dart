import 'package:booking_app/models/book.model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user.model.dart';
import '../providers/auth.provider.dart';
import '../providers/events.provider.dart';

class BookedEvent extends StatefulWidget {
  const BookedEvent({
    super.key,
  });

  @override
  State<BookedEvent> createState() => _BookedEventState();
}

class _BookedEventState extends State<BookedEvent> {
  bool _isLoading = false, _hasFailed = false;

  @override
  initState() {
    super.initState();
    fetchUserBookings();
  }

  fetchUserBookings() async {
    final User? currentUser =
        Provider.of<AuthProvider>(context, listen: false).currentUser;
    final EventsProvider bookProvider =
        Provider.of<EventsProvider>(context, listen: false);
    _isLoading = true;
    setState(() {});
    try {
      await bookProvider.fetchUserBookings(userId: currentUser?.id);
      //  debugPrint(currentUser?.id);
    } catch (e) {
      debugPrint("An error occured: $e\n");
      _hasFailed = true;
    }
    _isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final User? currentUser =
        Provider.of<AuthProvider>(context, listen: true).currentUser;
    final List<Book> bookedEvents =
        Provider.of<EventsProvider>(context).bookedEvents;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Center(
              child: Text(
                "Welcome  ${currentUser?.name} Your Booked Events",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ),
          // TextButton(
          //     onPressed: fetchUserBookings,
          //     child: const Text("Your Booked Events")),
          ListView.builder(
              shrinkWrap: true,
              itemCount: bookedEvents.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    "${index + 1},  ${bookedEvents[index].event}",
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                );
              }),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
