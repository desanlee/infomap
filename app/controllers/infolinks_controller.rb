class InfolinksController < ApplicationController
  # GET /infolinks
  def index
    @infolinks = Infolink.all

  end

  # GET /infolinks/1
  def show
    @infolink = Infolink.find(params[:id])

  end

  # GET /infolinks/new
  def new
    @infolink = Infolink.new

  end

  # GET /infolinks/1/edit
  def edit
    @infolink = Infolink.find(params[:id])
  end

  def updatelinkcount(from, to)
	frominfo = Infopiece.find_by_id(from)
	toinfo = Infopiece.find_by_id(to)
	frominfo.rcount += 1 if frominfo != nil
	toinfo.lcount += 1 if toinfo != nil
	frominfo.save if frominfo != nil
	toinfo.save if toinfo != nil
  end
  
  # POST /infolinks
  # POST /infolinks.json
  def create
    @infolink = Infolink.new(params[:infolink])

    respond_to do |format|
      if @infolink.save
		# Update reference count
		updatelinkcount(@infolink.frompiece_id, @infolink.topiece_id)
		
        format.html { redirect_to :back, notice: 'Infolink was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end
  
  # GET
  def buildlink
	@infolink = Infolink.new
	@infolink.frompiece_id = params[:frominfoid]
	@infolink.topiece_id = params[:toinfoid]
	
	if @infolink.save
		# Update reference count
		updatelinkcount(@infolink.frompiece_id, @infolink.topiece_id)
	end
	redirect_to root_path
  end

  def movelink
	@infolink = Infolink.new
	@infolink.frompiece_id = params[:frominfoid]
	@infolink.topiece_id = params[:toinfoid]
	@breaklinkid = params[:breaklinkid]
	@breaklink = nil
	@breaklink = Infolink.find_by_id(@breaklinkid) if @breaklinkid != 0
	
	if @infolink.save
		# Update reference count
		updatelinkcount(@infolink.frompiece_id, @infolink.topiece_id)
		@breaklink.destroy if @breaklink != nil
	end
	redirect_to root_path
  end
  
  # PUT /infolinks/1
  # PUT /infolinks/1.json
  def update
    @infolink = Infolink.find(params[:id])

    respond_to do |format|
      if @infolink.update_attributes(params[:infolink])
        format.html { redirect_to @infolink, notice: 'Infolink was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  # DELETE /infolinks/1
  # DELETE /infolinks/1.json
  def destroy
    @infolink = Infolink.find(params[:id])
	
	# Update reference count
	deducecount @infolink
		
    @infolink.destroy
	
	redirect_to :back

  end
  
  def deducecount infolink
	frominfo = Infopiece.find_by_id(infolink.frompiece_id)
	toinfo = Infopiece.find_by_id(infolink.topiece_id)
	frominfo.rcount -= 1 if frominfo != nil
	toinfo.lcount -= 1 if toinfo != nil
	frominfo.save if frominfo != nil
	toinfo.save if frominfo != nil
  end
  
end
