import 'package:flutter/foundation.dart';

const ipAddress = "10.130.56.28";

getApiBaseUrl() {
  // If debug mode is active, use the dev path.
  if (kDebugMode) {
    return "http://$ipAddress/duus/api";
  } else {
    return "http://$ipAddress/api";
  }
}

getBaseUrl() {
  // If debug mode is active, use the dev path.
  if (kDebugMode) {
    return "http://$ipAddress/joen";
  } else {
    return "http://$ipAddress";
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
