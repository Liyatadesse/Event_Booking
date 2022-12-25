import 'package:booking_app/models/event.model.dart';
import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({super.key, required this.press, required this.ticket});
  final Function press;
  final Event ticket;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        press();
      },
      child: ListView(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                //color: ticket.color,
              ),
              height: 220,
              width: size.width,
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Image.network(
                  ticket.imageUrl,
                  fit: BoxFit.fill,
                ),
              )),
          const SizedBox(
            height: 3,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: RichText(
                text: TextSpan(children: [
              TextSpan(
                text: '${ticket.name}\n',
                style: const TextStyle(color: Colors.grey, fontSize: 15),
              ),
              TextSpan(
                  text: '${ticket.price} Birr',
                  style: const TextStyle(color: Colors.black))
            ])),
          )
        ],
      ),
    );
  }
}
