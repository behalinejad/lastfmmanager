
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:last_fm_audio_management/main.dart';
import 'package:last_fm_audio_management/models/artist_info.dart' as model ;
import 'package:last_fm_audio_management/presentation/pages/custom_widgets/search_page_custom_list_tile.dart';

void main (){

  testWidgets('   ', (WidgetTester tester) async {

    //final searchArtistTextField = find.byKey(ValueKey('searchArtistTextField'));
    /*tester.binding.window.physicalSizeTestValue = Size(42,42);


    addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
    final searchArtistButton = find.byKey(ValueKey('searchArtistButton'));
    model.Artist artist = model.Artist(name: 'Artist Name',url: 'Url test',mbid: 'mbIdTest',listeners: '123', image: [], streamable: '');
 */
    await tester.pumpWidget( MyApp() );
    await tester.pump();

    expect(find.text('Artist Name'), findsOneWidget);


  });
}