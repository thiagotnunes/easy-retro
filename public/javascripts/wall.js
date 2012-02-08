var board = function() {

  var client = new Faye.Client("/faye");
  client.subscribe('/board', function(message) {
    wellPostIt();
  });

  var createPostIt = function(type) {
    var postIt = $("#base_post_it").clone()
          .attr("id", "post_it")
          .removeClass("hidden")
          .addClass("new")
          .addClass(type)
          .show();

    return postIt;
  };

  var appendPostItToBoard = function(postIt) {
    $("#board").append(postIt);
  };

  var makePostItDraggable = function(postIt){
    postIt.draggable({
      containment: "#board", 
      handle: ".header",
    });
  };

  var wellPostIt = function() {
    var postIt = createPostIt("well");
    appendPostItToBoard(postIt);
    makePostItDraggable(postIt);
  };

  var notSoWellPostIt = function() {
    var postIt = createPostIt("not_so_well");
    appendPostItToBoard(postIt);
    makePostItDraggable(postIt);
  };

  var actionItemPostIt = function() {
    var postIt = createPostIt("action_item");
    appendPostItToBoard(postIt);
    makePostItDraggable(postIt);
  };

  var publishPostIt = function() {
    client.publish('/board', { text: ''});
  };

  var bindButtons = function() {
    $("#add_well").click(publishPostIt);
    $("#add_not_so_well").click(notSoWellPostIt);
    $("#add_action_item").click(actionItemPostIt);
  };

  return {
    bindButtons: bindButtons
  }
};
