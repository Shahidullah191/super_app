class Images {
  const Images._();

  static String get placeholder => 'placeholder'.jpg;
}

extension on String {
  //String get svg => 'assets/images/$this.svg';
  String get png => 'assets/images/$this.png';
  String get jpg => 'assets/images/$this.jpg';
  //String get jpeg => 'assets/images/$this.jpeg';
}
