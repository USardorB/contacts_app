import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:contacts_app/core/secrets/firebase_options.dart';

class FirebaseService {
  static final FirebaseAuth auth = FirebaseAuth.instance;

  static Future<void> init() async {
    await Firebase.initializeApp(
      // options: DefaultFirebaseOptions.currentPlatform,
    );
  }
}
