  _getToken() async {
    var localStorage = await SharedPreferences.getInstance();
    String _token = localStorage.getString('token');
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer $_token"
    };

    return headers;
  }