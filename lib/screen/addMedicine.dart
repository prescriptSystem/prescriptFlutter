import 'package:flutter/material.dart';
import 'package:prescript/common/mySnackBar.dart';
import 'package:prescript/controller/medicineService.dart';
import 'package:prescript/models/medicineModel.dart';
import 'package:uuid/uuid.dart';

class AddMedicine extends StatefulWidget {
  final MedicineModel? medicine;
  AddMedicine({super.key, this.medicine});

  @override
  State<AddMedicine> createState() => _AddMedicineState();
}

class _AddMedicineState extends State<AddMedicine> {
  final _medicineNameController = TextEditingController();
  final _activeIngredientController = TextEditingController();
  final _laboratoryController = TextEditingController();
  final _quantityController = TextEditingController();

  bool isLoading = false;

  MedicineService _medicineService = MedicineService();

  @override
  void initState() {
    if (widget.medicine != null) {
      _medicineNameController.text = widget.medicine!.medicineName;
      _activeIngredientController.text = widget.medicine!.activeIngredient;
      _laboratoryController.text = widget.medicine!.laboratory;
      _quantityController.text = widget.medicine!.quantity;
    }
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              "Adição de Medicamento",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.pink,
          ),
          /*floatingActionButton: FloatingActionButton(
            onPressed: () {
              clickBtnAdd();
            },
            child: Icon(Icons.add),
          ),*/
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 250,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                              onPressed: () {},
                              child: Text(
                                "Enviar Foto",
                                style: TextStyle(color: Colors.pink),
                              )),
                          ElevatedButton(
                              onPressed: () {},
                              child: Text(
                                "Tirar Foto",
                                style: TextStyle(color: Colors.pink),
                              )),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: _medicineNameController,
                      decoration: const InputDecoration(
                        labelText: 'Nome do Medicamento',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.medication),
                      ),
                      //validator: validateEmail,
                    ),
                    const SizedBox(height: 20),
                    //Text(widget.medicine.medicineName),
                    //Divider(),
                    TextFormField(
                      controller: _activeIngredientController,
                      decoration: const InputDecoration(
                        labelText: 'Princípio Ativo',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.receipt),
                      ),
                      //validator: validateEmail,
                    ),
                    const SizedBox(height: 20),
                    //Text(widget.medicine.activeIngredient),
                    //Divider(),
                    TextFormField(
                      controller: _laboratoryController,
                      decoration: const InputDecoration(
                        labelText: 'Laboratório',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.factory_sharp),
                      ),
                      //validator: validateEmail,
                    ),
                    const SizedBox(height: 20),
                    //Text(widget.medicine.laboratory),
                    //Divider(),
                    TextFormField(
                      controller: _quantityController,
                      decoration: const InputDecoration(
                        labelText: 'Quantidade',
                        border: OutlineInputBorder(),
                        prefixIcon:
                            Icon(Icons.production_quantity_limits_outlined),
                      ),
                      //validator: validateEmail,
                    ),
                    const SizedBox(height: 40),
                    ElevatedButton(
                      onPressed: () {
                        // Aqui você pode adicionar a lógica de login
                        clickBtnAdd();
                      },
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                          backgroundColor: Colors.pink

                          //primary: Colors.blue,
                          ),
                      child: (isLoading)
                          ? SizedBox(
                              height: 16,
                              width: 16,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                          : Text(
                              (widget.medicine != null)
                                  ? 'Editar'
                                  : "Cadastrar",
                              style: TextStyle(color: Colors.white),
                            ),
                    ),
                    //Text(widget.medicine.quantity),
                    //Divider(),
                  ]),
            ),
          ),
        ),
      ),
    );
  }

  clickBtnAdd() {
    setState(() {
      isLoading = true;
    });

    String medicineName = _medicineNameController.text;
    String activeIngredient = _activeIngredientController.text;
    String laboratory = _laboratoryController.text;
    String quantity = _quantityController.text;

    MedicineModel medicineModel = MedicineModel(
        id: Uuid().v1(),
        medicineName: medicineName,
        activeIngredient: activeIngredient,
        laboratory: laboratory,
        quantity: quantity);

    if (widget.medicine != null) {
      medicineModel.id = widget.medicine!.id;
    }

    _medicineService.addMedicine(medicineModel).then((String? message) {
      if (message != null) {
        showSnackBar(context: context, text: message);
      } else {
        showSnackBar(
            context: context,
            text: widget.medicine != null
                ? "Medicamento editado com sucesso!"
                : "Medicamento salvo com sucesso!",
            isErro: false);
        _medicineNameController.clear();
        _activeIngredientController.clear();
        _laboratoryController.clear();
        _quantityController.clear();
        Navigator.of(context).pop();
        setState(() {
          isLoading = false;
        });
      }
    });
    //if (_formKey.currentState!.validate()) {
    /*_medicineService
        .addMedicine(medicineModel)
        .loginUser(
            email: _emailController.text, password: _passwordController.text)
        .then((String? message) {
      if (message != null) {
        showSnackBar(context: context, text: message);
      } else {
        _emailController.clear();
        _passwordController.clear();*/

    /*Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProfileScreen()),
          );*/
  }
}
