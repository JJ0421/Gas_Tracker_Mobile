import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class WebClient{

  Future<List> getMakes() async{
    const JsonCodec json = const JsonCodec();

    var response = await http.get(Uri.encodeFull('http://10.0.2.2:8080/api/getAll'),
    headers: {
      "Accept": "application/json"
    });
    
    
    List data = json.decode(response.body);
    //print(data);
    return data;
  }
  


}
