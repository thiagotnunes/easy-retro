var board = function() {

  var client = new Faye.Client("/faye");
  client.subscribe('/board', function(message) {
    wellPostIt();
  });

  var adapter = uiAdapter();
  var easyRetro = retro(adapter);

  var wellPostIt = function() {
    easyRetro.create({group: "well"});
  };

  var notSoWellPostIt = function() {
    easyRetro.create({group: "not_so_well"});
  };

  var badPostIt = function() {
    easyRetro.create({group: "bad"});
  };

  var actionItemPostIt = function() {
    easyRetro.create({group: "action_item"});
  };

  var publishPostIt = function() {
    client.publish('/board', { text: ''});
  };

  var bindButtons = function() {
    $("#add_well").click(publishPostIt);
    $("#add_not_so_well").click(notSoWellPostIt);
    $("#add_bad").click(badPostIt);
    $("#add_action_item").click(actionItemPostIt);
  };

  return {
    bindButtons: bindButtons
  }
};
