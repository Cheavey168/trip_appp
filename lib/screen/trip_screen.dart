import 'package:flutter/material.dart';

import '../model/trip_model.dart';
import '../services/trip_service.dart';

class TripScreen extends StatefulWidget {
  const TripScreen({Key? key}) : super(key: key);

  @override
  _TripScreenState createState() => _TripScreenState();
}

class _TripScreenState extends State<TripScreen> {
  late Future<List<Trip>> trips;
  final TripService tripService = TripService();

  @override
  void initState() {
    super.initState();
    trips = tripService.fetchAllTrips();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Trips'),
      ),
      body: FutureBuilder<List<Trip>>(
        future: trips,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No trips found'));
          } else {
            final trips = snapshot.data!;
            return ListView.builder(
              itemCount: trips.length,
              itemBuilder: (context, index) {
                final trip = trips[index];
                return ListTile(
                  title: Text(trip.tripTitle),
                  subtitle: Text(
                      '${trip.description}\nPeople: ${trip.tripPeople}\nBudget: \$${trip.tripBudget}'),
                  isThreeLine: true,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TripDetailsScreen(trip: trip),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}

class TripDetailsScreen extends StatelessWidget {
  final Trip trip;

  const TripDetailsScreen({Key? key, required this.trip}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(trip.tripTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Description: ${trip.description}'),
            Text('Start Date: ${trip.startDate.toLocal()}'),
            Text('End Date: ${trip.endDate.toLocal()}'),
            Text('Budget: \$${trip.tripBudget}'),
            Text('People: ${trip.tripPeople}'),
            Text('Created At: ${trip.createdAt.toLocal()}'),
            Text('Updated At: ${trip.updatedAt.toLocal()}'),
            Text('User ID: ${trip.userId}'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                bool success = await TripService().deleteTrip(trip.tripId);
                if (success) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Trip deleted successfully')),
                  );
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Failed to delete trip')),
                  );
                }
              },
              child: const Text('Delete Trip'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
