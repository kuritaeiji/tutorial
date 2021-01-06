require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the ApplicationHelperHelper. For example:
#
# describe ApplicationHelperHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe ApplicationHelper, type: :helper do
  describe('full title') do
    it('タイトルがあれば長いタイトルを返す') do
      expect(helper.full_title('title')).to eq('title | rails tutorial')
    end

    it('タイトルが無ければデフォルトのタイトルを返す') do
      expect(helper.full_title).to eq('rails tutorial')
    end
  end
end
