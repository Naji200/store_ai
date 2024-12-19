import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ListeVetements extends StatelessWidget {
  ListeVetements({super.key});
  final CollectionReference vetementsRef =
      FirebaseFirestore.instance.collection('vetements');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liste des vêtements'),
        backgroundColor: Colors.green,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: vetementsRef.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Erreur : ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text('Aucun vêtement disponible.'),
            );
          }

          final vetements = snapshot.data!.docs;

          return ListView.builder(
            itemCount: vetements.length,
            itemBuilder: (context, index) {
              final data = vetements[index].data() as Map<String, dynamic>;

              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  leading: Image.network(
                    data['image'],
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                  title: Text(data['titre'] ?? 'Titre indisponible'),
                  subtitle: Text(
                      'Taille: ${data['taille'] ?? 'Non spécifiée'} | Prix: ${data['prix'] ?? 'Non spécifié'} €'),
                  onTap: () {
                    // Ajouter une navigation vers la page de détails si nécessaire
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
