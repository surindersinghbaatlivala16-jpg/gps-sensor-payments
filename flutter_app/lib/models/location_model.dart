class LocationModel {
  final String locationId;
  final String userId;
  final double latitude;
  final double longitude;
  final double? accuracy;
  final double? altitude;
  final double? speed;
  final double? heading;
  final String? address;
  final DateTime timestamp;

  LocationModel({
    required this.locationId,
    required this.userId,
    required this.latitude,
    required this.longitude,
    this.accuracy,
    this.altitude,
    this.speed,
    this.heading,
    this.address,
    required this.timestamp,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      locationId: json['_id'] ?? '',
      userId: json['user_id'] ?? '',
      latitude: (json['latitude'] ?? 0).toDouble(),
      longitude: (json['longitude'] ?? 0).toDouble(),
      accuracy: json['accuracy']?.toDouble(),
      altitude: json['altitude']?.toDouble(),
      speed: json['speed']?.toDouble(),
      heading: json['heading']?.toDouble(),
      address: json['address'],
      timestamp: DateTime.parse(json['timestamp'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() => {
    '_id': locationId,
    'user_id': userId,
    'latitude': latitude,
    'longitude': longitude,
    'accuracy': accuracy,
    'altitude': altitude,
    'speed': speed,
    'heading': heading,
    'address': address,
    'timestamp': timestamp.toIso8601String(),
  };

  LocationModel copyWith({
    String? locationId,
    String? userId,
    double? latitude,
    double? longitude,
    double? accuracy,
    double? altitude,
    double? speed,
    double? heading,
    String? address,
    DateTime? timestamp,
  }) {
    return LocationModel(
      locationId: locationId ?? this.locationId,
      userId: userId ?? this.userId,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      accuracy: accuracy ?? this.accuracy,
      altitude: altitude ?? this.altitude,
      speed: speed ?? this.speed,
      heading: heading ?? this.heading,
      address: address ?? this.address,
      timestamp: timestamp ?? this.timestamp,
    );
  }
}
