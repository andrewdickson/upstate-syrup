class SlideShowItemsController < ApplicationController
  # GET /slide_show_items
  # GET /slide_show_items.json
  def index
    @slide_show_items = SlideShowItem.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @slide_show_items }
    end
  end

  # GET /slide_show_items/1
  # GET /slide_show_items/1.json
  def show
    @slide_show_item = SlideShowItem.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @slide_show_item }
    end
  end

  # GET /slide_show_items/new
  # GET /slide_show_items/new.json
  def new
    @slide_show_item = SlideShowItem.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @slide_show_item }
    end
  end

  # GET /slide_show_items/1/edit
  def edit
    @slide_show_item = SlideShowItem.find(params[:id])
  end

  # POST /slide_show_items
  # POST /slide_show_items.json
  def create
    @slide_show_item = SlideShowItem.new(params[:slide_show_item])

    respond_to do |format|
      if @slide_show_item.save
        format.html { redirect_to @slide_show_item, notice: 'Slide show item was successfully created.' }
        format.json { render json: @slide_show_item, status: :created, location: @slide_show_item }
      else
        format.html { render action: "new" }
        format.json { render json: @slide_show_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /slide_show_items/1
  # PUT /slide_show_items/1.json
  def update
    @slide_show_item = SlideShowItem.find(params[:id])

    respond_to do |format|
      if @slide_show_item.update_attributes(params[:slide_show_item])
        format.html { redirect_to @slide_show_item, notice: 'Slide show item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @slide_show_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /slide_show_items/1
  # DELETE /slide_show_items/1.json
  def destroy
    @slide_show_item = SlideShowItem.find(params[:id])
    @slide_show_item.destroy

    respond_to do |format|
      format.html { redirect_to slide_show_items_url }
      format.json { head :no_content }
    end
  end
end
