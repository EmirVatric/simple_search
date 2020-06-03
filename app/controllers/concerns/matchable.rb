module Matchable
  include ActiveSupport::Concern

  def match(string)
    vowels = {}
    ('a'..'z').to_a.zip((100..126).to_a) { |a,b| vowels[a] = b } 
    v_score = 3
    w_score = 5
    score = 0
    string.split('').each do |letter|
      score += vowels[letter] if vowels.include? letter
    end

    score += string.split(' ').count * w_score

    score += string.size

    score
  end
end