var uiAdapter = function(sender) {

  var draggable = require("draggable");

  var update = function(postIt) {
    var element = getFromPage(postIt);

    element.children('.content').html(postIt.text);
    element.offset({left: postIt.left, top: postIt.top});

    return element;
  };

  var getFromPage = function(postIt) {
    return $('#' + postIt.id);
  };

  var create = function(postIt) {
    var element = toHtml(postIt);
    var content = element.children('.content');

    content.blur(function() { handleTextChange(postIt) });

    element.children('.content').html(postIt.text);
    element.offset({left: postIt.left, top: postIt.top});
    element.show();
    $("#board").append(element);

    makeDraggable(element, postIt);

    element.find('.delete').click(function() {
      sender.send({action: "remove", board: {name: "demo", postIt: postIt}});
    });
    return element;
  };

  var makeDraggable = function (element, postIt) {
    var rawElement = element.get(0);
    var handle = element.find(".header");

    draggable(rawElement, handle.get(0));
    rawElement.draggableListeners['stop'].push(function() { handleTextChange(postIt); } );
  };

  var toHtml = function(postIt) {
    var element = $("#base_post_it").clone()
        .attr("id", postIt.id)
        .removeClass("hidden")
        .addClass("new")
        .addClass(postIt.group);

    return element;
  };

  var handleTextChange = function(postIt) {
    var element = getFromPage(postIt);
    postIt.text = element.children('.content').html();
    var offset = element.offset();
    postIt.left = offset.left;
    postIt.top = offset.top;

    sender.send({action: "update", board: { name: 'demo', postIt: postIt} });
  };

  var remove = function (postIt) {
    var element = getFromPage(postIt);
    element.fadeOut(function() {element.remove()}); 
  };

  return {
    create: create,
    update: update,
    remove: remove
  };
};
