class Infopiece < ActiveRecord::Base
  attr_accessible :content, :user_id
  
  belongs_to :user
  
  has_many :tolinks, :foreign_key => "frompiece_id", :class_name => "Infolink", dependent: :destroy
  has_many :fromlinks, :foreign_key => "topiece_id", :class_name => "Infolink", dependent: :destroy
  
  has_many :topieces, :through => :tolinks, :source => :topiece
  has_many :frompieces, :through => :fromlinks, :source => :frompiece
  
end
