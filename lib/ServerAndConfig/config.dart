class Configuration {
  static const String apiServer = "http://localhost:8080/api/";
  // static const String apiServer = "http://metalbuildingthai-app.com:8080/MBTService/api/";
  static const String apiServerDev = "http://localhost:8080/api/";
  static const String apiServerDeploy =  "http://18.207.187.82:8080/MBTService/api/";

  static const String version = "v.1.1.0";

}
// v.1.0.1 APR192025 Debug when return to waiting it still approved
// v.1.1.0 SEP162025 new page user management and user authorization

//run withour cors 
////flutter run -d chrome --web-browser-flag "--disable-web-security"