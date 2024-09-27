import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          _buildCard(
            name: "John",
            imageUrl:
                "https://placekitten.com/200/300", // Replace with real image URL
            description: "John has seen your PANDA",
            distance: "150m",
          ),
          _buildCard(
            name: "Sarah",
            imageUrl:
                "https://placekitten.com/200/301", // Replace with real image URL
            description: "Sarah has seen your DOGGO",
            distance: "300m",
          ),
          _buildCard(
            name: "Michael",
            imageUrl:
                "https://placekitten.com/200/302", // Replace with real image URL
            description: "Michael has seen your CATTO",
            distance: "1.2km",
          ),
        ],
      ),
    );
  }

  Widget _buildCard({
    required String name,
    required String imageUrl,
    required String description,
    required String distance,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(imageUrl), // Pet's image
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Distance: $distance',
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () {
                // Action when pressing more options
              },
            ),
          ],
        ),
      ),
    );
  }
}
