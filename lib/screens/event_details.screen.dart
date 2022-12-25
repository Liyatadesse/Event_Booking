import 'dart:io';
import 'package:booking_app/providers/booking.provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/event.model.dart';
import '../models/user.model.dart';
import '../providers/auth.provider.dart';
import '../utils/helpers.util.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({
    super.key,
    required this.ticket,
  });
  final Event ticket;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    Color color = Colors.black;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: BuildAppBar(context),
      body: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
            //height: 600,
            height: size.height * 0.6,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
              ),
              child: ListView(
                // crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '${widget.ticket.id}\n\n',
                          style: TextStyle(fontSize: 18, color: color),
                        ),
                        TextSpan(
                            text: 'MUSIC\n',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                color: color)),
                        TextSpan(
                            text: 'CONCERT\n\n',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                color: color)),
                        TextSpan(
                          text: 'Night Party\n',
                          style: TextStyle(fontSize: 20, color: color),
                        ),
                        TextSpan(
                          text: 'Live Music\n',
                          style: TextStyle(fontSize: 20, color: color),
                        ),
                        TextSpan(
                          text: 'Special Event On ${widget.ticket.desc}\n\n',
                          style: TextStyle(fontSize: 20, color: color),
                        ),
                        TextSpan(
                          text: 'Singer: ',
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 22,
                              color: color),
                        ),
                        TextSpan(
                            text: '${widget.ticket.name}\n\n',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: color)),
                        TextSpan(
                            text: 'ADDRESS: ',
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 22,
                                color: color)),
                        TextSpan(
                            text: '${widget.ticket.address}\n\n',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: color)),
                        TextSpan(
                            text: 'TICKET PRICE: ',
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 22,
                                color: color)),
                        TextSpan(
                            text: '${widget.ticket.price}\n\n',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                                color: color)),
                        TextSpan(
                            text: 'DATE: ',
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 22,
                                color: color)),
                        TextSpan(
                            text: '${widget.ticket.dateOfEvent} \n\n',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                                color: color)),
                        TextSpan(
                            text: 'TIME: ',
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 22,
                                color: color)),
                        TextSpan(
                            text: '${widget.ticket.dateOfEvent} ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                                color: color)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.only(bottom: 10),
            child: ElevatedButton(
              onPressed: _isLoading ? null : _book,
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                fixedSize: Size(size.width * 0.65, 50),
                backgroundColor: Colors.orange,
                textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : Text(
                      'book now'.toUpperCase(),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  AppBar BuildAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.orange,
      elevation: 0,
      leading: IconButton(
          color: Colors.black,
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back)),
    );
  }

  _book() async {
    final User? currentUser =
        Provider.of<AuthProvider>(context, listen: false).currentUser;
    final bookProvider = Provider.of<BookProvider>(context, listen: false);
    // FocusScopeNode focusScope = FocusScopeNode();
    // if (!focusScope.hasPrimaryFocus) {
    //   focusScope.unfocus();
    // }
    _isLoading = true;
    setState(() {});

    try {
      await bookProvider.bookEvent(
          userId: currentUser?.id, eventId: widget.ticket.id);

      final snackBar = SnackBar(
        //  backgroundColor: Colors.orange,
        content: const Text('Successfully Booked!'),
        action: SnackBarAction(
          label: 'Ok',
          onPressed: () {},
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      if (mounted) {
        Navigator.of(context).popUntil(ModalRoute.withName('/'));
      }
    } on HttpException catch (e) {
      showErrorDialog(context, message: e.message);
    } on SocketException catch (_) {
      showErrorDialog(context, message: "Connection not found");
    } catch (e) {
      showErrorDialog(context);
    }

    _isLoading = false;
    setState(() {});
  }
}
