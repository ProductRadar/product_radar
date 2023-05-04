
import 'package:flutter/foundation.dart';

getApiBaseUrl() {
  // If debug mode is active, use the dev path.
  if (kDebugMode) {
    return "http://10.130.56.28/joen/api";
  } else {
    return "http://10.130.56.28/api";
  }
}

getBaseUrl(){
  // If debug mode is active, use the dev path.
  if (kDebugMode) {
    return "http://10.130.56.28/joen";
  } else {
    return "http://10.130.56.28";
  }
}
