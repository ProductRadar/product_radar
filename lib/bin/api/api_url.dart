import 'package:flutter/foundation.dart';

const ipAddress = "10.130.56.28";

getApiBaseUrl() {
  // If debug mode is active, use the dev path.
  if (kDebugMode) {
    return "https://$ipAddress/duus/api";
  } else {
    return "https://$ipAddress/api";
  }
}

getBaseUrl() {
  // If debug mode is active, use the dev path.
  if (kDebugMode) {
    return "https://$ipAddress/joen";
  } else {
    return "https://$ipAddress";
  }
}

getApiBase() {
  // If debug mode is active, use the dev path.
  if (kDebugMode) {
    return "/duus/api";
  } else {
    return "/api";
  }
}
