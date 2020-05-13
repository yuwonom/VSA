import 'package:flutter_tts/flutter_tts.dart';

enum TtsState { playing, stopped }

class TextToSpeech {
  static TextToSpeech _instance;
  static TextToSpeech get instance {
    if (_instance == null) {
      _instance = TextToSpeech._();
    }
    return _instance;
  }

  TextToSpeech._()
      : _tts = FlutterTts(),
        _state = TtsState.stopped {
    _tts
      ..setStartHandler(() => _state = TtsState.playing)
      ..setCompletionHandler(() => _state = TtsState.stopped)
      ..setErrorHandler((error) => _state = TtsState.stopped);
  }

  final FlutterTts _tts;
  final double _volume = 0.5;
  final double _speechRate = 0.5;
  final double _pitch = 1.0;

  TtsState _state;

  Future<void> speak(String text) async {
    if (_state == TtsState.playing) {
      _tts.stop();
    }

    await _tts.setVolume(_volume);
    await _tts.setSpeechRate(_speechRate);
    await _tts.setPitch(_pitch);
    await _tts.speak(text);
  }
}
