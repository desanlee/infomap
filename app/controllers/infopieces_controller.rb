class InfopiecesController < ApplicationController
  # GET /infopieces
  def index
    @infopieces = current_user.infopieces

  end

  # GET /infopieces/1
  def show
    @infopiece = Infopiece.find(params[:id])

  end

  # GET /infopieces/new
  def new
    @infopiece = Infopiece.new

  end

  # GET /infopieces/1/edit
  def edit
    @infopiece = Infopiece.find(params[:id])
  end

  # POST /infopieces
  def create
    @infopiece = Infopiece.new(params[:infopiece])
	@infopiece.user_id = current_user.id
	@infopiece.lcount = 0
	@infopiece.rcount = 0
	
    respond_to do |format|
      if @infopiece.save
        format.html { redirect_to :back, notice: 'Infopiece was successfully created.' }
        format.json { render json: @infopiece, status: :created, location: @infopiece }
      else
        format.html { render action: "new" }
        format.json { render json: @infopiece.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /infopieces/1
  def update
    @infopiece = Infopiece.find(params[:id])

    respond_to do |format|
      if @infopiece.update_attributes(params[:infopiece])
        format.html { redirect_to @infopiece, notice: 'Infopiece was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @infopiece.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /infopieces/1
  def destroy
    @infopiece = Infopiece.find(params[:id])
    @infopiece.destroy

	redirect_to :back 
  end
  
end
