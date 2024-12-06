import 'package:cloud_firestore/cloud_firestore.dart';

class FireCollections {
  static final firestore = FirebaseFirestore.instance;
  static final barberRef = firestore.collection('barbers');
  static final bookingRef = firestore.collection('bookings');
  static final settingsRef = firestore.collection('settings');
  static final hoursRef = firestore.collection('hours');
  static final servicesRef = firestore.collection('services');
}
