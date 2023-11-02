/*bool isDefinedAndNotNull(Object? this) {
  if (this.runtimeType == String) {
    return this != null && this != 'null' && this != 'undefined' && this != '';
  } else if (this.runtimeType == List) {
    return this != null &&
        this != 'null' &&
        this != 'undefined' &&
        (this as List).isNotEmpty;
  } else {
    return this != null && this != 'null' && this != 'undefined';
  }
}*/

extension NullCheckherExtension<T> on T {
  bool isDefined() {
    if (this.runtimeType == String) {
      return this != null &&
          this != 'null' &&
          this != 'undefined' &&
          this != '';
    } else if (this.runtimeType == List) {
      return this != null &&
          this != 'null' &&
          this != 'undefined' &&
          (this as List).isNotEmpty;
    } else {
      return this != null && this != 'null' && this != 'undefined';
    }
  }
}

bool mapIsNotEmpty(Map map_) {
  return map_ != null && map_.isNotEmpty;
}
