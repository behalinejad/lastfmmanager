import 'package:flutter/material.dart';
import 'package:last_fm_audio_management/models/top_albums.dart' as topAlbum;
import 'package:sizer/sizer.dart';



class TopAlbumsCustomListTile  extends StatelessWidget {
  final topAlbum.Album album ;
  const TopAlbumsCustomListTile ({Key? key,required this.album, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String imageUrl = '';
    if (album.image != null)    ///Using the large format of the image in case of existence
      imageUrl = album.image![2].text ?? '' ;

    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: InkWell(                         /// to act like a Button while tapping on
        onTap: ()  {
          Navigator.of(context).pushNamed('/album_tracks',arguments: album.mbid);
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
                       Text(album.name ?? '',overflow: TextOverflow.ellipsis,style: Theme.of(context).textTheme.bodyText1,),
                       SizedBox(height: 4.h,),
                       Column( // PlayCount Column of Album
                         children: [
                           Text('Play count:',style: Theme.of(context).textTheme.caption,),
                           SizedBox(height: 2.sp,),
                           Text(album.playcount.toString() ,overflow: TextOverflow.ellipsis,style: Theme.of(context).textTheme.bodyText1,),
                         ],
                       ),


                     ],
                   ),
                 ),
               ),
              Padding(
                padding:  EdgeInsets.only(right: 1.w),
                child: IconButton(icon: Icon(Icons.favorite_border,size: 30,),onPressed: (){},),
              )
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