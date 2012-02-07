describe("Wall", function() {
  it("should add post it with given text", function() {
    loadFixtures("wall.html");
    wall().bindButtons();
    $("#add_well").click();
    expect($("#new_post_it")).toBeVisible();
  });
});
