import 'package:http/http.dart' as http;

String  httpErrorHandling (http.Response resposnse){
  final statusCode = resposnse.statusCode;
  final responsePhrase = resposnse.reasonPhrase;
  final String erroMessgae= 'Request failed \n $statusCode \nReason :$responsePhrase';

  return erroMessgae;
}