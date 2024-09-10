import 'package:flutter/material.dart';

class AdministrarPagos extends StatefulWidget {
  @override
  _AdministrarPagosState createState() => _AdministrarPagosState();
}

class _AdministrarPagosState extends State<AdministrarPagos> {
  String? selectedFinca; // Finca seleccionada
  String? selectedWorker; // Trabajador seleccionado
  DateTimeRange? selectedDateRange; // Rango de fechas seleccionado
  final Map<String, double> trabajadores = {
    'Juan Pérez': 100.0,
    'María López': 120.0,
    'Carlos Gómez': 90.0,
  }; // Trabajadores con el café recogido
  final Map<String, double> pagos = {}; // Historial de pagos

  final TextEditingController _pagoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Administrar Pagos', style: TextStyle(color: Colors.brown[800])),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.brown[800]),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Filtro por finca
            _buildFincaFilter(),
            SizedBox(height: 16),
            // Filtro por tiempo
            _buildDateFilter(context),
            SizedBox(height: 16),
            // Seleccionar trabajador
            _buildWorkerFilter(),
            SizedBox(height: 16),
            // Listado de trabajadores y su café recogido
            Expanded(child: _buildWorkerList()),
            SizedBox(height: 16),
            // Input para el valor de pago
            _buildPaymentInput(),
            SizedBox(height: 16),
            // Botón de pagar
            _buildPaymentButton(),
          ],
        ),
      ),
    );
  }

  // Filtro de finca
  Widget _buildFincaFilter() {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: 'Seleccione la finca',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
      value: selectedFinca,
      items: <String>['Finca A', 'Finca B', 'Finca C']
          .map((String finca) => DropdownMenuItem<String>(
                value: finca,
                child: Text(finca),
              ))
          .toList(),
      onChanged: (value) {
        setState(() {
          selectedFinca = value;
        });
      },
    );
  }

Widget _buildDateFilter(BuildContext context) {
  return GestureDetector(
    onTap: () async {
      DateTimeRange? range = await showDateRangePicker(
        context: context,
        firstDate: DateTime(2021),
        lastDate: DateTime.now(),
        initialDateRange: selectedDateRange,
      );
      if (range != null) {
        setState(() {
          selectedDateRange = range;
        });
      }
    },
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.brown[400]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded( // Usar Expanded para asegurarse que el texto no se salga
            child: Text(
              selectedDateRange == null
                  ? 'Seleccione el rango de tiempo'
                  : '${selectedDateRange!.start.toLocal()} - ${selectedDateRange!.end.toLocal()}',
              style: TextStyle(fontSize: 16),
              overflow: TextOverflow.ellipsis, // Trunca el texto si es muy largo
            ),
          ),
          Icon(Icons.calendar_today, color: Colors.brown[800]),
        ],
      ),
    ),
  );
}

  // Filtro de trabajadores
  Widget _buildWorkerFilter() {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: 'Seleccione un trabajador',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
      value: selectedWorker,
      items: trabajadores.keys
          .map((String worker) => DropdownMenuItem<String>(
                value: worker,
                child: Text(worker),
              ))
          .toList(),
      onChanged: (value) {
        setState(() {
          selectedWorker = value;
        });
      },
    );
  }

  // Listado de trabajadores (solo para mostrar café recogido)
  Widget _buildWorkerList() {
    return ListView.builder(
      itemCount: trabajadores.length,
      itemBuilder: (context, index) {
        String trabajador = trabajadores.keys.elementAt(index);
        double cafeRecogido = trabajadores[trabajador]!;
        bool pagoRealizado = pagos.containsKey(trabajador);

        return Card(
          margin: EdgeInsets.symmetric(vertical: 8.0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: ListTile(
            leading: Icon(Icons.person, color: Colors.brown[800]),
            title: Text(trabajador),
            subtitle: Text('Café recogido: $cafeRecogido kg'),
            trailing: pagoRealizado
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.brown[800]),
                        onPressed: () {
                          _editPayment(trabajador);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red[800]),
                        onPressed: () {
                          setState(() {
                            pagos.remove(trabajador);
                          });
                        },
                      ),
                    ],
                  )
                : null,
          ),
        );
      },
    );
  }

  // Input de pago
  Widget _buildPaymentInput() {
    return TextFormField(
      controller: _pagoController,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'Monto a pagar',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
        prefixIcon: Icon(Icons.attach_money, color: Colors.brown[800]),
      ),
    );
  }

  // Botón de pagar
  Widget _buildPaymentButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          if (selectedWorker == null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Seleccione un trabajador para realizar el pago.'),
            ));
            return;
          }
          double monto = double.tryParse(_pagoController.text) ?? 0;
          setState(() {
            pagos[selectedWorker!] = monto;
          });

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Pago registrado para $selectedWorker'),
          ));
        },
        style: ElevatedButton.styleFrom(
          primary: Colors.brown[800],
          padding: EdgeInsets.symmetric(vertical: 16.0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Text('Pagar', style: TextStyle(color: Colors.white)),
      ),
    );
  }

  // Método para editar pagos
  void _editPayment(String trabajador) {
    _pagoController.text = pagos[trabajador].toString();
  }
}
