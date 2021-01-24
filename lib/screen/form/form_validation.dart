class FormValidation {
  String validateProductName(String value) {
    if (value.isEmpty) {
      return "Product Name Required";
    }
    return null;
  }

  String validateProductPrice(String value) {
    if (value.isEmpty) {
      return "Product Price Required";
    }
    if (int.tryParse(value) == null) {
      return "Product Price must be integer";
    }
    return null;
  }
}
