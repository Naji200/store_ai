class Vetement {
  final String id;
  final String image;
  final String titre;
  final String taille;
  final double prix;

  Vetement({
    required this.id,
    required this.image,
    required this.titre,
    required this.taille,
    required this.prix,
  });

  // Factory pour créer un objet Vetement à partir des données Firestore
  factory Vetement.fromFirestore(Map<String, dynamic> data, String id) {
    return Vetement(
      id: id,
      image: data['image'] ?? '',
      titre: data['titre'] ?? '',
      taille: data['taille'] ?? '',
      prix: (data['prix'] as num?)?.toDouble() ?? 0.0,
    );
  }
}
