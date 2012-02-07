describe("Wall", function() {
  it("should add post it with given text", function() {
    loadFixtures("wall.html");
    wall().bindButtons();
    $("#new_post_it_text").val("build takes too long");
    $("#add_post_it").click();
    expect($("#post_it_1")).toHaveHtml("build takes too long");
  });
});
