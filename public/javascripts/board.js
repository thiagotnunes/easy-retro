var board = function() {

  var adapter = uiAdapter();
  var sender = postItSender(adapter);
  var easyRetro = retro(sender);

  var wellPostIt = function() {
    easyRetro.create({group: "well"});
  };

  var notSoWellPostIt = function() {
    easyRetro.create({group: "not_so_well"});
  };

  var actionItemPostIt = function() {
    easyRetro.create({group: "action_item"});
  };

  var bindButtons = function() {
    $("#add_well").click(wellPostIt);
    $("#add_not_so_well").click(notSoWellPostIt);
    $("#add_action_item").click(actionItemPostIt);
  };

  return {
    bindButtons: bindButtons
  }
};
