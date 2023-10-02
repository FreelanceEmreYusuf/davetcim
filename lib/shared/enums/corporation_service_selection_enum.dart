enum CorporationServiceSelectionEnum {
  customerSelectsCorporationPackage,
  customerSelectsExtraProduct,
  customerSelectsBoth
}

class CorporationServiceSelectionEnumConverter {
  static CorporationServiceSelectionEnum getEnumValue(int value) {
    return CorporationServiceSelectionEnum.values[value];
  }
}


