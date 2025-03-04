import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoCard extends StatefulWidget {
  final String videoPath; // Added required parameter for video path
  final String videoName;
  
  const VideoCard({
    super.key,
    required this.videoPath, // Make it required
    required this.videoName,
  });

  @override
  State<VideoCard> createState() => _VideoCard();
}

class _VideoCard extends State<VideoCard> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;
  String _errorMessage = '';
   

  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer();
  }

  Future<void> _initializeVideoPlayer() async {
    try {
      // Use the path provided via widget parameter
      _controller = VideoPlayerController.asset(widget.videoPath);
      
      // Initialize and configure the player
      await _controller.initialize();
      _controller.setLooping(true);
      _controller.play();
      
      if (mounted) {
        setState(() {
          _isInitialized = true;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = 'Error loading video: $e';
        });
      }
    }
  }

  @override
  void dispose() {
    if (_isInitialized) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.videoName,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            
            // Pre-rendered animation
            SizedBox(
              height: 400,
              child: _isInitialized
                ? AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  )
                : Center(
                    child: _errorMessage.isNotEmpty
                      ? Text(_errorMessage, style: TextStyle(color: Colors.red))
                      : CircularProgressIndicator(),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}