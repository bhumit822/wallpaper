import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ImageView extends StatefulWidget {
  const ImageView({Key? key, required this.path}) : super(key: key);

  final String path;

  @override
  _ImageViewState createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBody: true,
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Image.network(
              widget.path,
              fit: BoxFit.cover,
            ),
          ),
          Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(0.8),
                        Colors.transparent
                      ],
                      begin: Alignment.bottomCenter,
                      stops: [-0.2, 0.2],
                      end: Alignment.topCenter)),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                        height: 35,
                        width: 35,
                        child: SvgPicture.asset(
                          "assets/icons/h1.svg",
                          color: Colors.white,
                        )),
                    SizedBox(
                        height: 25,
                        width: 40,
                        child: SvgPicture.asset(
                          "assets/icons/download.svg",
                          color: Colors.white,
                        ))
                  ],
                ),
              )),
          Positioned(
              top: 40,
              left: 20,
              child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: SizedBox(
                      height: 30,
                      width: 30,
                      child: SvgPicture.asset(
                        "assets/icons/back.svg",
                        color: Colors.white,
                      ))))
        ],
      ),
    );
  }
}
