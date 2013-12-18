class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter:authenticate_user!
  
  def index
    @infopieces = current_user.infopieces.all
  end
  
  def treeindex
    
    @infopiece = Infopiece.new
	@infolink = Infolink.new
	
	# determin what is current info selected as central and left one
	if session[:cpiece] != nil then
		if session[:lpiece] != nil then	
			# not select from left lane 
			@current_linfo = Infopiece.find_by_id(session[:lpiece])
			@current_cinfo = Infopiece.find_by_id(session[:cpiece])
		elsif Infopiece.find_by_id(session[:cpiece]).frompieces.empty?	
			# select info from left lane as current info and no more left info existed
			@current_linfo = Infopiece.find_by_id(session[:cpiece])
			session[:lpiece] = session[:cpiece]
		else
			# select info from left lane as current info and have more left info existed
			@current_linfo = Infopiece.find_by_id(session[:cpiece]).frompieces.first if Infopiece.find_by_id(session[:cpiece]).frompieces != nil
		end
	end
	
	if @current_cinfo == nil then
		if @current_linfo == nil then
			@current_linfo = current_user.infopieces.find(:first, :conditions => "lcount=0")
		end
		@current_cinfo = @current_linfo.topieces.first if @current_linfo.topieces != nil
	end
	
	# calculate the infopiece list for each cols
	@lpieces = @current_cinfo.frompieces if @current_cinfo != nil
	@rootpieces = nil
	if @current_linfo != nil then
		if @current_linfo.lcount == 0 then
			@rootpieces = current_user.infopieces.find(:all, :conditions => "lcount=0 and rcount!=0")
		end
	end
	
	@rlinks = @current_cinfo.tolinks if @current_cinfo != nil
	@clinks = @current_linfo.tolinks if @current_linfo != nil
	
  end
  
  def poolindex
    @infopieces = current_user.infopieces.find(:all, :conditions => " lcount=0 and rcount=0")
    @infopiece = Infopiece.new
	@infolink = Infolink.new
  end
  
  def setcurrent
	session[:cpiece] = params[:selectpiece]
	session[:lpiece] = params[:parentpiece]
	
	redirect_to root_path
  end
  
end
