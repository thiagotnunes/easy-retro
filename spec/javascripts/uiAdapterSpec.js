describe("UI Adapter", function() {

  var adapter; 
  var sender;

  beforeEach(function() {
    sender = { send: jasmine.createSpy() };
    adapter = uiAdapter("test", sender);
    loadFixtures("board.html");
  });

  it("should create a post it", function() {
    var postIt = {id: 123, text: 'some text'};

    var element = adapter.create(postIt);
    expect(element).toHaveId('123');
    expect(element.children('.content')).toHaveHtml('some text');
    expect($('#123')).toExist();
    expect($('[id=123]').length).toEqual(1);
  });

  it("should update a post it", function() {
    var postIt = {id: 123, text: 'some text'};
    var element = adapter.create(postIt);
    element = adapter.update(postIt);

    postIt.text = 'other text';
    element = adapter.update(postIt);

    expect(element).toHaveId('123');
    expect(element.children('.content')).toHaveHtml('other text');
    expect($('[id=123]').length).toEqual(1);
  });

  it("should send a removed message when clicking remove button", function() {
    var postIt = {id: '123', text: 'some text'};
    var element = adapter.create(postIt);
    element.find('.delete').click();
    var expectedMessage =  { action: 'removed', board: {name: 'test', post_it: {id: '123', text: 'some text'}}};
    expect(sender.send).toHaveBeenCalledWith(expectedMessage);
  });

  it("should remove a post it", function() {
    var postIt = {id: 123, text: 'some text'};
    adapter.create(postIt);
    adapter.remove({id: "123"});
    expect($("#123")).not.toExist();
  });
});
