import 'package:baseflutter/data/models/user_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'user_remote_data_source.g.dart';

@RestApi(baseUrl: "https://api.example.com/")
abstract class UserRemoteDataSource {
  factory UserRemoteDataSource(Dio dio, {String baseUrl}) = _UserRemoteDataSource;

  @GET("/user")
  Future<UserModel> getUser();
}
