import 'package:note_taking_app/models/event_model.dart';
import 'package:note_taking_app/models/note_model.dart';

class DummyData {
  final List<NoteModel> dummyNotes = [
    NoteModel(
      title: 'Meeting dengan Tim Pengembangan',
      content:
          """Diskusi mengenai pembaruan fitur aplikasi yang akan datang, serta timeline pengembangan. Beberapa hal yang dibahas:

          1. Fase Pengembangan: Tim sepakat untuk menyelesaikan fase pengujian pada minggu depan.
          2. Bug yang Ditemukan: Beberapa bug ditemukan pada fitur login dan pengingat. Pengembang diminta untuk segera memperbaiki.
          3. Integrasi API: Pengintegrasian dengan API pihak ketiga sedang dalam proses.
          4. Pengujian UI: UI membutuhkan beberapa perbaikan untuk memudahkan pengguna baru.
          5. Deadline: Semua pekerjaan harus diselesaikan dalam dua minggu ke depan.""",
      // position: 0,
    ),
    NoteModel(
      title: 'Evaluasi dan Pengelolaan Waktu yang Lebih Efisien',
      content:
          'Pengelolaan waktu adalah kunci untuk mencapai produktivitas tinggi, baik di kehidupan pribadi maupun profesional. Evaluasi cara kita menggunakan waktu setiap harinya perlu dilakukan agar lebih efisien. Salah satu pendekatan yang bisa diterapkan adalah metode time blocking, di mana setiap tugas dibagi dalam blok waktu tertentu untuk meminimalkan gangguan. Penggunaan aplikasi manajemen waktu seperti Todoist atau Notion juga membantu merencanakan aktivitas harian dan mengingatkan tenggat waktu penting. Selain itu, penting untuk mengidentifikasi kebiasaan buruk yang menyita waktu, seperti terlalu sering memeriksa media sosial atau menunda pekerjaan. Dengan melakukan perubahan kecil dalam rutinitas harian, diharapkan waktu yang terbuang bisa diminimalkan dan produktivitas bisa ditingkatkan secara signifikan.',
      // position: 1,
    ),
    NoteModel(
      title: 'Panduan Membangun Kesehatan Mental yang Lebih Baik',
      content:
          'Kesehatan mental yang baik sangat penting dalam menjalani kehidupan yang produktif dan bahagia. Membangun kesehatan mental yang baik dimulai dari kebiasaan sehari-hari yang mendukung kesejahteraan emosional dan psikologis. Langkah pertama adalah membangun rutinitas yang baik, seperti tidur yang cukup, berolahraga secara teratur, dan makan makanan sehat. Selain itu, meluangkan waktu untuk aktivitas yang disukai, seperti berkumpul dengan keluarga atau teman, bisa membantu melepaskan stres. Teknik-teknik relaksasi seperti meditasi atau pernapasan dalam juga dapat menjadi cara efektif untuk mengatasi kecemasan atau stres. Untuk lebih lanjut, melakukan refleksi diri melalui jurnal atau terapi juga bisa memberikan wawasan tentang cara memperbaiki kondisi mental secara keseluruhan.',
      // position: 2,
    ),
    NoteModel(
      title: 'Strategi Meningkatkan Keterampilan Manajerial',
      content:
          'Keterampilan manajerial yang kuat adalah fondasi untuk menjadi seorang pemimpin yang efektif. Untuk mengembangkan keterampilan ini, ada beberapa area yang harus difokuskan, yaitu pengambilan keputusan, komunikasi tim, serta kemampuan untuk memotivasi dan menginspirasi orang lain. Mengambil inisiatif dalam proyek-proyek besar dan bekerja sama dengan tim multidisiplin adalah cara untuk belajar langsung tentang dinamika tim dan cara menghadapi tantangan organisasi. Selain itu, penting untuk mempelajari teknik-teknik pengelolaan waktu dan sumber daya yang efisien, agar tidak hanya mencapai hasil yang diinginkan tetapi juga menjaga keseimbangan kerja yang sehat. Pelatihan formal dan pengalaman langsung di lapangan menjadi aspek kunci dalam meningkatkan kemampuan manajerial ini, yang pada akhirnya mendukung pencapaian tujuan organisasi.',
      // position: 3,
    ),
    NoteModel(
      title: 'Meningkatkan Kualitas Tidur untuk Kesehatan yang Lebih Baik',
      content:
          'Tidur yang berkualitas sangat mempengaruhi kesehatan fisik dan mental kita. Sayangnya, banyak orang tidak cukup memberi perhatian pada kebiasaan tidur yang buruk, yang pada akhirnya dapat menyebabkan penurunan produktivitas dan masalah kesehatan. Untuk meningkatkan kualitas tidur, langkah pertama adalah memperbaiki rutinitas tidur, seperti menetapkan waktu tidur dan bangun yang konsisten setiap hari. Mengurangi konsumsi kafein beberapa jam sebelum tidur dan menciptakan lingkungan tidur yang tenang serta nyaman juga sangat membantu. Selain itu, menghindari penggunaan perangkat elektronik sebelum tidur dapat mengurangi gangguan yang menghalangi tubuh untuk masuk ke fase tidur yang dalam. Dengan memperhatikan kebiasaan tidur dan menciptakan lingkungan tidur yang mendukung, kita dapat merasakan manfaat dari tidur yang lebih berkualitas dan memperbaiki kondisi fisik serta mental secara keseluruhan.',
      // position: 4,
    ),
  ];

  List<EventModel> eventDummy = [
    EventModel(
      title: "Workut Rutin",
      desc: "Workout rutin biar badan makin sehat, lari pagi di area bintaro",
      eventStart: DateTime(2025, 2, 16, 5, 30),
      eventEnd: DateTime(2025, 2, 16, 7, 30),
    ),
    EventModel(
      title: "Meeting dengan IOH",
      desc: "Meeting pembahasan kelanjutan sewa",
      eventStart: DateTime(2025, 2, 17, 10, 30),
      eventEnd: DateTime(2025, 2, 17, 12, 00),
    ),
    EventModel(
      title: "Rapat Tim Proyek",
      desc: "Diskusi tentang progress proyek, kendala yang dihadapi, dan rencana sprint berikutnya. Pastikan membawa laporan mingguan dan catatan meeting sebelumnya.",
      eventStart: DateTime(2025, 2, 17, 10, 30),
      eventEnd: DateTime(2025, 2, 17, 12, 00),
    ),
    EventModel(
      title: "Bayar Tagihan Listrik & Internet",
      desc: "Pastikan untuk membayar tagihan listrik dan internet sebelum jatuh tempo agar tidak terkena denda atau pemutusan layanan.",
      eventStart: DateTime(2025, 2, 17, 10, 30),
      eventEnd: DateTime(2025, 2, 17, 12, 00),
    ),
    EventModel(
      title: "Webinar “Tren Teknologi 2025”",
      desc: "Mengikuti webinar tentang tren teknologi terbaru yang akan berkembang tahun ini. Pastikan sudah melakukan registrasi dan menyiapkan catatan untuk poin-poin penting.",
      eventStart: DateTime(2025, 2, 17, 10, 30),
      eventEnd: DateTime(2025, 2, 17, 12, 00),
    ),
  ];
}
