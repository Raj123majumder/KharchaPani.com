import 'package:expenses_app/models/transactions.dart';
import 'package:flutter/material.dart';

class pdfItem {
  final DateTime date = DateTime.now();
  final String title = "INVOICE";
  final String description = "Paisa Bachao!!Save ur Money💰💰💰";
  final String imageUrl = "assets/homePage.jpeg";
  final List<Transactions> recentTransactions;
  List<String> headers;
  final FontWeight headerFontWeight;
  final double headerfontSize;
  final FontWeight bodyFontWeight;
  final double bodyFontSize;

  pdfItem(this.recentTransactions, this.headers,
      {this.headerFontWeight = FontWeight.bold,
      this.headerfontSize = 20,
      this.bodyFontWeight = FontWeight.normal,
      this.bodyFontSize = 15});
}
