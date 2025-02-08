class MyCategory {
  String id;
  String imageName;
  String name;
  MyCategory({required this.id, required this.imageName, required this.name});
  static List<MyCategory> myCategories = [
    MyCategory(
      id: 'General',
      imageName: 'general_light',
      name: 'General',
    ),
    MyCategory(
      id: 'Buisiness',
      imageName: 'buisiness_light',
      name: 'Buisiness',
    ),
    MyCategory(
      id: 'Sports',
      imageName: 'sports_light',
      name: 'Sports',
    ),
    MyCategory(
      id: 'Entertainment',
      imageName: 'entertainment_light',
      name: 'Entertainment',
    ),
    MyCategory(
      id: 'Health',
      imageName: 'health_light',
      name: 'Health',
    ),
    MyCategory(
      id: 'Science',
      imageName: 'science_light',
      name: 'Science',
    ),
    MyCategory(
      id: 'Technology',
      imageName: 'technology_light',
      name: 'Technology',
    ),
  ];
}
