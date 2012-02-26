(function () {
  var deps = ["order!vendor/jquery-1.7.1",
              "order!vendor/jquery.ui.core",
              "order!vendor/jquery.ui.widget",
              "order!vendor/jquery.ui.mouse",
              "order!vendor/jquery.ui.draggable",
              "faye.js",
              "board",
              "uiAdapter",
              "postItSender",
              "postItBuilder",
              "messageValidator",
              "messageRouter"];

  var callback = function(someModule) {
                $(document).ready(function() {
                  var retroBoard = board();
                  retroBoard.bindButtons();
                });
              };

  require(deps, callback);
}())
