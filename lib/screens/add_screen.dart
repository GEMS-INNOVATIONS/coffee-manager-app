import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../widgets/user_drawer.dart'; // Asegúrate de importar tu Drawer personalizado

class AddScreen extends StatefulWidget {
  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  bool _isCreating = true;
  DateTime _selectedDate = DateTime.now();
  String _selectedWorker = 'Trabajador';
  String _selectedShift = 'Mañana';
  String _quantity = '';
  final _formKey = GlobalKey<FormState>();

  final Map<DateTime, List<Map<String, String>>> _pesajes = {
    DateTime(2024, 8, 12): [
      {'Trabajador': 'Juan', 'Cantidad': '20 kg', 'Jornada': 'Mañana'},
      {'Trabajador': 'Ana', 'Cantidad': '15 kg', 'Jornada': 'Tarde'}
    ],
    DateTime(2024, 8, 13): [
      {'Trabajador': 'Pedro', 'Cantidad': '25 kg', 'Jornada': 'Medio día'}
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        title: Text(
          '',
          style: TextStyle(color: Colors.brown[800]), // Color del texto a blanco
        ),
        backgroundColor: Color.fromARGB(0, 109, 109, 109), // Fondo del AppBar
        iconTheme: IconThemeData(color: Colors.brown[800]),
      ),
      drawer: UserDrawer(), // Añade tu menú lateral
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _isCreating = true;
                      _selectedDate = DateTime.now();
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    primary: _isCreating ? Colors.brown[800] : Colors.white,
                    onPrimary: _isCreating ? Colors.white : Colors.brown[800],
                    elevation: _isCreating ? 5 : 0,
                  ),
                  child: Text('Crear'),
                ),
                SizedBox(width: 20),
                OutlinedButton(
                  onPressed: () {
                    setState(() {
                      _isCreating = false;
                      _selectedDate = DateTime.now();
                    });
                  },
                  style: OutlinedButton.styleFrom(
                    primary: !_isCreating ? Colors.brown[800] : Colors.grey,
                    side: BorderSide(color: Colors.brown[800]!),
                  ),
                  child: Text('Modificar/Eliminar'),
                ),
              ],
            ),
            SizedBox(height: 20),
            if (_isCreating) _buildCreationForm() else _buildModificationForm(),
          ],
        ),
      ),
    );
  }

  Widget _buildCreationForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('Formulario de creación'),
          SizedBox(height: 10),
          _buildDatePicker(),
          SizedBox(height: 10),
          _buildWorkerDropdown(),
          SizedBox(height: 10),
          _buildQuantityField(),
          SizedBox(height: 10),
          _buildShiftDropdown(),
          SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: _savePesaje,
              style: ElevatedButton.styleFrom(
                primary: Colors.brown[800],
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Guardar',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModificationForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('Modificar/Eliminar Pesaje'),
        SizedBox(height: 10),
        _buildDatePicker(),
        SizedBox(height: 10),
        if (_selectedDate != null &&
            _pesajes.containsKey(_stripTime(_selectedDate)))
          ..._buildPesajeList(),
        if (_selectedDate != null &&
            !_pesajes.containsKey(_stripTime(_selectedDate)))
          Center(child: Text('No hay pesajes para esta fecha.')),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.brown[800]),
        ),
        Spacer(),
        IconButton(
          icon: Icon(Icons.edit, color: Colors.brown[800]),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildDatePicker() {
    return ListTile(
      leading: Icon(Icons.calendar_today, color: Colors.brown[800]),
      title: Text(
        DateFormat('dd MMM yyyy').format(_selectedDate),
        style: TextStyle(color: Colors.brown[800]),
      ),
      onTap: _selectDate,
    );
  }

  Widget _buildWorkerDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedWorker,
      onChanged: (newValue) {
        setState(() {
          _selectedWorker = newValue!;
        });
      },
      items: ['Trabajador', 'Juan', 'Ana', 'Pedro']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      decoration: InputDecoration(
        labelText: 'Trabajador',
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  Widget _buildQuantityField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Cantidad',
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        prefixIcon: Icon(Icons.scale, color: Colors.brown[800]),
      ),
      keyboardType: TextInputType.number,
      onChanged: (value) {
        _quantity = value;
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor ingrese una cantidad';
        }
        return null;
      },
    );
  }

  Widget _buildShiftDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedShift,
      onChanged: (newValue) {
        setState(() {
          _selectedShift = newValue!;
        });
      },
      items: ['Mañana', 'Medio día', 'Tarde']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      decoration: InputDecoration(
        labelText: 'Jornada',
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  List<Widget> _buildPesajeList() {
    List<Widget> widgets = [];
    for (var pesaje in _pesajes[_stripTime(_selectedDate)]!) {
      widgets.add(
        ListTile(
          title: Text('${pesaje['Trabajador']} - ${pesaje['Cantidad']}',
              style: TextStyle(color: Colors.brown[800])),
          subtitle: Text('Jornada: ${pesaje['Jornada']}',
              style: TextStyle(color: Colors.brown[600])),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(Icons.edit, color: Colors.brown[800]),
                onPressed: () {
                  // Implementar la edición del pesaje aquí
                },
              ),
              IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  setState(() {
                    _pesajes[_stripTime(_selectedDate)]!.remove(pesaje);
                  });
                },
              ),
            ],
          ),
        ),
      );
    }
    return widgets;
  }

  Future<void> _selectDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
    );
    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  void _savePesaje() {
    if (_formKey.currentState!.validate()) {
      DateTime dateOnly = _stripTime(_selectedDate);
      if (!_pesajes.containsKey(dateOnly)) {
        _pesajes[dateOnly] = [];
      }
      _pesajes[dateOnly]!.add({
        'Trabajador': _selectedWorker,
        'Cantidad': '$_quantity kg',
        'Jornada': _selectedShift,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Pesaje guardado con éxito')),
      );
      setState(() {
        _selectedDate = DateTime.now();
        _selectedWorker = 'Trabajador';
        _quantity = '';
        _selectedShift = 'Mañana';
      });
    }
  }

  DateTime _stripTime(DateTime dateTime) {
    return DateTime(dateTime.year, dateTime.month, dateTime.day);
  }
}
