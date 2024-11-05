import 'package:flutter/material.dart';
import 'package:trip_plan_select/model/trip_model.dart';

class TripDetailScreen extends StatelessWidget {
  final Trip trip;

  const TripDetailScreen({Key? key, required this.trip}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(trip.tripTitle)),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              trip.tripTitle,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('Description: ${trip.description}'),
            SizedBox(height: 8),
            Text(
                'Start Date: ${trip.startDate.toLocal().toString().split(' ')[0]}'),
            Text(
                'End Date: ${trip.endDate.toLocal().toString().split(' ')[0]}'),
            SizedBox(height: 8),
            Text('Budget: \$${trip.tripBudget.toStringAsFixed(2)}'),
            Text('People: ${trip.tripPeople}'),
          ],
        ),
      ),
    );
  }
}
