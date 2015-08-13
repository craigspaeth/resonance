require 'test_helper'

class ArtistTest < ActiveSupport::TestCase
  test "validity" do
    assert artists(:andy).valid?
    assert artists(:lorna).valid?
  end
end
