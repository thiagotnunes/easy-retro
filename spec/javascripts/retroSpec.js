describe("wall", function() {

  var retroUi;
  var retroBoard;

  beforeEach(function() {
    retroUi = { update: jasmine.createSpy() };
    retroBoard = retro(retroUi);
  });

  it("should create a post it with id", function() {
    var jpostIt = {text: 'some text'};
    var id = retroBoard.create(jpostIt);
    var postIt = retroBoard.getPostIt(id);

    expect(postIt.id).toEqual(id);
    expect(postIt.text).toEqual('some text');
  });

  it("should create two post its with different ids", function() {
    var id1 = retroBoard.create({});
    var id2 = retroBoard.create({});

    expect(id1).not.toEqual(id2);
  });

  it("should update a post it", function() {
    var id = retroBoard.create({});
    var postIt = {id: id, text: 'updated post it'};
    retroBoard.update(postIt);
    expect(retroBoard.getPostIt(id).text).toEqual('updated post it');
  });

  it("should update a post it calling ui adapter", function()  {
    var id = retroBoard.create({});
    var postIt = {id: id, text: 'updated post it'};
    retroBoard.update(postIt);
    expect(retroBoard.getPostIt(id).text).toEqual('updated post it');
    expect(retroUi.update).toHaveBeenCalledWith(postIt);
  });

});
