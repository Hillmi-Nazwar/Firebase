#  Praktikum Mobile Programming
## Integrasi Flutter & Firebase (Project Based)

>==============================================<

## Setelah menambahkan code yang diberikan pada modul berikut hasilnya:

    * Disini terlihat ada data nya itu disebabkan karena saya sebelumnya telah menambahkan datanya.
<img width="1920" height="1080" alt="Screenshot (539)" src="https://github.com/user-attachments/assets/e7f0eb6d-8f34-4ec8-821f-42a7a4d6875d" />

    * Lanjut disini klik tanda + dan tambahkan Judul serta catatan nya.
<img width="1920" height="1080" alt="Screenshot (540)" src="https://github.com/user-attachments/assets/d3cf27c6-3252-4613-b305-a9982e82bf4d" />

    * Berikut tampilan setelah berhasil menambahkan.
<img width="1920" height="1080" alt="Screenshot (541)" src="https://github.com/user-attachments/assets/9be41468-8f8f-4af0-af47-65b85cc3df17" />

    * Setelah itu beralih ke firebase nya apakah ada data yang telah ditambahkan dan jangan lupa refresh pada tab nya
<img width="1920" height="1080" alt="Screenshot (542)" src="https://github.com/user-attachments/assets/6404e4e0-eeb6-4b09-97c6-ade625a3c400" />

    * Berikut hasil akhir yang telah diterima oleh firebase berisi judul dan catatan yang tadi telah ditambahkan.
<img width="1920" height="1080" alt="Screenshot (543)" src="https://github.com/user-attachments/assets/d8b4b71b-d4a1-4ed8-b8ec-0e3e241c1edb" />

>==============================================<

# Tugas Praktikum (Challenge)
Untuk memvalidasi pemahaman Anda, kerjakan tantangan berikut di sisa waktu praktikum:
1. Update Feature: Tambahkan fitur edit. Ketika ListTile ditekan (onTap), munculkan
formulir yang sudah terisi data lama, dan update data tersebut di Firebase menggunakan
perintah .update().
2. Testing: Jalankan aplikasi di 2 device berbeda (Emulator HP Fisik atau 2 Emulator).
Buktikan bahwa data tersinkronisasi secara otomatis.


## Code nya :

   *       onTap: () => _showEditForm(document),

Code ini memiliki fungsi menambahkan handler yang memanggil fungsi _showEditForm dan mengirim objek document (yang berisi data lama dan ID).

   *     void _showEditForm(DocumentSnapshot doc) {
         final TextEditingController editTitle = TextEditingController(text: doc['title'] ?? '');
         final TextEditingController editContent = TextEditingController(text: doc['content'] ?? '');
     
Code ini memiliki fungsi yang menerima DocumentSnapshot dari dokumen yang akan diedit dan Mengisi Controller dengan data lama (pre-filled form).

   *     ElevatedButton(
         await _notes.add({
                    "title": title,
                    "content": content,
                    "timestamp": FieldValue.serverTimestamp(),
                  });
           )
Code ini memiliki fungsi Tombol aksi untuk menyimpan perubahan, Menggunakan ID dokumen (doc.id) untuk mendapatkan referensi dan memanggil perintah .update() ke Firebase dan Mengirim data baru ke Firebase untuk mengganti data lama.

## Hasil Final

*       Langkah pertama tambahkan dulu judul dan catatan nya
  ![12](https://github.com/user-attachments/assets/a2165977-cfff-4612-b9e0-610c157c7d85)

*      Langkah kedua upload dan sekrang jika di klik ada menu update
  ![13](https://github.com/user-attachments/assets/94cf09fe-b1e6-4959-871e-4fc50e1fe988)

  ![14](https://github.com/user-attachments/assets/c195e215-de92-4e7b-8918-7c32220b53fb)


*      Langkah terakhir jika berhasil maka akan ada perubahan
  ![15](https://github.com/user-attachments/assets/d30c853e-732d-4eca-9127-a2cabed2b623)

*      # Berikut hasil Akhir akan terlihat di Firebase nya
   <img width="1920" height="1080" alt="Screenshot (542)" src="https://github.com/user-attachments/assets/c2f31e74-5e20-4433-97f8-1be2d7f5261e" />

   <img width="1920" height="1080" alt="Screenshot (543)" src="https://github.com/user-attachments/assets/4aeb2dae-95be-4976-a480-6c45aa602ed0" />

   <img width="1920" height="1080" alt="Screenshot (544)" src="https://github.com/user-attachments/assets/d0d1c441-9604-4205-94cb-2277393cdffa" />



  














  



