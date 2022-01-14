
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:last_fm_audio_management/logic/bloc/stored_albums_bloc.dart';
import 'package:last_fm_audio_management/logic/cubit/theme_cubit/theme_cubit.dart';
import 'package:last_fm_audio_management/logic/cubit/theme_cubit/theme_state.dart';
import 'package:last_fm_audio_management/main.dart';
import 'package:last_fm_audio_management/models/stored_albums.dart';
import 'package:last_fm_audio_management/presentation/pages/search_page.dart';
import 'package:mocktail/mocktail.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sizer/sizer.dart';


class MockThemeCubit extends MockCubit<ThemeState> implements ThemeCubit{}

class MockStoredAlbumsBloc extends MockBloc<StoredAlbumsEvent,StoredAlbumsState> implements StoredAlbumsBloc{}

class FakeThemeState extends Fake implements ThemeState {}
class FakeStoredAlbumState extends Fake implements StoredAlbumsState {}
class FakeStoredAlbumEvent extends Fake implements StoredAlbumsEvent {}


Future<void> main() async {

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getTemporaryDirectory(),
  );
  setUpAll(() {
    registerFallbackValue(FakeThemeState());
    registerFallbackValue(FakeStoredAlbumState());
    registerFallbackValue(FakeStoredAlbumEvent());
  });

  Widget makeTestableWidget({required Widget child, required ThemeCubit mockThemeCubit,required StoredAlbumsBloc mockStoredAlbumsBloc}) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeCubit>(
            create: (context) => MockThemeCubit()
        ),
        BlocProvider<StoredAlbumsBloc>(
          create: (context) => MockStoredAlbumsBloc(),
        ),
      ],
      child: Sizer(
        builder: (context, orientation, deviceType) {
          return MaterialApp(
              home:child,
          );
        }
      ),
    );
  }





  testWidgets(' Check loading the Main Screen   ', (WidgetTester tester) async {

    tester.binding.window.physicalSizeTestValue = Size(600, 800);
    MockThemeCubit _themeCubit = MockThemeCubit();
    _themeCubit.updateAppTheme(ThemeMode.dark);

    MockStoredAlbumsBloc _storedAlbumsBloc = MockStoredAlbumsBloc();


    await tester.pumpWidget( makeTestableWidget(child:MyApp(), mockThemeCubit: _themeCubit, mockStoredAlbumsBloc: _storedAlbumsBloc) );
    await tester.pump(Duration(seconds:4));

    expect(find.byKey(Key('searchArtistButton')), findsOneWidget);



  });


}