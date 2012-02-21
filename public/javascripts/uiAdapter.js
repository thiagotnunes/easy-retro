var uiAdapter = function(sender) {

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
    element.draggable({
      containment: "#board", 
      handle: ".header",
      stop: function() { handleTextChange(postIt);}
    });

    element.children('.removeButton').click(function() { element.remove(); });
    return element;
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

    sender.send({action: "update", board: { name: 'board', postIt: postIt} });
  };

  return {
    create: create,
    update: update
  };
};
