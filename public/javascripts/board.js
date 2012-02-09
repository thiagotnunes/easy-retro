var board = function() {

  var adapter = uiAdapter();
  var sender = postItSender(adapter);
  var easyRetro = retro(sender);

  var newPostIt = function(group) {
    easyRetro.create({group: group});
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
