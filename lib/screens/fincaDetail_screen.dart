import 'package:flutter/material.dart';

class FincaDetail extends StatefulWidget {
  @override
  _FincaDetailState createState() => _FincaDetailState();
}

class _FincaDetailState extends State<FincaDetail> {
  String? selectedAgricultureType;
  String? selectedCountry;
  String? selectedCertification;

  // Lista para almacenar los lotes
  List<Map<String, String>> lotes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles de la Finca', style: TextStyle(color: Colors.brown[800])),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.brown[800]),
      ),
       body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Nombre'),
              ),
              SizedBox(height: 16),
              Text('Certificaciones'),
              DropdownButton<String>(
                isExpanded: true,
                value: selectedCertification,
                hint: Text('Seleccione certificación'),
                items: <String>['Orgánica', 'Fair Trade', 'Rainforest Alliance']
                    .map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    selectedCertification = newValue;
                  });
                },
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(labelText: 'País'),
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(labelText: 'Altura (m)'),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(labelText: 'Longitud'),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(labelText: 'Latitud'),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(labelText: 'Departamento'),
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(labelText: 'Municipio'),
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(labelText: 'Hectáreas'),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.brown[800], // Botón café oscuro
                  onPrimary: Colors.white,
                ),
                onPressed: () {
                  _showAddLoteModal(context);
                },
                child: Text('Agregar Lote'),
              ),
              SizedBox(height: 16),
              Container(
                height: 150, // Espacio para mostrar el listado de lotes
                color: Colors.grey[200],
                child: _buildLotesList(), // Lista de lotes
              ),
              SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.brown[800], // Botón café oscuro
                  onPrimary: Colors.white,
                ),
                onPressed: () {
                  // Acción para enviar
                },
                child: Text('Enviar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Construir la lista de lotes
  Widget _buildLotesList() {
    if (lotes.isEmpty) {
      return Center(
        child: Text('No hay lotes agregados'),
      );
    }
    return ListView.builder(
      itemCount: lotes.length,
      itemBuilder: (context, index) {
        final lote = lotes[index];
        return ListTile(
          title: Text('Lote: ${lote['nombre']}'),
          subtitle: Text(
              'Árboles: ${lote['cantidad_arboles']}, Hectáreas: ${lote['hectareas']}, Variedad: ${lote['variedad']}'),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              setState(() {
                lotes.removeAt(index);
              });
            },
          ),
        );
      },
    );
  }

  // Modal para agregar un lote
  void _showAddLoteModal(BuildContext context) {
    String nombre = '';
    String cantidadArboles = '';
    String hectareas = '';
    String variedad = '';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Agregar Lote'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Nombre del Lote'),
                onChanged: (value) {
                  nombre = value;
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Cantidad de árboles'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  cantidadArboles = value;
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Hectáreas'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  hectareas = value;
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Variedad de café'),
                onChanged: (value) {
                  variedad = value;
                },
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                // Agregar lote a la lista
                if (nombre.isNotEmpty &&
                    cantidadArboles.isNotEmpty &&
                    hectareas.isNotEmpty &&
                    variedad.isNotEmpty) {
                  setState(() {
                    lotes.add({
                      'nombre': nombre,
                      'cantidad_arboles': cantidadArboles,
                      'hectareas': hectareas,
                      'variedad': variedad,
                    });
                  });
                  Navigator.of(context).pop();
                }
              },
              child: Text('Guardar'),
              style: ElevatedButton.styleFrom(
                primary: Colors.brown[800],
                onPrimary: Colors.white,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
              style: ElevatedButton.styleFrom(
                primary: Colors.red[800],
                onPrimary: Colors.white,
              ),
            ),
          ],
        );
      },
    );
  }
}
