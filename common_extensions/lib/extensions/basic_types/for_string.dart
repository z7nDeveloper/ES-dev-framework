

extension BasicStringExtension on String {
  String get capitalize => toUpperCase()[0] + substring(1);
}

class HideInfoConfiguration {
  final int maxLength;
  final String? suffix;

  HideInfoConfiguration({required this.maxLength, this.suffix});
}

extension HideStringExtension on String {
  String usingHasFormat() {
    return "have" + this[0].toUpperCase() + this.substring(1);
  }

  //#todo -> remove opcionals maxLength and suffix from hideInfo
  String hideInfo(
      {int? maxLength,
      String? suffix,
      HideInfoConfiguration? hideInfoConfiguration}) {
    hideInfoConfiguration ??=
        HideInfoConfiguration(maxLength: maxLength!, suffix: suffix);
    if (length <= hideInfoConfiguration.maxLength) {
      return this + (hideInfoConfiguration.suffix ?? "");
    }

    return "${substring(0, hideInfoConfiguration.maxLength - 2)}...${hideInfoConfiguration.suffix ?? ""}";
  }

  hideInfoAsFileName({required int maxLength}) {
    int fileDivision = lastIndexOf(".");

    String fileType =
        fileDivision == -1 ? "" : substring(fileDivision + 1, length);
    String file = fileDivision == -1 ? this : substring(0, fileDivision);

    return file.hideInfo(maxLength: maxLength, suffix: "." + fileType);
  }


}
