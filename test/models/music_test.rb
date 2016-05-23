require 'test_helper'

class MusicTest < ActiveSupport::TestCase
  # describe Music do
  #   it "uses v2 of the API" do
  #  assert_equal "http://pokeapi.co/api/v2/", Music::BASE_URL
  # end

  describe "artist" do
   before do
     @intance_of_music = Music.create("artist","1jn4AT2jGKmlUVZWmuzNP4")
   end
   it "knows its name", :vcr do
     assert_equal "Ricky Taco", @intance_of_music.name
   end

   it "knows its type", :vcr do
    assert_equal "artist", @intance_of_music.type
    end

   it "knows that it has an image url", :vcr do
     assert_instance_of String, @intance_of_music.image
   end

   it "knows that it has an open in spotify url", :vcr do
     assert_instance_of String, @intance_of_music.open_spotify_url
   end
 end

   describe "album" do
    before do
      @intance_of_music = Music.create("album","1Frb2yxLXQSaMzqnfCB1Dx")
    end
    it "knows its name", :vcr do
      assert_equal "In the Style of Shakira - Vol. 2 (Karaoke - Professional Performance Tracks)", @intance_of_music.name
    end

    it "knows its type", :vcr do
     assert_equal "album", @intance_of_music.type
     end

    it "knows that it has an image url", :vcr do
      assert_instance_of String, @intance_of_music.image
    end

    it "knows that it has an open in spotify url", :vcr do
      assert_instance_of String, @intance_of_music.open_spotify_url
    end
  end

  describe "track" do
   before do
     @intance_of_music = Music.create("track","0FC7X3BRdEJC8L4ZEUAv2Q")
   end
   it "knows its name", :vcr do
     assert_equal "Born This Way", @intance_of_music.name
   end

   it "knows its type", :vcr do
    assert_equal "track", @intance_of_music.type
    end

   it "knows that it has an image url", :vcr do
     assert_instance_of String, @intance_of_music.image
   end

   it "knows that it has an open in spotify url", :vcr do
     assert_instance_of String, @intance_of_music.open_spotify_url
   end
 end

end
