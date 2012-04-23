var uiAdapter = function(name, sender) {

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

  var setHeaderEvents = function(header) {
    header.mousedown(function() { header.parent().addClass('moving'); })
    header.mouseup(function() { header.parent().removeClass('moving'); })
  };

  var setContent= function(content, postIt) {
    content.blur(function() { handleTextChange(postIt) });
    content.html(postIt.text);
  };

  var create = function(postIt) {
    var element = toHtml(postIt);
    setHeaderEvents(element.children('.header'));
    setContent(element.children('.content'), postIt)

    element.offset({left: postIt.left, top: postIt.top});
    element.show();
    $("#board").append(element);

    makeDraggable(element, postIt);

    element.find('.delete').click(function() {
      jQuery.ajax({
        type: "DELETE",
        url: "/board/" + name + "/post_it/" + postIt.id,
        success: sender.send({action: "removed", board: {name: name, post_it: postIt}}),
        dataType: "json"
        });
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

    jQuery.ajax({
      type: "PUT",
      url: "/board/" + name + "/post_it/" + postIt.id,
      data: { post_it: postIt },
      success: sender.send({action: "updated", board: {name: name, post_it: postIt}}),
      dataType: "json"
    });

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
