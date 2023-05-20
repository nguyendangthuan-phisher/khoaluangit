class ProductModel {
  int? id;
  String? word;
  String? pronunciation;
  String? meaning;
  String? translation;
  String? category;

  ProductModel({
    this.id,
    this.word,
    this.pronunciation,
    this.meaning,
    this.translation,
    this.category
  });

  factory ProductModel.fromJson(Map<String, dynamic> json){
    return ProductModel(
      id: json['id'],
      word: json['word'],
      pronunciation: json['pronunciation'],
      meaning: json['meaning'],
      translation: json['translation'],
      category: json['word'][0],
    );
  }
  ProductModel producFromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ,
      word: json['word'] as String,
      pronunciation: json['pronunciation'] as String,
      meaning: json['meaning'] as String,
      translation: json['translation'] as String,
      category: json['word'][0] as String,
    );
  }




}