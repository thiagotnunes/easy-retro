/*
beforeEach(function() {
  this.addMatchers({
    toBePlaying: function(expectedSong) {
      var player = this.actual;
      return player.currentlyPlayingSong === expectedSong && 
             player.isPlaying;
    }
  });
});
*/
$.fx.off = true;

require.config({baseUrl: "public/javascripts/"});
(function () {
  var deps = ["draggable",
              "board",
              "uiAdapter",
              "postItSender",
              "postItBuilder",
              "messageValidator",
              "messageRouter"];

  require(deps);
}())
