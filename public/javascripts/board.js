var board = function() {

  var sender = postItSender();
  var adapter = uiAdapter(sender);
  var builder = postItBuilder();

  sender.subscribe(adapter.update);

  var newPostIt = function(group) {
    var postIt = builder.create({group: group});
    sender.send(postIt);
  };

  var bindButtons = function() {
    $("#add_well").click(function() { newPostIt("well") });
    $("#add_not_so_well").click(function() { newPostIt("not_so_well") });
    $("#add_bad").click(function() { newPostIt("bad") });
    $("#add_action_item").click(function() { newPostIt("action_item") });
  };

  return {
    bindButtons: bindButtons
  }
};
