import 'package:app/pagemangaer.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:share_plus/share_plus.dart';

class Home_Screen extends StatefulWidget {
  Home_Screen({required this.url, required this.title, required this.artist})
      : super();
  String title;
  String artist;
  String url;

  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Home_Screen> with WidgetsBindingObserver {
  late final PageManager _pageManager;

  @override
  void initState() {
    _pageManager = PageManager();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double lentgh = 5;
    return Scaffold(
      backgroundColor: const Color(0xFF090e42),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.5,
            child: Stack(children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(widget.url), fit: BoxFit.fill),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    const Color(0xFF090e42).withOpacity(0.4),
                    const Color(0xFF090e42),
                  ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(children: [
                  const SizedBox(
                    height: 42.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(50.0)),
                        child: const Icon(Icons.arrow_drop_down,
                            color: Colors.white),
                      ),
                      Column(
                        children: [
                          Text(
                            'PLAYLIST',
                            style:
                                TextStyle(color: Colors.white.withOpacity(0.6)),
                          ),
                          const Text('Online music radio '),
                        ],
                      ),
                      const Icon(Icons.playlist_add, color: Colors.white),
                    ],
                  )
                ]),
              ),
            ]),
          ),
          const Padding(padding: EdgeInsets.only(top: 10.0)),
          Center(
            child: Text(widget.title,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0)),
          ),
          Center(
            child: Text(widget.artist,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.6),
                  fontSize: 10.0,
                )),
          ),
          const Padding(padding: EdgeInsets.only(top: 50.0)),
          Container(
            height: 10.0,
            width: MediaQuery.of(context).size.width * 0.8,
            child: ValueListenableBuilder<ProgressBarState>(
              valueListenable: _pageManager.progressNotifier,
              builder: (_, value, __) {
                return ProgressBar(
                  progress: value.current,
                  //  buffered: value.buffered,
                  total: value.current,
                  onSeek: _pageManager.seek,
                   progressBarColor: const Color(0xFFff6b80),
                   thumbColor: const Color(0xFFff6b80),
   
                );
              },
            ),
          ),
          const Padding(padding: EdgeInsets.only(top: 50.0)),
          ValueListenableBuilder<ButtonState>(
            valueListenable: _pageManager.buttonNotifier,
            builder: (_, value, __) {
              switch (value) {
                case ButtonState.loading:
                  return Container(
                    margin: const EdgeInsets.all(8.0),
                    width: 32.0,
                    height: 32.0,
                    child: const CircularProgressIndicator(),
                  );
                case ButtonState.paused:
                  return Container(
                    decoration: BoxDecoration(
                        color: const Color(0xFFff6b80),
                        borderRadius: BorderRadius.circular(50.0)),
                    child: IconButton(
                      icon: const Icon(Icons.play_arrow),
                      iconSize: 32.0,
                      onPressed: _pageManager.play,
                    ),
                  );
                case ButtonState.playing:
                  return Container(
                      decoration: BoxDecoration(
                          color: const Color(0xFFff6b80),
                          borderRadius: BorderRadius.circular(50.0)),
                      child: IconButton(
                        icon: const Icon(Icons.pause),
                        iconSize: 32.0,
                        onPressed: _pageManager.pause,
                      ));
              }
            },
          ),
          Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.1)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                  onPressed: () async {
                    const urlPreview =
                        'http://cast1.my-control-panel.com:7099/live';
                    await Share.share(
                        'you can listen to this music online from  the link below : \n\n ${urlPreview}');
                  },
                  icon: const Icon(Icons.share)),
              const Icon(Icons.favorite_border_outlined),
              const Icon(Icons.shuffle),
            ],
          ),
        ],
      ),
    );
  }
}
