class SlideShowItemsController < ApplicationController
  # GET /slide_show_items
  # GET /slide_show_items.json
  def index
    @slide_show_items = SlideShowItem.all
    @settings = SettingUtility.settings

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @slide_show_items }
      format.js { render 'index' }
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
    @settings = SettingUtility.settings

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @slide_show_item }
    end
  end

  # GET /slide_show_items/1/edit
  def edit
    @slide_show_item = SlideShowItem.find(params[:id])
    @settings = SettingUtility.settings

  end

  # POST /slide_show_items
  # POST /slide_show_items.json
  def create
    @slide_show_item = SlideShowItem.new(params[:slide_show_item])
    @slide_show_item.extract_dimensions

    respond_to do |format|
      if @slide_show_item.save
        format.html { redirect_to pictures_path, notice: 'Slide show item was successfully created.' }
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

    if params[:move]
      @slide_show_item.position = @slide_show_item.position + (params[:move] == 'up' ? -1 : 1)
      @slide_show_item.save
    else
      @slide_show_item.extract_dimensions
    end

    respond_to do |format|
      if @slide_show_item.update_attributes(params[:slide_show_item])
        format.html { redirect_to pictures_path, notice: 'Slide show item was successfully updated.' }
        format.json { head :no_content }
        format.js {
          @slide_show_items = SlideShowItem.order('position asc')

          render 'index'}
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
      format.js {
        @slide_show_items = SlideShowItem.order('position asc')
        render 'index'
      }
    end
  end

  def settings
    @settings = SettingUtility.settings
    @settings['max-height'] = params['max-height']
    @settings['max-width'] = params['max-width']
    @settings['min-height'] = params['min-height']
    @settings['min-width'] = params['min-width']
    @settings['brand'] = params['brand']
    @settings['about_heading'] = params['about_heading']
    @settings['home_heading'] = params['home_heading']
    @settings['about_heading'] = params['about_p']
    @settings['home_p'] = params['home_p']

    SettingUtility.SaveSettings(@settings)

    #File.open("#{Rails.root}/config/settings.yml", 'w') {|f| f.write @settings.to_yaml }
    redirect_to pictures_path
  end

end
