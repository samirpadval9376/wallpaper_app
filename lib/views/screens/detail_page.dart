import 'package:async_wallpaper/async_wallpaper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:wallpaper_app/controllers/api_controller.dart';
import 'package:wallpaper_app/utils/my_page_route_utils.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    int index = ModalRoute.of(context)!.settings.arguments as int;
    Size s = MediaQuery.of(context).size;

    Future.delayed(const Duration(milliseconds: 500), () {
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
      );

      setState(() {});
    });

    return SafeArea(
      child: Scaffold(
        body: Consumer<ApiController>(builder: (context, provider, child) {
          return Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                height: s.height,
                width: s.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      provider.data[index]['largeImageURL'],
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: s.width * 0.08,
                    ),
                    IconButton(
                      onPressed: () {
                        Share.share(
                          provider.data[index]['largeImageURL'],
                        );
                      },
                      icon: const Icon(
                        Icons.share,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white,
                      child: IconButton(
                        onPressed: () async {
                          // var response = await Dio().get()
                          // final result = await ImageGallerySaver.saveImage(
                          //     Unit8List.fromList(response.data));
                        },
                        icon: const Icon(
                          Icons.save_alt_outlined,
                          color: Colors.black,
                          size: 30,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                          MyPageRoute.favouritePage,
                          arguments: index,
                        );
                      },
                      icon: const Icon(
                        Icons.favorite_border_outlined,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text(
                                "Select Location !!",
                              ),
                              alignment: Alignment.bottomRight,
                              content: SizedBox(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ElevatedButton(
                                      child: const Text(
                                        "Lock Screen",
                                      ),
                                      onPressed: () {
                                        AsyncWallpaper.setWallpaper(
                                          url: provider.data[index]
                                              ['largeImageURL'],
                                          wallpaperLocation:
                                              AsyncWallpaper.LOCK_SCREEN,
                                          goToHome: true,
                                          toastDetails: ToastDetails.success(),
                                          errorToastDetails:
                                              ToastDetails.error(),
                                        );
                                      },
                                    ),
                                    ElevatedButton(
                                      child: const Text(
                                        "Home Screen",
                                      ),
                                      onPressed: () {
                                        AsyncWallpaper.setWallpaper(
                                          url: provider.data[index]
                                              ['largeImageURL'],
                                          wallpaperLocation:
                                              AsyncWallpaper.HOME_SCREEN,
                                          goToHome: true,
                                          toastDetails: ToastDetails.success(),
                                          errorToastDetails:
                                              ToastDetails.error(),
                                        );
                                      },
                                    ),
                                    ElevatedButton(
                                      child: const Text(
                                        "Both Screens",
                                      ),
                                      onPressed: () {
                                        AsyncWallpaper.setWallpaper(
                                          url: provider.data[index]
                                              ['largeImageURL'],
                                          wallpaperLocation:
                                              AsyncWallpaper.BOTH_SCREENS,
                                          goToHome: true,
                                          toastDetails: ToastDetails.success(),
                                          errorToastDetails:
                                              ToastDetails.error(),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                      icon: const Icon(
                        Icons.more_horiz_outlined,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    SizedBox(
                      width: s.width * 0.08,
                    ),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
