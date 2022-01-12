import 'package:flutter/material.dart';
import 'package:last_fm_audio_management/models/artist_info.dart';
import 'package:sizer/sizer.dart';



class CustomListTile  extends StatelessWidget {
  final Artist artist ;
  const CustomListTile ({Key? key,required this.artist, }) : super(key: key);

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
            mainAxisAlignment: MainAxisAlignment.start,
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
                          child: Text(artist.name,overflow: TextOverflow.ellipsis,style: Theme.of(context).textTheme.bodyText1,)),

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
                                Text('Url:',style: Theme.of(context).textTheme.caption,),
                                SizedBox(height: 2.sp,),
                                Container(
                                    width: 50.w,
                                    child: Text(artist.url,overflow: TextOverflow.ellipsis,style: Theme.of(context).textTheme.bodyText1,))
                              ],

                            ),

                            Column(   // Gender  column
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('listener:',style: Theme.of(context).textTheme.caption,),
                                SizedBox(height: 2.sp,),
                                Text(artist.listeners,style: Theme.of(context).textTheme.bodyText1,)
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