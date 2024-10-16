// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:fakelab_records_bot/core/di/register_module.dart' as _i935;
import 'package:firebase_dart/core.dart' as _i1003;
import 'package:firebase_dart/database.dart' as _i493;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:logger/logger.dart' as _i974;
import 'package:teledart/teledart.dart' as _i2;
import 'package:teledart/telegram.dart' as _i284;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    gh.singleton<_i974.Logger>(() => registerModule.logger);
    gh.singleton<_i284.Telegram>(() => registerModule.telegram);
    await gh.singletonAsync<_i2.Event>(
      () => registerModule.event,
      preResolve: true,
    );
    gh.singleton<_i2.TeleDart>(() => registerModule.teledart);
    await gh.singletonAsync<_i1003.FirebaseApp>(
      () => registerModule.app,
      preResolve: true,
    );
    gh.singleton<_i493.FirebaseDatabase>(() => registerModule.database);
    return this;
  }
}

class _$RegisterModule extends _i935.RegisterModule {}
