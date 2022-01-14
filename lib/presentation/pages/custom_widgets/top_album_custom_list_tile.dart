import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:last_fm_audio_management/core/themes/text_styles.dart';
import 'package:last_fm_audio_management/logic/bloc/stored_albums_bloc.dart';
import 'package:last_fm_audio_management/models/stored_albums.dart' ;
import 'package:last_fm_audio_management/models/top_albums.dart' as topAlbum;
import 'package:last_fm_audio_management/presentation/pages/custom_widgets/platform_alert_dialog.dart';
import 'package:sizer/sizer.dart';



///
/// The widget is a list tile that shows the detail of top albums .
/// which is used in  the Top album page .
///

class TopAlbumsCustomListTile  extends StatelessWidget {
  final topAlbum.Album album ;
  const TopAlbumsCustomListTile ({Key? key,required this.album, }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final storedAlbumBloc = BlocProvider.of<StoredAlbumsBloc>(context);

    String imageUrl = '';
    if (album.image != null)    ///Using the large format of the image in case of existence
      imageUrl = album.image![2].text ?? '' ;

    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: InkWell(                         /// to act like a Button while tapping on
        onTap: ()  {
          if (album.mbid != null)
          Navigator.of(context).pushNamed('/album_tracks',arguments: album.mbid);
          else
            PlatformAlertDialog(
              title: 'OOPs',
              content: 'The details are enough prepared by the Api to show the Tracks .    ',
              cancelActionText: '',
              defaultActionText: 'Ok',
              textDirection: TextDirection.ltr,

            ).show(context);
        },
        splashColor: Colors.black,
        child: Container(
          height: 15.h,
          color:Theme.of(context).cardColor ,
           child: Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [

               imageUrl != '' ? Image.network(imageUrl ,errorBuilder: (_,__,___){
                 return buildIcon( context);
               } )  : buildIcon( context),

               Padding(
                 padding:  EdgeInsets.only(top: 2.h,left: 1.w),
                 child: Container(
                   width: 35.w,

                   child: Column( // Detail of the album
                     mainAxisAlignment: MainAxisAlignment.start,
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Text(album.name ?? '',overflow: TextOverflow.ellipsis,style: AppTextStyles.tileBodyTextStyle,),
                       SizedBox(height: 4.h,),
                       Column( // PlayCount Column of Album
                         children: [
                           Text('Play count:',style: AppTextStyles.tileCaptionTextStyle,),
                           SizedBox(height: 2.sp,),
                           Text(album.playcount.toString() ,overflow: TextOverflow.ellipsis,style: AppTextStyles.tileBodyTextStyle,),
                         ],
                       ),


                     ],
                   ),
                 ),
               ),
              Padding(
                padding:  EdgeInsets.only(right: 1.w),
                child: BlocBuilder<StoredAlbumsBloc, StoredAlbumsState>(

                 /// the Icon that need to Colored by bloc state management in case of adding to Stored Albums

                    builder: (context, state) {
                       bool _isAlbumInStoredList  = false ;
                       try {
                         if (state is StoredAlbumsIsLoaded)
                           if (state.getStoredAlbums.albums != null) {
                             Album tmpAlbum = state.getStoredAlbums.albums!.firstWhere((element) =>
                             element.albumMbId == album.mbid);
                             if (tmpAlbum.albumMbId != null){
                               _isAlbumInStoredList = true ;
                             }
                           }
                       } catch (e) {

                       }
                       return IconButton(icon: Icon(_isAlbumInStoredList  ? Icons.favorite  :  Icons.favorite_border,size: 30,),onPressed: (){

                         if (!_isAlbumInStoredList) {
                           if (state is StoredAlbumsIsLoaded) {
                             try {
                               StoredAlbums storedAlbums = state.getStoredAlbums;

                               String imageUrl = ' ';
                               if (album.image != null)
                                 if (album.image![2].text != null && album.image![2].text != '')
                                   imageUrl = album.image![2].text! ;
                               Album tmpAlbum = Album(albumMbId: album.mbid,albumName: album.name,
                                                                artistName: album.artist?.name.toString() ?? '',artistMbId: album.artist?.mbid ?? '',imageUrl:imageUrl  );

                               if (tmpAlbum.albumMbId != null && tmpAlbum.albumName != null) {
                                 if (storedAlbums.albums != null)
                                   storedAlbums.albums?.add(tmpAlbum);
                                 else
                                   storedAlbums.albums = [tmpAlbum];
                                 storedAlbumBloc.add(
                                     FetchStoredAlbums(storedAlbums));
                               }else {
                                  PlatformAlertDialog(
                                     title: 'Error',
                                     content: 'Unfortunately, The Albums detail data is not complete enough to store .  ',
                                     cancelActionText: '',
                                     defaultActionText: 'Ok',
                                     textDirection: TextDirection.ltr,

                                 ).show(context);
                               }

                             } catch (e) {
                               PlatformAlertDialog(
                                 title: 'OOps',
                                 content: 'Something on the Process went Wrong   ',
                                 cancelActionText: '',
                                 defaultActionText: 'Ok',
                                 textDirection: TextDirection.ltr,

                               ).show(context);
                             }
                           }
                         }else {
                           try {
                             final storedAlbumBloc = BlocProvider.of<StoredAlbumsBloc>(context);
                             StoredAlbumsState _state = storedAlbumBloc.state ;
                             StoredAlbums storedAlbums =StoredAlbums();
                             if (_state is StoredAlbumsIsLoaded)
                               storedAlbums = _state.getStoredAlbums;
                             if (storedAlbums.albums != null) {
                               storedAlbums.albums?.removeWhere((element) =>
                               element.albumMbId ==  album.mbid);
                               storedAlbumBloc.add(FetchStoredAlbums(storedAlbums));

                             }

                           } catch (e) {
                             PlatformAlertDialog(
                               title: 'OOps',
                               content: 'Something on the Process went Wrong   ',
                               cancelActionText: '',
                               defaultActionText: 'Ok',
                               textDirection: TextDirection.ltr,

                             ).show(context);
                           }
                         }

                       });
                    }

                  ),
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
}

bool _isAlbumInStoredList (BuildContext context){

  return false ;
}