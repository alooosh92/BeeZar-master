class ServerConfig {
  //DomainNameServer
  static const DNS = 'https://beezar.arg-tr.com';
  //auth
  static const login = '/api/login';
  static const logout = '/api/logout';
  static const signup = '/api/signup';

  //Categories
  static const category = '/api/get_category';
  static const sub_categ = '/api/get_sub_category/';
  static const SearchCategory = '/api/search_main_category';
  static const SearchSubCategory = '/api/search_sub_category';
  static const GetProducts = '/api/show_item/';
  static const Search = '/api/search/';
  static const AddItem = '/api/create_item';
  static const updateUser = '/api/user';
  static const GetMyItems = '/api/getMyItems';
  static const DeleteItem = '/api/delete_item';
  static const GetAllProducts = '/api/get_all_items';
}
