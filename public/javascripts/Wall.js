var wall = function() {
  var addPostIt = function() {
    var newPostIt = $("<div id='post_it_1'></div>").html($("#new_post_it_text").val());
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
