(function () {
  var deps = ["order!vendor/jquery-1.7.1",
              "order!vendor/jquery.ui.core",
              "order!vendor/jquery.ui.widget",
              "order!vendor/jquery.ui.mouse",
              "faye.js",
              "draggable",
              "board",
              "uiAdapter",
              "postItSender",
              "messageValidator",
              "messageRouter"];

  var callback = function() {
                $(document).ready(function() {
                  var retroBoard = board(boardName);
                  retroBoard.bindButtons();
                });
              };

  require(deps, callback);
}())
