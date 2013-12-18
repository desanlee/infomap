class Infolink < ActiveRecord::Base
  attr_accessible :frompiece_id, :topiece_id
  
  belongs_to :frompiece, :class_name => "Infopiece", :foreign_key => :frompiece_id
  belongs_to :topiece, :class_name => "Infopiece", :foreign_key => :topiece_id
  
end
