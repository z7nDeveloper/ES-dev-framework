




import 'argument_caller.dart';

class ListArgumentCaller extends ArgumentCaller {


  final int page;
  final String search;
  final String? routePathAppending;


  ListArgumentCaller({this.page=0, this.search="", this.routePathAppending,   });
}