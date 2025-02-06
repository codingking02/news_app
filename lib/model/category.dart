class MyCategory {
  String id;
  String imageName;
  MyCategory({required this.id, required this.imageName});
  static List<MyCategory> myCategories = [
    MyCategory(id: '0', imageName: 'general_light'),
    MyCategory(id: '1', imageName: 'buisiness_light'),
    MyCategory(id: '2', imageName: 'sports_light'),
    MyCategory(id: '3', imageName: 'entertainment_light'),
    MyCategory(id: '4', imageName: 'health_light'),
    MyCategory(id: '5', imageName: 'science_light'),
    MyCategory(id: '6', imageName: 'technology_light'),
  ];
}
