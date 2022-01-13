import 'package:flutter/material.dart';
import 'package:last_fm_audio_management/core/themes/text_styles.dart';
import 'package:last_fm_audio_management/models/artist_info.dart';
import 'package:sizer/sizer.dart';


///
/// This widget is a list tile on the Search page
/// that show the details about the artists .
///



class SearchPageCustomListTile  extends StatelessWidget {
  final Artist artist ;
  const SearchPageCustomListTile ({Key? key,required this.artist, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: InkWell(                         /// to act like a Button while tapping on
        onTap: () async {
          Navigator.of(context).pushNamed('/top_albums',arguments: artist.mbid);
        },
        splashColor: Colors.black,
        child: Container(
          height: 13.h,
          color:Theme.of(context).cardColor ,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
             /* Image.network(result.image,
                  errorBuilder: ( context,  exception,  stackTrace) {
                    return Image.asset('not_found.jpg') ; ///in the case of error to load Image throw network the not_found Image will be appear
                  }),*/
              Padding(
                padding:  EdgeInsets.only(top: 2.sp, left: 5.sp,bottom: 2.sp,right: 5.sp),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          width: 40.w ,
                          child: Text(artist.name,overflow: TextOverflow.ellipsis,style: AppTextStyles.tileBodyTextStyle,)),

                      SizedBox(height: 2.h,),
                      Container(
                        width: 75.w,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,

                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Url:',style: AppTextStyles.tileCaptionTextStyle,),
                                SizedBox(height: 2.sp,),
                                Container(
                                    width: 50.w,
                                    child: Text(artist.url,overflow: TextOverflow.ellipsis,style: AppTextStyles.tileBodyTextStyle,))
                              ],

                            ),

                            Column(   // Gender  column
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('listener:',style: AppTextStyles.tileCaptionTextStyle,),
                                SizedBox(height: 2.sp,),
                                Text(artist.listeners,style: AppTextStyles.tileBodyTextStyle,)
                              ],

                            ),

                          ],
                        ),
                      ),

                    ],
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}