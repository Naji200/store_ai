import 'package:cloud_firestore/cloud_firestore.dart';
import 'vetement.dart';

class VetementService {
  final CollectionReference vetementsRef =
      FirebaseFirestore.instance.collection('vetements');

  // Méthode pour récupérer les vêtements depuis Firestore
  Future<List<Vetement>> fetchVetements() async {
    try {
      QuerySnapshot snapshot = await vetementsRef.get();
      return snapshot.docs
          .map((doc) => Vetement.fromFirestore(
              doc.data() as Map<String, dynamic>, doc.id))
          .toList();
    } catch (e) {
      print('Erreur lors du fetch : $e');
      return [];
    }
  }
}
