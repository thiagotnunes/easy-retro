var wall = function() {
  var addPostIt = function() {
    var newPostIt = $("#base_post_it").clone()
      .attr("id", "new_post_it")
      .draggable({handle: ".header"})
      .show();
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
