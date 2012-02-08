var wall = function() {
  var addPostIt = function() {
    var newPostIt = $("#base_post_it").clone()
      .attr("id", "post_it")
      .removeClass("hidden")
      .addClass("new")
      .draggable({
        containment: "#board", 
        handle: ".header",
      })
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
