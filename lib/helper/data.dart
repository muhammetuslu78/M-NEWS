import '../model/category_model.dart';

List<CategoryModel>? getCategories() {
  List<CategoryModel>? categories = [];

  CategoryModel categoryModel1 = CategoryModel(
      imgUrl:
          'https://images.unsplash.com/39/lIZrwvbeRuuzqOoWJUEn_Photoaday_CSD (1 of 1)-5.jpg?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8YnVzaW5lc3N8ZW58MHx8MHx8&auto=format&fit=crop&w=200&q=60',
      categoryTitle: 'Business');
  categories.add(categoryModel1);

  CategoryModel categoryModel2 = CategoryModel(
      imgUrl:
          'https://images.unsplash.com/photo-1603190287605-e6ade32fa852?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8ZW50ZXJ0YWlubWVudHxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=200&q=60',
      categoryTitle: 'Entertainment');
  categories.add(categoryModel2);

  CategoryModel categoryModel3 = CategoryModel(
      imgUrl:
          'https://images.unsplash.com/photo-1518770660439-4636190af475?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8dGVjaG5vbG9neXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=200&q=60',
      categoryTitle: 'Technology');
  categories.add(categoryModel3);

  CategoryModel categoryModel4 = CategoryModel(
      imgUrl:
          'https://images.unsplash.com/39/lIZrwvbeRuuzqOoWJUEn_Photoaday_CSD (1 of 1)-5.jpg?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8YnVzaW5lc3N8ZW58MHx8MHx8&auto=format&fit=crop&w=200&q=60',
      categoryTitle: 'Business');
  categories.add(categoryModel4);

  CategoryModel categoryModel5 = CategoryModel(
      imgUrl:
          'https://images.unsplash.com/photo-1564325724739-bae0bd08762c?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8c2NpZW5jZXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=200&q=60',
      categoryTitle: 'Science');
  categories.add(categoryModel5);

  CategoryModel categoryModel6 = CategoryModel(
      imgUrl:
          'https://images.unsplash.com/photo-1432821596592-e2c18b78144f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8Z2VuZXJhbHxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=200&q=60',
      categoryTitle: 'General');
  categories.add(categoryModel6);

  CategoryModel categoryModel7 = CategoryModel(
      imgUrl:
          'https://images.unsplash.com/photo-1505751172876-fa1923c5c528?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTB8fGhlYWx0aHxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=200&q=60',
      categoryTitle: 'Health');
  categories.add(categoryModel7);

  CategoryModel categoryModel8 = CategoryModel(
      imgUrl:
          'https://images.unsplash.com/photo-1477332552946-cfb384aeaf1c?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8aGVhbHRofGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=200&q=60',
      categoryTitle: 'Sports');
  categories.add(categoryModel8);

  return categories;
}
