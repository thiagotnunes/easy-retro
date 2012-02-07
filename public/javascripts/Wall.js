var wall = function() {
  var addPostIt = function() {
    var newPostIt = $("<div id='post_it'></div>")
      .addClass("post_it well")
      .draggable();
    $("#board").append(newPostIt);
  };
  var bindButtons = function() {
    $("#add_well").click(addPostIt);
  };
  return {
    bindButtons: bindButtons
  }
};

$(document).ready(function() {
  var theWall = wall();
  theWall.bindButtons();
});
