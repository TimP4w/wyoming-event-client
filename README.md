# wyoming-event-client

This is a custom event client for the wyoming protocol that I'm using in my setup.

It uses the 4mic_led example from [wyming-satellite](https://github.com/rhasspy/wyoming-satellite) with some customization and more complex effects (see `think()`).
It also runs some scripts on Home Assistant to duck the music and play the TTS response on my Sonos speakers.

I have the following scripts setup on my HA installation:

`jarvis_duck_sonos`
It plays 2 seconds of silence as announcement on my sonos speakers.
```yaml 
alias: Jarvis Duck Sonos
sequence:
  - service: media_player.play_media
    metadata: {}
    data:
      media_content_id: http://192.168.1.11:8123/local/media/sounds/2s-silence.wav
      media_content_type: music
      announce: true
    target:
      device_id: 3741cedbe16611f6f06dddb6a3669525
mode: single
```

`jarvis_announce_sonos`
Plays the TTS response
```yaml 
alias: Jarvis Announce Sonos
sequence:
  - service: media_player.play_media
    target:
      device_id: 3741cedbe16611f6f06dddb6a3669525
    data:
      media_content_id: >-
        media-source://tts/tts.home_assistant_cloud?message="{{ message |
        urlencode}}"&language=it-IT&voice=IsabellaNeural&preferred_format=wav&preferred_sample_rate=16000&preferred_sample_channels=1
      media_content_type: provider
      announce: true
mode: single



```
