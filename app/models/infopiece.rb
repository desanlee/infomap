class Infopiece < ActiveRecord::Base
  attr_accessible :content, :user_id, :lcount, :rcount, :labelstr
  
  belongs_to :user
  
  has_many :tolinks, :foreign_key => "frompiece_id", :class_name => "Infolink", dependent: :destroy
  has_many :fromlinks, :foreign_key => "topiece_id", :class_name => "Infolink", dependent: :destroy
  
  has_many :topieces, :through => :tolinks, :source => :topiece
  has_many :frompieces, :through => :fromlinks, :source => :frompiece
  
  default_scope order: 'infopieces.created_at DESC'
  
  def briefcontent
	if self.content.length <= 19 then return self.content
	else
		return self.content.slice(0,19) + "..."
	end
  end
  
  def halfbriefcontent
	if self.content.length <= 9 then return self.content
	else
		return self.content.slice(0,9) + ".."
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
  
  def twikitable
	string = ""
	if self.rcount == 0 then
		string = "|" + self.htmlcontent + "\r\n"
	else
		string = "| rowspan=" + self.rcount.to_s + '" |' + self.htmlcontent
		self.topieces.each do |cp|
			string = string + cp.twikitable
		end
	end
	return string
  end

end
