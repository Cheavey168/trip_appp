class Trip {
  final int tripId;
  final String tripTitle;
  final String description;
  final DateTime startDate;
  final DateTime endDate;
  final double tripBudget;
  final String tripPeople;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int userId;

  Trip({
    required this.tripId,
    required this.tripTitle,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.tripBudget,
    required this.tripPeople,
    required this.createdAt,
    required this.updatedAt,
    required this.userId,
  });

  factory Trip.fromJson(Map<String, dynamic> json) {
    return Trip(
      tripId: json['trip_id'],
      tripTitle: json['trip_title'],
      description: json['description'],
      startDate: DateTime.parse(json['start_date']),
      endDate: DateTime.parse(json['end_date']),
      tripBudget: json['trip_budget'].toDouble(),
      tripPeople: json['trip_people'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      userId: json['user_id'],
    );
  }
}
