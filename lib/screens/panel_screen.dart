import 'package:flutter/material.dart';
import '../widgets/user_drawer.dart';

class PanelScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '',
          style: TextStyle(color: Colors.brown[800]),
        ),
        backgroundColor:  Color.fromARGB(0, 109, 109, 109),
         iconTheme: IconThemeData(color: Colors.brown[800]),
      ),
      
      drawer: UserDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Resumen',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            _buildSummarySection(),
            SizedBox(height: 20),
            _buildCollectorReport(),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Acción de descargar informe
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.brown[800],
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Descargar Informe',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummarySection() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.brown[50],
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildBarPlaceholder(),
          SizedBox(height: 16),
          _buildPiePlaceholder(),
        ],
      ),
    );
  }

  Widget _buildBarPlaceholder() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Gráfico de Barras',
          style: TextStyle(
            color: Colors.brown[800],
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Container(
          height: 150,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.brown[300] ?? Colors.brown,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              'Gráfico de Barras (Placeholder)',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPiePlaceholder() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Gráfico Circular',
          style: TextStyle(
            color: Colors.brown[800],
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Container(
          height: 150,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.brown[500] ?? Colors.brown,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              'Gráfico Circular (Placeholder)',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCollectorReport() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.brown[50],
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Informe de recolectores',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.brown[800],
            ),
          ),
          SizedBox(height: 10),
          Table(
            border: TableBorder.all(color: Colors.grey),
            children: [
              TableRow(
                children: [
                  _buildTableCell('Nombre', isHeader: true),
                  _buildTableCell('Día', isHeader: true),
                  _buildTableCell('Max', isHeader: true),
                ],
              ),
              TableRow(
                children: [
                  _buildTableCell('Mauricio'),
                  _buildTableCell('5 KG'),
                  _buildTableCell('500 KG'),
                ],
              ),
              TableRow(
                children: [
                  _buildTableCell('Mauricio x2'),
                  _buildTableCell('Constant'),
                  _buildTableCell('New Log'),
                ],
              ),
              TableRow(
                children: [
                  _buildTableCell('Luisa'),
                  _buildTableCell('Constant'),
                  _buildTableCell('500 KG'),
                ],
              ),
              TableRow(
                children: [
                  _buildTableCell('Valentina'),
                  _buildTableCell('Constant'),
                  _buildTableCell('500 KG'),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTableCell(String content, {bool isHeader = false}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        content,
        style: TextStyle(
          fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
          fontSize: 16,
        ),
      ),
    );
  }
}
