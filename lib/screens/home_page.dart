import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wallpaper/data/images.dart';
import 'package:wallpaper/data/textstyle.dart';
import 'package:wallpaper/repository.dart';
import 'package:wallpaper/screens/view.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  List imageList = [];

  void getData() async {
    ApiCall api = ApiCall();
    final data = await api.getPhoto();
    if (data != null) {
      setState(() {
        imageList = data;
      });
    }
    print("Response  = $data");
  }

  @override
  Widget build(BuildContext context) {
    print("Len == ${imageList.length}");
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        extendBody: true,
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Container(
            width: double.infinity,
            child: Column(
              children: [
                MenuBar(),
                SizedBox(
                  height: 10,
                ),
                CategoryList(),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: imageList.length == 0
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : GridView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount: imageList.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 9 / 16,
                                    crossAxisSpacing: 3,
                                    mainAxisSpacing: 3),
                            itemBuilder: (context, index) {
                              final data = imageList[index];
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ImageView(
                                              path: data["urls"]["full"])));
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    // color: Colors.amber,
                                    child: Image.network(
                                      data["urls"]["thumb"],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              );
                            }),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}

class CategoryList extends StatelessWidget {
  const CategoryList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List _items = Images.iList;
    return Container(
      height: MediaQuery.of(context).size.height * 0.08,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
        child: ListView.builder(
            clipBehavior: Clip.none,
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: _items.length,
            itemBuilder: (context, index) {
              return CategoryTile(
                index: index,
              );
            }),
      ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  const CategoryTile({
    Key? key,
    required this.index,
  }) : super(key: key);
  final int index;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Colors.black,
              blurRadius: 30,
              spreadRadius: -15,
              offset: Offset(5, 2))
        ],
        image: DecorationImage(
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.2), BlendMode.hardLight),
            fit: BoxFit.fitWidth,
            image: AssetImage(Images.iList[index])),
        borderRadius: BorderRadius.circular(8),
      ),
      alignment: Alignment.center,
      padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
      margin: EdgeInsets.fromLTRB(8, 0, 0, 0),
      child: Text(
        "data" + index.toString(),
        style: TextStyles.category,
      ),
    );
  }
}

class MenuBar extends StatelessWidget {
  const MenuBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
        height: height * 0.06,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
          child: Row(
            children: [
              SizedBox(
                height: 20,
                width: 20,
                child: SvgPicture.asset(
                  "assets/icons/menu.svg",
                ),
              )
            ],
          ),
        ));
  }
}
