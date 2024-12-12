import 'package:baseflutter/data/models/base_model.dart';
import 'package:baseflutter/domain/entities/base_entity.dart';

abstract class BaseMapper<T extends BaseModel, R extends BaseEntity> {
  R map(T data);

  R? nullableMap(T? entity) {
    return entity != null ? map(entity) : null;
  }

  List<R> mapCollection(List<T> dataCollection) {
    return dataCollection.map(map).toList();
  }

  List<R>? mullAbleMapCollection(List<T>? dataCollection) {
    return dataCollection?.map(map).toList();
  }
}
