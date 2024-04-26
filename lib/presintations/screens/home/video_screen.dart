import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoScreen extends StatefulWidget {

   VideoScreen({Key? key,required this.video,required this.title}) : super(key: key);
   final String? video;
   final String? title;

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {

  late VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _videoPlayerController=VideoPlayerController.asset('${widget.video}'
    )..initialize().then((_){
      setState(() {

      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back,),onPressed: (){
          _videoPlayerController.pause();
          Navigator.pop(context);
        },),

        centerTitle: true,
        title: Text('${widget.title}'),
      ),
      body: Center(
        child: _videoPlayerController.value.isInitialized?
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AspectRatio(
                  aspectRatio: _videoPlayerController.value.aspectRatio,
                  child: VideoPlayer(_videoPlayerController)),
              SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: (){
                        _videoPlayerController.pause();
                      },
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.teal,
                        ),
                        child: Center(child: Icon(Icons.pause,color: Colors.white,)),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: (){
                        _videoPlayerController.play();
                      },
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.teal,
                        ),
                        child: Center(child: Icon(Icons.play_arrow,color: Colors.white,)),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ) :
        Container(),
      ),
    );
  }
}
