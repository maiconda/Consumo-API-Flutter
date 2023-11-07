class ProdutoModel {
  final String title;
  final String description;
  final double price;
  final String thumbnail;

  ProdutoModel({
    required this.title,
    required this.description,
    required this.price,
    required this.thumbnail
  });

  factory ProdutoModel.FromMap(Map<String, dynamic> map){
    return ProdutoModel(
        title: map['title'],
        description: map['description'],
        price: map['price'] * 1.00,
        thumbnail: map['thumbnail'],
    );
  }

}