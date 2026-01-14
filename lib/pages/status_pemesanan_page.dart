import 'package:flutter/material.dart';
import 'package:flutter_application_2/providers/pesanan_providers.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../providers/pesanan_providers.dart';

class StatusPesananPage extends StatelessWidget {
  const StatusPesananPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Memanggil Provider untuk ambil data riwayat pesanan
    final pesananProv = Provider.of<PesananProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xFFFDFBFA),
      appBar: AppBar(
        title: Text(
          "Status Pesanan",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF5D4037),
        elevation: 0,
        centerTitle: true,
      ),
      body: pesananProv.riwayat.isEmpty
          ? _buildEmptyState()
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: pesananProv.riwayat.length,
              itemBuilder: (context, index) {
                final pesanan = pesananProv.riwayat[index];
                return _buildStatusCard(pesanan);
              },
            ),
    );
  }

  // Tampilan kalau belum ada pesanan
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.receipt_long_outlined, size: 100, color: Colors.grey[300]),
          const SizedBox(height: 16),
          Text(
            "Belum ada pesanan aktif",
            style: GoogleFonts.poppins(color: Colors.grey, fontSize: 16),
          ),
        ],
      ),
    );
  }

  // Kartu rincian status pesanan
  Widget _buildStatusCard(pesanan) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                pesanan.id,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  color: Colors.brown,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.orange[50],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  pesanan.status,
                  style: GoogleFonts.poppins(
                    color: Colors.orange[800],
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const Divider(height: 30),
          Text(
            "Menu:",
            style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey),
          ),
          Text(
            pesanan.items,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 20),

          // Timeline Status
          Row(
            children: [
              _buildStep(true, "Dipesan"),
              _buildLine(true),
              _buildStep(true, "Dimasak"),
              _buildLine(false),
              _buildStep(false, "Selesai"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStep(bool isActive, String label) {
    return Column(
      children: [
        Icon(
          isActive ? Icons.check_circle : Icons.radio_button_unchecked,
          color: isActive ? Colors.green : Colors.grey[300],
          size: 20,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 10,
            color: isActive ? Colors.black : Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildLine(bool isActive) {
    return Expanded(
      child: Container(
        height: 2,
        color: isActive ? Colors.green : Colors.grey[300],
        margin: const EdgeInsets.only(bottom: 15),
      ),
    );
  }
}
