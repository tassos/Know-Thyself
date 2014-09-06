class Adjective < ActiveRecord::Base
  has_and_belongs_to_many :responses
  has_and_belongs_to_many :self_responses
  
  def self.update(parameters,visibility)
    ids = []
    unless parameters.nil?
      parameters[0].split( /, */ ).uniq.each do |word|
        newAdj = Adjective.find_or_create_by_word(word.downcase)
        newAdj.visibility = visibility
        newAdj.save
        ids << newAdj.id
      end
    end
    return(ids)
  end
end