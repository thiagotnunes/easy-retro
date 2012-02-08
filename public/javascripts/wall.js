var wall = function() {
  var addPostIt = function() {
    var newPostIt = $("#base_post_it").clone()
      .attr("id", "post_it")
      .removeClass("hidden")
      .addClass("new")
      .show();
    $("#board").append(newPostIt);
    newPostIt.draggable({
        containment: "#board", 
        handle: ".header",
      });

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

