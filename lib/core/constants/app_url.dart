class AppUrl {
  AppUrl._();

  // base url
  static const String baseUrl = 'https://bb3.ashwinsrivastava.com/api/v1/';
  static const String imageBaseUrl =
      'https://wsrv.nl/?url=https://eu2.contabostorage.com/eabb361130e04e0c98e8b88a22721601:bb2/';

  // receiveTimeout
  static const Duration receiveTimeout = Duration(minutes: 2);

  // connectTimeout
  static const Duration connectionTimeout = Duration(minutes: 2);

  static const String Product = 'store/product-search';
  // ?q=&page=1
}
