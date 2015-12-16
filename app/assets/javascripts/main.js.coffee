$(document).ready ->
  $(".audio-btn").on "click", ->
    audio_player = $(this).parent().find(".audio-play")[0]
    audio_player.current_time = 0
    audio_player.play()
