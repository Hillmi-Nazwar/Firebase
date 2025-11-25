// ...existing code...
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart'; // otomatis dibuat oleh flutterfire configure


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Aktifkan persistence (opsional tapi membantu sinkronisasi dan loading)
  FirebaseFirestore.instance.settings = const Settings(persistenceEnabled: true);

  runApp(const MyApp());
}
// ...existing code...
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Live Notes',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
    );
  }
}
// ...existing code...
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Referensi koleksi Firestore
  final CollectionReference _notes =
      FirebaseFirestore.instance.collection('notes');

  // Controller input untuk tambah (tetap dipakai)
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Live Notes Fire")),

      // STREAMBUILDER: realtime listener Firestore
      body: StreamBuilder<QuerySnapshot>(
        stream: _notes.orderBy('timestamp', descending: true).snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          // Kondisi 1: Loading
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          // Kondisi 2: Data kosong
          if (snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text("Belum ada catatan."),
            );
          }

          // Kondisi 3: Ada data → tampilkan list
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final DocumentSnapshot document = snapshot.data!.docs[index];

              return Card(
                margin: const EdgeInsets.all(8),
                child: ListTile(
                  // Tambah onTap untuk edit
                  onTap: () => _showEditForm(document),
                  title: Text(
                    document['title'] ?? '',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(document['content'] ?? ''),
  
                  // Tombol hapus
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      _notes.doc(document.id).delete();
                    },
                  ),
                ),
              );
            },
          );
        },
      ),

      // Tombol tambah catatan
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showForm(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  // Form tambah (tidak berubah)
  void _showForm(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => Padding(
        padding: EdgeInsets.only(
          top: 20,
          left: 20,
          right: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Judul'),
            ),

            TextField(
              controller: _contentController,
              decoration: const InputDecoration(labelText: 'Isi Catatan'),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              child: const Text("Simpan Catatan"),
              onPressed: () async {
                final String title = _titleController.text;
                final String content = _contentController.text;

                if (content.isNotEmpty) {
                  await _notes.add({
                    "title": title,
                    "content": content,
                    "timestamp": FieldValue.serverTimestamp(),
                  });

                  _titleController.clear();
                  _contentController.clear();
                  Navigator.of(context).pop();
                }
              },
            )
          ],
        ),
      ),
    );
  }

  // Form edit: muncul prefilled dan update dokumen dengan .update()
  void _showEditForm(DocumentSnapshot doc) {
    final TextEditingController editTitle = TextEditingController(text: doc['title'] ?? '');
    final TextEditingController editContent = TextEditingController(text: doc['content'] ?? '');

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => Padding(
        padding: EdgeInsets.only(
          top: 20,
          left: 20,
          right: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: editTitle,
              decoration: const InputDecoration(labelText: 'Judul'),
            ),

            TextField(
              controller: editContent,
              decoration: const InputDecoration(labelText: 'Isi Catatan'),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              child: const Text("Update Catatan"),
              onPressed: () async {
                final String title = editTitle.text;
                final String content = editContent.text;

                if (content.isNotEmpty) {
                  await _notes.doc(doc.id).update({
                    "title": title,
                    "content": content,
                    // jika ingin update timestamp:
                    "timestamp": FieldValue.serverTimestamp(),
                  });

                  Navigator.of(context).pop();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}