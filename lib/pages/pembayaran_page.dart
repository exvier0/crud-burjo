import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PembayaranPage extends StatelessWidget {
  final int totalHarga;
  final String items;

  const PembayaranPage({
    super.key, 
    required this.totalHarga, 
    required this.items
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFBFA),
      body: Column(
        children: [
          // 1. HEADER MELENGKUNG (Custom Shape)
          _buildHeader(context),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 2. KARTU RINCIAN PESANAN
                  _buildSectionTitle("Rincian Pesanan"),
                  _buildOrderCard(),

                  const SizedBox(height: 25),

                  // 3. PILIHAN METODE PEMBAYARAN
                  _buildSectionTitle("Metode Pembayaran"),
                  _buildPaymentMethod(Icons.qr_code_scanner, "QRIS / Kresna Pay", true),
                  _buildPaymentMethod(Icons.account_balance, "Transfer Bank", false),
                  _buildPaymentMethod(Icons.payments, "Tunai di Kasir", false),

                  const SizedBox(height: 30),
                  
                  // 4. TOMBOL BAYAR SEKARANG
                  _buildPayButton(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget Header Melengkung
  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 180,
      decoration: const BoxDecoration(
        color: Color(0xFF5D4037),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 50,
            left: 20,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                Text(
                  "Total Tagihan",
                  style: GoogleFonts.poppins(color: Colors.white70, fontSize: 14),
                ),
                Text(
                  "Rp $totalHarga",
                  style: GoogleFonts.poppins(
                    color: Colors.white, 
                    fontSize: 32, 
                    fontWeight: FontWeight.bold
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 16, 
          fontWeight: FontWeight.bold, 
          color: const Color(0xFF3E2723)
        ),
      ),
    );
  }

  Widget _buildOrderCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.receipt_long, color: Colors.orange, size: 20),
              const SizedBox(width: 8),
              Text("Item Pesanan", style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
            ],
          ),
          const Divider(height: 24),
          Text(
            items,
            style: GoogleFonts.poppins(color: Colors.grey[700], fontSize: 13),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethod(IconData icon, String label, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: isSelected ? Colors.orange : Colors.transparent, 
          width: 2
        ),
      ),
      child: Row(
        children: [
          Icon(icon, color: isSelected ? Colors.orange : Colors.brown[300]),
          const SizedBox(width: 15),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              color: isSelected ? Colors.orange[800] : Colors.black87
            ),
          ),
          const Spacer(),
              if (isSelected) const Icon(Icons.check_circle, color: Colors.orange),
            ],
          ),
        );
      }
    
      Widget _buildPayButton(BuildContext context) {
        return Container(
          width: double.infinity,
          height: 56,
          decoration: BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                // Handle payment logic here
              },
              child: Center(
                child: Text(
                  "Bayar Sekarang",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        );
      }
    }