import 'package:dio/dio.dart';
import 'package:e_commerce_frontend/scr/data/common/server_api.dart';
import 'package:e_commerce_frontend/scr/data/models/request/cart_item_request_model/cart_item_request_model.dart';
import 'package:e_commerce_frontend/scr/data/models/response/cart_response_model/cart_item_pagination_response_model.dart';
import 'package:e_commerce_frontend/scr/data/models/response/cart_response_model/cart_item_response_model.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'cart_datasource.g.dart';

@RestApi(baseUrl: API.BASE_URL)
abstract class CartDatasource {
  factory CartDatasource(Dio dio, {String baseUrl}) = _CartDatasource;

  @GET(API.CART)
  Future<CartItemPaginationResponseModel> getListCartItem();

  @GET("{path}")
  Future<CartItemPaginationResponseModel> getListCartItemByUrl(
    @Path('path') String path,
  );

  @POST(API.CART)
  Future<CartItemResponseModel> addProductToCart(
    @Body() CartItemRequestModel cartItemRequestModel,
  );

  @PATCH("${API.CART}{id}/")
  Future<CartItemResponseModel> updateCartItem(
    @Path('id') int id,
    @Body() CartItemRequestModel cartItemRequestModel,
  );
}
