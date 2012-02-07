var wall = function() {
  var addPostIt = function() {
    var newPostIt = $("<div id='post_it'></div>")
      .draggable();
    $("#post_its").append(newPostIt);
  };
  var bindButtons = function() {
    $("#add_post_it").click(addPostIt);
  };
  return {
    bindButtons: bindButtons
  }
};

$(document).ready(function() {
  var theWall = wall();
  theWall.bindButtons();
});
