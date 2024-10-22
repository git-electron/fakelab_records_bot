import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'di.config.dart';


final GetIt injector = GetIt.I;

@injectableInit
Future<GetIt> configureDependencies() async => injector.init();
