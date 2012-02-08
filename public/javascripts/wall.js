var board = function() {

  var client = new Faye.Client("/faye");
  client.subscribe('/board', function(message) {
    addPostIt();
  });

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
  var publishPostIt = function() {
    client.publish('/board', { text: ''});
  };
  var bindButtons = function() {
    $("#add_well").click(publishPostIt);
  };

  return {
    bindButtons: bindButtons
  }
};
