import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class MusicControls extends StatefulWidget {
  final String music;
  final double? size;

  const MusicControls({
    super.key,
    required this.music,
    this.size
  });

  @override
  State<MusicControls> createState() => _MusicControlsState();
}

class _MusicControlsState extends State<MusicControls> {
  final AudioPlayer _player = AudioPlayer();
  bool _isPlaying = false;
  bool _isPaused = false;

  Future<void> _togglePlayStop() async {
    if (_isPlaying) {
      await _player.stop();
      setState(() {
        _isPlaying = false;
        _isPaused = false;
      });
    } else {
      await _player.play(AssetSource(widget.music));
      setState(() {
        _isPlaying = true;
        _isPaused = false;
      });
    }
  }

  Future<void> _pauseOrResume() async {
    if (!_isPlaying) return;

    if (_isPaused) {
      // Reanudar
      await _player.resume();
      setState(() => _isPaused = false);
    } else {
      // Pausar realmente la canción
      await _player.pause();
      setState(() => _isPaused = true);
    }
  }

  @override
  void initState() {
    super.initState();

    // Si la canción termina, actualiza el estado
    _player.onPlayerComplete.listen((event) {
      setState(() {
        _isPlaying = false;
        _isPaused = false;
      });
    });
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 5,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Botón Play/Stop
        IconButton(
          onPressed: _togglePlayStop,
          icon: Icon(
            _isPlaying ? Icons.stop_outlined : Icons.play_arrow_outlined,
            size: widget.size,
            color: Colors.pinkAccent,
          ),
        ),

        // Botón Pausa/Reanudar
        IconButton(
          onPressed: _isPlaying ? _pauseOrResume : null,
          icon: Icon(
            _isPaused ? Icons.play_circle_outline : Icons.pause_outlined,
            size: widget.size,
            color: _isPlaying ? Colors.black : Colors.grey,
          ),
        ),
      ],
    );
  }
}
