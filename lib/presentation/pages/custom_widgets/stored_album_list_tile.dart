import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:last_fm_audio_management/core/themes/text_styles.dart';
import 'package:last_fm_audio_management/logic/bloc/stored_albums_bloc.dart';
import 'package:last_fm_audio_management/models/stored_albums.dart';
import 'package:last_fm_audio_management/presentation/pages/custom_widgets/platform_alert_dialog.dart';
import 'package:sizer/sizer.dart';


///
/// The widget is a list tile that used in the Main Screen
/// that contains detail about the albums which users have stored
/// in the favorite list .
///
///


class StoredAlbumsCustomListTile  extends StatelessWidget {
  final Album album ;
  const StoredAlbumsCustomListTile ({Key? key,required this.album, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: InkWell(                         /// to act like a Button while tapping on
        onTap: () async {
          try {
            Navigator.of(context).pushNamed('/album_tracks',arguments: album.albumMbId);

          } catch (e) {

          }
        },
        splashColor: Colors.black,
        child: Container(
          height: 13.h,
          color:Theme.of(context).cardColor ,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               Image.network(album.imageUrl ?? '' ,errorBuilder: (_,__,___){

                 return buildIcon( context);
              } )  ,
              Padding(
                padding:  EdgeInsets.only(top: 2.sp, left: 5.sp,bottom: 2.sp,right: 5.sp),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        width: 30.w ,
                        child: Text(album.albumName ?? ' ',overflow: TextOverflow.ellipsis,style: AppTextStyles.tileBodyTextStyle,)),

                    SizedBox(height: 2.h,),
                    Container(
                      width: 32.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: [
                          Container(
                            width: 30.w,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Artist Name:',style: AppTextStyles.tileCaptionTextStyle,),
                                SizedBox(height: 2.sp,),
                                Container(
                                    width: 50.w,
                                    child: Text(album.artistName ?? ' ',overflow: TextOverflow.ellipsis,style: AppTextStyles.tileBodyTextStyle,))
                              ],

                            ),
                          ),



                        ],
                      ),
                    ),

                  ],
                ),
              ),
              Padding(
                padding:  EdgeInsets.only(right: 3.w),
                child: IconButton(icon:Icon(Icons.delete),onPressed: () async {

                      final _alertDialogResponse = await PlatformAlertDialog(
                            title: 'Warning',
                            content: 'Would you like to delete the album from the Favorite List ? ',
                            cancelActionText: 'NO',
                            defaultActionText: 'Yes',
                            textDirection: TextDirection.ltr,
                      ).show(context);
                   if (_alertDialogResponse ?? false){
                     try {
                       final storedAlbumBloc = BlocProvider.of<StoredAlbumsBloc>(context);
                       StoredAlbumsState _state = storedAlbumBloc.state ;
                       StoredAlbums storedAlbums =StoredAlbums();
                       if (_state is StoredAlbumsIsLoaded)
                         storedAlbums = _state.getStoredAlbums;
                       if (storedAlbums.albums != null) {
                         storedAlbums.albums?.removeWhere((element) =>
                         element.albumMbId == album.albumMbId);
                         storedAlbumBloc.add(FetchStoredAlbums(storedAlbums));

                       }

                     } catch (e) {

                     }
                   }

                },),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget buildIcon(BuildContext context) => Container(
      width:30.w ,
      child: Row(
        //crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.music_note ,size:40.sp,color: Theme.of(context).accentColor,),
        ],
      ));

  /*showAlertDialog(BuildContext context) {


    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed:  () {
        Navigator.pop(context);
      },
    );
    Widget confirmButton = TextButton(
      child: Text("yes"),
      onPressed:  () {

        try {
          final storedAlbumBloc = BlocProvider.of<StoredAlbumsBloc>(context);
           StoredAlbumsState _state = storedAlbumBloc.state ;
          StoredAlbums storedAlbums =StoredAlbums();
           if (_state is StoredAlbumsIsLoaded)
             storedAlbums = _state.getStoredAlbums;
          if (storedAlbums.albums != null) {
            storedAlbums.albums?.removeWhere((element) =>
            element.albumMbId == album.albumMbId);
            storedAlbumBloc.add(FetchStoredAlbums(storedAlbums));
            Navigator.pop(context);
          }

        } catch (e) {
          print(e);
        }
      },
    );


    AlertDialog alert = AlertDialog(
      title: Text("Warning"),
      content: Text("Would you like to delete the album from the Favorite List "),
      actions: [
        cancelButton,
        confirmButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }*/

}