class InsiderNotificationLoad {
  InsiderNotificationLoad({
    this.insDlJson,
    this.insDlExternal,
    this.insDlUrlScheme,
    this.source,
    this.insDlInternal,
  });

  final Map<String, dynamic>? insDlJson;
  final String? insDlExternal;
  final String? insDlUrlScheme;
  final String? source;
  final String? insDlInternal;
}