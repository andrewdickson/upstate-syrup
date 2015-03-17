class AdminController < ApplicationController
  before_filter :authenticate_user!

  def index
  end

  def new
    @user = User.new
  end


  def content
    @settings = SettingUtility.settings

    @about_content = Content.find_by_name('about_image')  || Content.new
    @logo_content = Content.find_by_name('logo')  || Content.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save

      saved_user = current_user

      sign_out saved_user
      sign_in @user

      sign_out @user
      sign_in saved_user

      redirect_to admin_path
    end

  end


  def update
    @settings = SettingUtility.settings
    @settings['max-height'] = params['max-height'] if params['max-height']
    @settings['max-width'] = params['max-width'] if params['max-width']
    @settings['min-height'] = params['min-height'] if params['min-height']
    @settings['min-width'] = params['min-width'] if params['min-width']
    @settings['brand'] = params['brand'] if params['brand']
    @settings['about_heading'] = params['about_heading'] if params['about_heading']
    @settings['home_heading'] = params['home_heading'] if params['home_heading']
    @settings['about_p'] = params['about_p'] if params['about_p']
    @settings['home_p'] = params['home_p'] if params['home_p']
    SettingUtility.SaveSettings(@settings)

    if params[:content]
      if params[:content][:image]
        @about_content = Content.find_by_name('about_image')
        @about_content = Content.new(name: 'about_image') if !@about_content
        @about_content.image = params[:content][:image]
        @about_content.save
      elsif params[:content][:logo]
        @logo_content = Content.find_by_name('logo')
        @logo_content = Content.new(name: 'logo') if !@logo_content
        @logo_content.image = params[:content][:logo]
        @logo_content.save
      end
    end


    respond_to do |format|
        format.html { redirect_to (params['home_p'] ? content_path : pictures_path) }
        format.json { head :no_content }
        format.js {
          render 'update' }
    end

  end

end
