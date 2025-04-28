


import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

extension BlocExtension on Bloc {
}

BlocProvider<T> createProvider<T extends Bloc>(T bloc) {
  return BlocProvider(create: (BuildContext context) => bloc);
}