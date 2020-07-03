abstract class Stove {
  String description;
  List<String> iconPaths;
}

/// Singleton class, describes a stove
class Stove1 extends Stove {
  static Stove1 _instance;

  /// Constructor
  Stove1._internal() {
    description = "Stove with 1 Burner";
    iconPaths = ['', ''];
  }

  static Stove1 getStove() {
    if (_instance == null) {
      _instance = Stove1._internal();
    }
    return _instance;
  }
}

/// Singleton class, describes a stove
class Stove2Horizontal extends Stove {
  static Stove2Horizontal _instance;

  /// Constructor
  Stove2Horizontal._internal() {
    description = "Horizontal Stove with 2 Burners";
    iconPaths = ['', ''];
  }

  static Stove2Horizontal getStove() {
    if (_instance == null) {
      _instance = Stove2Horizontal._internal();
    }
    return _instance;
  }
}

/// Singleton class, describes a stove
class Stove2Vertical extends Stove {
  static Stove2Vertical _instance;

  /// Constructor
  Stove2Vertical._internal() {
    ;
    description = "Vertical Stove with 2 Burners";
    iconPaths = ['', ''];
  }

  static Stove2Vertical getStove() {
    if (_instance == null) {
      _instance = Stove2Vertical._internal();
    }
    return _instance;
  }
}
