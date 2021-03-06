import 'package:flutter/material.dart';
import 'package:last_fm_audio_management/core/themes/text_styles.dart';
import 'package:last_fm_audio_management/models/album_tracks.dart';
import 'package:sizer/sizer.dart';


///
/// ListTile That has been used in Album Tracks Page
/// and contains Tracks Detail
///


class AlbumTracksCustomListTile  extends StatelessWidget {
  final Track track ;
  final AlbumTracks albumTracks ;
  const AlbumTracksCustomListTile ({Key? key,required this.track,required this.albumTracks }) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return Padding(
      padding:  EdgeInsets.only(left: 10.sp,right: 10.sp),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: InkWell(                         /// to act like a Button while tapping on
          splashColor: Colors.black,
          child: Container(
            height: 8.h,
            color:Theme.of(context).cardColor ,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Padding(
                  padding:  EdgeInsets.only(top: 2.h,left: 1.w,),
                  child: Container(
                    width: 35.w,

                    child: Column( // PlayCount Column of Album
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Track Name :',style: AppTextStyles.tileCaptionTextStyle,),
                        SizedBox(height: 5.sp,),
                        Text(track.name.toString() ,overflow: TextOverflow.ellipsis,style: AppTextStyles.tileBodyTextStyle,),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.only(right: 5.w),
                  child:  Icon(Icons.music_note,size: 30,),
                )
              ],
            ),
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