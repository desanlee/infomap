class Infopiece < ActiveRecord::Base
  attr_accessible :content, :user_id, :lcount, :rcount
  
  belongs_to :user
  
  has_many :tolinks, :foreign_key => "frompiece_id", :class_name => "Infolink", dependent: :destroy
  has_many :fromlinks, :foreign_key => "topiece_id", :class_name => "Infolink", dependent: :destroy
  
  has_many :topieces, :through => :tolinks, :source => :topiece
  has_many :frompieces, :through => :fromlinks, :source => :frompiece
  
  default_scope order: 'infopieces.created_at DESC'
  
  def briefcontent
	if self.content.length <= 23 then return self.content
	else
		return self.content.slice(0,23) + "..."
	end
  end
  
  def shortcontent
  	if self.content.length <= 16 then return self.content
	else
		return self.content.slice(0,16) + "..."
	end
  end
  
  def htmlcontent
	return self.content.gsub("\r\n",'<br>').gsub("\r",'<br>')
  end

end
