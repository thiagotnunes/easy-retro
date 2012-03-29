var board = function() {

  var sender = postItSender();
  var adapter = uiAdapter(sender);
  var router = messageRouter(messageValidator(), {
    created: adapter.create,
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
    jQuery.ajax({
      type: "POST",
      data: { post_it: { group: group } },
      url: "/board/demo/post_it",
      success: function(data) { sender.send({action: "created", board: {name: "demo", post_it: data}}) },
      dataType: "json"
    });
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
