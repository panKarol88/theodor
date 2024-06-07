require 'rails_helper'

describe "Data Crumbs", :js, type: :feature do
  before { create_list(:data_crumb, 3) }

  setup do
    @data_crumb = DataCrumb.order(created_at: :desc).first
  end

  describe "List of data crumbs" do
    context "with no params at all" do
      it "displays the correct list of all Data Crumb elements" do
        visit data_crumbs_path

        expect(page).to have_selector('.data-crumb', count: DataCrumb.count)
        DataCrumb.find_each do |data_crumb|
          expect(page).to have_selector('.data-crumb', text: data_crumb.content)
        end
      end
    end
  end

  describe "Showing a Data Crumb" do
    it "displays the correct Data Crumb" do
      visit data_crumbs_path
      click_link @data_crumb.id.to_s

      expect(page).to have_selector('h1', text: @data_crumb.content)
    end
  end

  describe "Creating a new Data Crumb" do
    let(:content) { "Capybara is awesome!" }

    it "creates a new Data Crumb and displays it in the list of Data Crumbs" do
      visit data_crumbs_path
      assert_selector "h1", text: "Data Crumbs"

      click_on "New Data Crumb"
      fill_in "Content", with: content

      assert_selector "h1", text: "Data Crumbs"
      click_on "Create Data Crumb"

      assert_selector "h1", text: "Data Crumbs"
      assert_text content
    end
  end

  describe "Updating a Data Crumb" do
    let(:new_content) { "Capybara is still awesome!" }

    it "updates the Data Crumb and displays it in the list of Data Crumbs" do
      visit data_crumbs_path
      assert_selector "h1", text: "Data Crumbs"

      click_on "Edit", match: :first
      fill_in "Content", with: new_content

      assert_selector "h1", text: "Data Crumbs"
      click_on "Update Data Crumb"

      assert_selector "h1", text: "Data Crumbs"
      assert_text new_content
    end
  end

  describe "Destroying a quote" do
    it "destroys the Data Crumb and removes it from the list of Data Crumbs" do
      visit data_crumbs_path
      assert_text @data_crumb.content

      click_on "Delete", match: :first
      assert_no_text @data_crumb.content
    end
  end
end
