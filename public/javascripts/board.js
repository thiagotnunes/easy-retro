var board = function() {

  var sender = postItSender();
  var adapter = uiAdapter(sender);
  var builder = postItBuilder();
  var router = messageRouter(messageValidator(), {
    create: adapter.create,
    update: adapter.update
  });

  var success = function(data) {
    var postIts = data.postIts;
    if (data.postIts) { 
      $.each(postIts, function(postIt) {
        adapter.create(data.postIts[postIt]);
      });
    }
  };

  $.post('/boards', { name: 'board' });
  $.get('/boards/board', success);
  sender.subscribe(router.route);

  var newPostIt = function(group) {
    var postIt = builder.create({ group: group });
    var message = { action: "create", board: { name: "board", postIt: postIt } };

    sender.send(message);
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
