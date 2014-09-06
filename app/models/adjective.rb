class Adjective < ActiveRecord::Base
  has_and_belongs_to_many :responses
  has_and_belongs_to_many :self_responses
  
  def self.update(parameters,visibility)
    
    sanite=[]
    parameters[0].split( /, */ ).uniq.each do |word|
      sanite << (word.length < 255)
    end
    
    if sanite.all?
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
    else
      return('error')
    end
  end
  
end