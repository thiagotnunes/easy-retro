var board = function() {

  var sender = postItSender();
  var adapter = uiAdapter(sender);
  var builder = postItBuilder();
  var router = messageRouter(messageValidator(), {
    create: adapter.create,
    updated: adapter.update,
    removed: adapter.remove
  });

  var success = function(data) {
    var postIts = data.post_its;
    if (data.post_its) {
      $.each(postIts, function(postIt) {
        adapter.create(data.post_its[postIt]);
      });
    }
  };

  $.post('/board', { name: 'demo' });
  $.get('/board/demo', success);
  sender.subscribe(router.route);

  var newPostIt = function(group) {
    var postIt = builder.create({ group: group });
    var message = { action: "create", board: { name: "demo", post_it: postIt } };

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
