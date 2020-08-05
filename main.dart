import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              title: Text("Musideo App"),
              centerTitle: true,
              backgroundColor: Colors.black,
              bottom: TabBar(
                tabs: [
                  Tab(icon: Icon(Icons.play_circle_filled), text: "videos"),
                  Tab(icon: Icon(Icons.music_note), text: "music"),
                ]
              ),
            ),
            body: TabBarView(
              children: [
                VideoPlayerApp(),
                MusicPlayerApp(),
              ],
            )
          ),
        )
    );
  }
}

AudioPlayer audioPlayer = AudioPlayer();
AudioCache audioCache = AudioCache();
Future<int> result;// = audioPlayer.play("https://kryszna.in/ringtones/duniyaa_-luka_chhupi-79.mp3");
var audio = audioPlayer;

class MusicPlayerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text("my first song"),
                  ),
                  IconButton(
                    icon: Icon(Icons.play_circle_outline),
                    tooltip: 'Increase volume by 10',
                    onPressed: () {
                      result = audio.play("https://kryszna.in/ringtones/duniyaa_-luka_chhupi-79.mp3");
                    }
                  ),
                  IconButton(
                    icon: Icon(Icons.pause),
                    tooltip: 'Increase volume by 10',
                    onPressed: () {
                      result = audio.stop();
                    }
                  )
                ]
              ),
              width: double.infinity,
              margin: EdgeInsets.all(4.0),
              padding: EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(4),
              )
            ),
          ]
        )
      )
    );
  }
}





class VideoPlayerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Video Player Demo',
      home: VideoPlayerScreen(),
    );
  }
}

class VideoPlayerScreen extends StatefulWidget {
  VideoPlayerScreen({Key key}) : super(key: key);

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    // Create and store the VideoPlayerController. The VideoPlayerController
    // offers several different constructors to play videos from assets, files,
    // or the internet.
    _controller = VideoPlayerController.network(
      'https://r5---sn-npoe7n7z.googlevideo.com/videoplayback?expire=1596631693&ei=LVYqX4nSN8zQ7gOEqJ74Bg&ip=116.96.168.20&id=o-AP1JnMF3oc93YFr82kgZFIJRAfVWB1uMIPj5zj2ZEPs9&itag=18&source=youtube&requiressl=yes&vprv=1&mime=video%2Fmp4&gir=yes&clen=1611979&ratebypass=yes&dur=42.376&lmt=1581021865832683&fvip=7&fexp=23883098&c=WEB&txp=6216222&sparams=expire%2Cei%2Cip%2Cid%2Citag%2Csource%2Crequiressl%2Cvprv%2Cmime%2Cgir%2Cclen%2Cratebypass%2Cdur%2Clmt&sig=AOq0QJ8wRQIgPCwoda48KcfamudLLt2zub6QS6oewyp8OkK5iKiSePcCIQDu3ook4Ce8ApzzfQ3X1ytSNzp_1bUPtuDjDjHItjDyVg%3D%3D&video_id=r6k_w-5R2qw&title=Free+of+Cost+-+Every+Pursuing+Engineering+Students+Should+Part+of+RedHat+8+%26+Python3+Training&rm=sn-8pxuuxa-i2il76,sn-8pxuuxa-i5oz77k&req_id=f4fd1621efc7a3ee&ipbypass=yes&redirect_counter=3&cm2rm=sn-i3b6z76&cms_redirect=yes&mh=wS&mip=2402:8100:2085:e891:b027:c93c:e27:281d&mm=34&mn=sn-npoe7n7z&ms=ltu&mt=1596609926&mv=m&mvi=5&pl=42&lsparams=ipbypass,mh,mip,mm,mn,ms,mv,mvi,pl&lsig=AG3C_xAwRAIgbCPGFAPNwTZbux1bIfBaKi7Pn6JnxXOcOpdJrAjI1L4CICS5KNCFe9SZHGP2IV50J5smFQF1oOBdAeOO-U2g-CVg',
    );

    // Initialize the controller and store the Future for later use.
    _initializeVideoPlayerFuture = _controller.initialize();

    // Use the controller to loop the video.
    _controller.setLooping(true);

    super.initState();
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Use a FutureBuilder to display a loading spinner while waiting for the
      // VideoPlayerController to finish initializing.
      body: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the VideoPlayerController has finished initialization, use
            // the data it provides to limit the aspect ratio of the video.
            return AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              // Use the VideoPlayer widget to display the video.
              child: VideoPlayer(_controller),
            );
          } else {
            // If the VideoPlayerController is still initializing, show a
            // loading spinner.
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Wrap the play or pause in a call to `setState`. This ensures the
          // correct icon is shown.
          setState(() {
            // If the video is playing, pause it.
            if (_controller.value.isPlaying) {
              _controller.pause();
            } else {
              // If the video is paused, play it.
              _controller.play();
            }
          });
        },
        // Display the correct icon depending on the state of the player.
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
