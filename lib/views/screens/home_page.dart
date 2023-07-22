import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_app/controllers/api_controller.dart';
import 'package:wallpaper_app/controllers/helpers/api_helper.dart';
import 'package:wallpaper_app/modals/post_modal.dart';
import 'package:wallpaper_app/utils/my_page_route_utils.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Wallpaper",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Consumer<ApiController>(builder: (context, provider, child) {
            return Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    hintText: "Search",
                    hintStyle: TextStyle(
                      color: Colors.grey.shade400,
                    ),
                    suffixIcon: Icon(
                      Icons.search,
                      color: Colors.grey.shade400,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onSubmitted: (val) {
                    provider.search(val: val);
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                (provider.data.isNotEmpty)
                    ? Expanded(
                        child: GridView.builder(
                          itemCount: provider.data.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                          ),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                  MyPageRoute.detailPage,
                                  arguments: index,
                                );
                              },
                              child: Stack(
                                alignment: Alignment.topRight,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.all(
                                      5,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          provider.data[index]['largeImageURL'],
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      provider.addFavourite(index: index);
                                    },
                                    icon: const Icon(
                                      Icons.favorite,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      )
                    : const Center(
                        child: Text("Search Data not Found !!"),
                      ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
