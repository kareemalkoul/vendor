class Vendors {
  static String TOKEN;
  static String BASEURL = "https://floating-badlands-10743.herokuapp.com";
  static String AUTH = "https://floating-badlands-10743.herokuapp.com/auth";
  static String API = "https://floating-badlands-10743.herokuapp.com/api";
  static const String GET_ALL_VENDOR =
      "https://floating-badlands-10743.herokuapp.com/api/vendors/all";
  static const String CREATE_VENDOR =
      "https://floating-badlands-10743.herokuapp.com/api/Vendors/new";
  static const String NEW_PRODUCT = "";
  static const String GET_ALL_OFFERS = "";
  static const String ADD_OFFERS = "";
  static const String LOGIN =
      "https://floating-badlands-10743.herokuapp.com/auth/login";
  static const String REGISTERATION =
      "https://floating-badlands-10743.herokuapp.com/auth/register";
  static const String EMAIL_VALDITION_CODE = "";
  static const String FORGET_PASSWORD = "";
  static const String GET_DISCOUNT = "";
  static const String ADD_DISCOUNT =
      "https://floating-badlands-10743.herokuapp.com/api/discounts/add_discount";
  static const String EDITE_DISCOUNT = "";
  static const String ADD_PHONE =
      "https://floating-badlands-10743.herokuapp.com/api/phones/new";

  //TODO if token null get from data base
  static get getToken => TOKEN;
}
