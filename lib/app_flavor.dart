enum AppFlavor {
  staging('http://192.168.33.105:3001/api/'),
  production('https://631eb73e58a1c0fe9f562cec.mockapi.io/');

  final String baseUrl;
  const AppFlavor(this.baseUrl);
}
