ENV["CONVERTER_ENV"] = "test"
require "converter"

describe Converter do
  describe "Number to convert into words: 6686787825" do
    it "Should search all key combinations against dictionary and get matching words. Min word length is 3" do
      expect(Converter.new.get_key_combinations("6686787825"))
                          .to eq([["noun", "struck"], 
                                  ["onto", "struck"], 
                                  ["motor", "truck"], 
                                  ["motor", "usual"], 
                                  ["nouns", "truck"], 
                                  ["nouns", "usual"], 
                                  "motortruck"])
    end
  end

  describe "Number to convert into words: 2282668687" do
    it "Should search all key combinations against dictionary and get matching words. Min word length is 3" do
      expect(Converter.new.get_key_combinations("2282668687"))
                          .to eq([["act", "amounts"], 
                                  ["act", "contour"], 
                                  ["bat", "amounts"], 
                                  ["bat", "contour"], 
                                  ["cat", "amounts"], 
                                  ["cat", "contour"], 
                                  ["acta", "mounts"], 
                                  "catamounts"])
    end
  end
end