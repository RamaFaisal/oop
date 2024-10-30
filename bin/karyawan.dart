import 'package:intl/intl.dart';

const UMR = 2900000;

var numFormat = NumberFormat("#,000");
var dateFormat = DateFormat('yyyy-MM-dd');

abstract class Karyawan {
  String npp = "";
  String nama = "";
  String? alamat;
  int thnMasuk;
  int _gaji = 2900000;

  Karyawan(this.npp, this.nama, {this.thnMasuk = 2015});

  void presensi(DateTime jamMasuk);
  // {
  //   if (jamMasuk.hour > 8) {
  //     print("$nama Datang terlambat");
  //   } else {
  //     print("$nama datang tepat waktu");
  //   }
  // }

  String deskripsi() {
    String teks = """===================
    NPP: $npp
    Nama: $nama
    Gaji:${numFormat.format(gaji)}""";
    if (alamat != null) {
      teks += "\n Alamat: $alamat";
    }
    return teks;
  }

  // int get tunjangan {
  //   if ((2023 - thnMasuk) < 5) {
  //     return 50000;
  //   } else {
  //     return 100000;
  //   }
  // }

  // getter with arrow function
  int get tunjangan;
  // => ((2023 - thnMasuk) < 5) ? 50000 : 100000

  int get gaji => (_gaji + tunjangan);

  void set gaji(int gaji) {
    if (gaji < UMR) {
      _gaji = UMR;
      print("Gaji tidak boleh dibawah UMR");
    } else {
      _gaji = gaji;
    }
  }
}

enum TipeJabatan { kabag, manajer, direktur }

class Pejabat extends Karyawan {
  TipeJabatan jabatan;

  Pejabat(super.npp, super.nama, this.jabatan);

  @override
  void presensi(DateTime jamMasuk) {
    if (jamMasuk.hour > 10) {
      print("$nama pada ${dateFormat.format(jamMasuk)} datang terlambat");
    } else {
      print("$nama pada ${dateFormat.format(jamMasuk)} datang tepat waktu");
    }
  }

  @override
  int get tunjangan {
    if (jabatan == TipeJabatan.kabag) {
      return 1500000;
    } else if (jabatan == TipeJabatan.manajer) {
      return 2500000;
    } else {
      return 5000000;
    }
  }

  @override
  String deskripsi() {
    String teks = super.deskripsi();
    teks += "\nJabatan : $jabatan";
    return teks;
  }
}

class StafBiasa extends Karyawan {
  StafBiasa(super.npp, super.nama, {thnMasuk = 2015});

  @override
  void presensi(DateTime jamMasuk) {
    if (jamMasuk.hour > 8) {
      print("$nama Datang terlambat");
    } else {
      print("$nama datang tepat waktu");
    }
  }

  @override
  int get tunjangan => ((2023 - thnMasuk) < 5) ? 50000 : 100000;
}