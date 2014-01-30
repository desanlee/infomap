class Infolink < ActiveRecord::Base
  attr_accessible :frompiece_id, :topiece_id, :index_id
  
  belongs_to :frompiece, :class_name => "Infopiece", :foreign_key => :frompiece_id
  belongs_to :topiece, :class_name => "Infopiece", :foreign_key => :topiece_id
  
  default_scope order: 'infolinks.index_id ASC'
  
  def destroy
  	frominfo = Infopiece.find_by_id(self.frompiece_id)
	toinfo = Infopiece.find_by_id(self.topiece_id)
	frominfo.rcount -= 1 if frominfo != nil
	toinfo.lcount -= 1 if toinfo != nil
	frominfo.save if frominfo != nil
	toinfo.save if frominfo != nil
	
	self.delete
  end
  
end
