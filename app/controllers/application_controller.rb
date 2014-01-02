class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter:authenticate_user!
  
  def index
    @infopieces = current_user.infopieces.all
  end
  
  def treeindex
    
	@infopieces = current_user.infopieces.find(:all, :conditions => " lcount=0 and rcount=0")
    @infopiece = Infopiece.new
	@infolink = Infolink.new
	
	@rootpieces = current_user.infopieces.find(:all, :conditions => "lcount=0 and rcount!=0")
	
	@current_cinfo = Infopiece.find_by_id(session[:cpiece]) if session[:cpiece] != nil
	@current_cinfo = @rootpieces.first if @current_cinfo == nil
	if ! @current_cinfo.frompieces.empty? then
		# selected info is not a root
		@current_linfo = @current_cinfo.frompieces.first 
		session[:test] = 11
	else
		# selected info is a root
		@current_linfo = @current_cinfo
		@current_cinfo = @current_linfo.topieces.first if !@current_linfo.topieces.empty?
		session[:cpiece] = @current_cinfo.id
		session[:test] = 22
	end
	@rootpieces = @rootpieces - [ @current_linfo ] if @current_linfo != nil
	
	@lpieces = @current_cinfo.frompieces if @current_cinfo != nil
	
	@llinks = Array.new
	@lpieces.each do |p| 
		tmplink = Infolink.new
		tmplink.frompiece_id = 0
		tmplink.topiece_id = p.id
		@llinks << tmplink
	end
	@rlinks = @current_cinfo.tolinks if @current_cinfo != nil
	@clinks = @current_linfo.tolinks if @current_linfo != nil
	
  end
  
  def poolindex

  end
  
  def setcurrent
	session[:cpiece] = params[:selectpiece]
	
	redirect_to root_path
  end
  
end
