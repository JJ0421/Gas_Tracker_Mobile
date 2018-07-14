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
    return data;
  }


  Future<String> getVehicleInfo(String data_key) async{
    data_key = data_key.replaceAll('/', '^');
    print(data_key);
    var response = await http.get(Uri.encodeFull('http://10.0.2.2:8080/api/findCar/'+data_key),
    headers: {
      "Accept": "application/json"
    });
    var vehicle = json.decode(response.body);
    return vehicle['cmb'].toString();
  }  


}
