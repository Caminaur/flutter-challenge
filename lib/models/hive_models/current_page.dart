import 'package:hive/hive.dart';
part 'current_page.g.dart';

@HiveType(typeId: 10)
class CurrentPage extends HiveObject {
  CurrentPage({
    required this.page,
    required this.pageCount,
  });
  @HiveField(0)
  int page;
  @HiveField(1)
  int pageCount;
}
