require "application_system_test_case"

class MilkmenTest < ApplicationSystemTestCase
  setup do
    @milkman = milkmen(:one)
  end

  test "visiting the index" do
    visit milkmen_url
    assert_selector "h1", text: "Milkmen"
  end

  test "creating a Milkman" do
    visit milkmen_url
    click_on "New Milkman"

    fill_in "Name", with: @milkman.name
    click_on "Create Milkman"

    assert_text "Milkman was successfully created"
    click_on "Back"
  end

  test "updating a Milkman" do
    visit milkmen_url
    click_on "Edit", match: :first

    fill_in "Name", with: @milkman.name
    click_on "Update Milkman"

    assert_text "Milkman was successfully updated"
    click_on "Back"
  end

  test "destroying a Milkman" do
    visit milkmen_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Milkman was successfully destroyed"
  end
end
