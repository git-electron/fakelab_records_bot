// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:fakelab_records_bot/core/di/register_module.dart' as _i935;
import 'package:fakelab_records_bot/core/i18n/app_localization.g.dart' as _i74;
import 'package:fakelab_records_bot/feature/on_command/domain/on_command_listener.dart'
    as _i947;
import 'package:fakelab_records_bot/feature/on_command/domain/on_command_listener_impl.dart'
    as _i599;
import 'package:fakelab_records_bot/feature/on_command/feature/on_start_command/data/repository/user_repository.dart'
    as _i171;
import 'package:fakelab_records_bot/feature/on_command/feature/on_start_command/data/repository/user_repository_impl.dart'
    as _i378;
import 'package:fakelab_records_bot/feature/on_command/feature/on_start_command/domain/on_start_command.dart'
    as _i734;
import 'package:fakelab_records_bot/feature/on_command/feature/on_start_command/domain/on_start_command_impl.dart'
    as _i485;
import 'package:fakelab_records_bot/feature/on_inline/domain/on_inline_listener.dart'
    as _i648;
import 'package:fakelab_records_bot/feature/on_inline/domain/on_inline_listener_impl.dart'
    as _i714;
import 'package:fakelab_records_bot/feature/on_message/domain/on_message_listener.dart'
    as _i73;
import 'package:fakelab_records_bot/feature/on_message/domain/on_message_listener_impl.dart'
    as _i330;
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
    gh.singleton<_i74.Translations>(() => registerModule.t);
    gh.singleton<_i171.UserRepository>(() => _i378.UserRepositoryImpl(
          logger: gh<_i974.Logger>(),
          database: gh<_i493.FirebaseDatabase>(),
        ));
    gh.singleton<_i947.OnCommandListener>(
        () => _i599.OnCommandListenerImpl(logger: gh<_i974.Logger>()));
    gh.singleton<_i73.OnMessageListener>(
        () => _i330.OnMessageListenerImpl(logger: gh<_i974.Logger>()));
    gh.singleton<_i648.OnInlineListener>(
        () => _i714.OnInlineListenerImpl(logger: gh<_i974.Logger>()));
    gh.singleton<_i734.OnStartCommand>(() => _i485.OnStartCommandImpl(
          logger: gh<_i974.Logger>(),
          teledart: gh<_i2.TeleDart>(),
        ));
    return this;
  }
}

class _$RegisterModule extends _i935.RegisterModule {}
