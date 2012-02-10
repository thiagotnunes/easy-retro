var uiAdapter = function(sender) {

  var update = function(postIt) {
    var uiPostIt = getPostIt(postIt);

    uiPostIt.children('.content').html(postIt.text);
    uiPostIt.show();
    $("#board").append(uiPostIt);
    uiPostIt.draggable({
      containment: "#board", 
      handle: ".header",
    });

    return uiPostIt;
  };

  var getPostIt = function(postIt) {
    var retrievedPostIt = getFromPage(postIt);
    if (retrievedPostIt.length === 0) {
      retrievedPostIt = create(postIt);
    }
    return retrievedPostIt;
  };

  var getFromPage = function(postIt) {
    return $('#' + postIt.id);
  };

  var create = function(postIt) {
    var element = toHtml(postIt);
    var content = element.children('.content');
    content.blur(function() { handleTextChange(postIt) });
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
    sender.send(postIt);
  };

  return {
    update: update
  };
};
