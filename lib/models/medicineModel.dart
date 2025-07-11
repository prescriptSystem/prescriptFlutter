class MedicineModel {

  String id;
  String medicineName;
  String activeIngredient;
  String laboratory;
  String quantity;

  String? urlImage;

  MedicineModel({required this.id, required this.medicineName, required this.activeIngredient, required this.laboratory, required this.quantity});

  MedicineModel.fromMap(Map<String, dynamic> map): 
  id = map["id"],
  medicineName = map["medicineName"],
  activeIngredient = map["activeIngredient"],
  laboratory = map["laboratory"],
  quantity = map["quantity"],
  urlImage = map["urlImage"];

  Map<String, dynamic> toMap()
  {
    return 
    {
      "id": id,
      "medicineName": medicineName,
      "activeIngredient": activeIngredient,
      "laboratory": laboratory,
      "quantity": quantity,
      "urlImage": urlImage,
    };
  }


}