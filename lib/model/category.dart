class MyCategory {
  String id;
  String imageName;
  String name;
  MyCategory({required this.id, required this.imageName, required this.name});
  static List<MyCategory> myCategories = [
    MyCategory(
      id: 'General',
      imageName: 'general',
      name: 'General',
    ),
    MyCategory(
      id: 'Business',
      imageName: 'buisiness',
      name: 'Business',
    ),
    MyCategory(
      id: 'Sports',
      imageName: 'sports',
      name: 'Sports',
    ),
    MyCategory(
      id: 'Entertainment',
      imageName: 'entertainment',
      name: 'Entertainment',
    ),
    MyCategory(
      id: 'Health',
      imageName: 'health',
      name: 'Health',
    ),
    MyCategory(
      id: 'Science',
      imageName: 'science',
      name: 'Science',
    ),
    MyCategory(
      id: 'Technology',
      imageName: 'technology',
      name: 'Technology',
    ),
  ];
}
