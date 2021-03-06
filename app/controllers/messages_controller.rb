class MessagesController < ApplicationController
  before_filter :authenticate_user!, except: [:create]
  require 'httparty'

  # POST /messages
  # POST /messages.json
  def create
    @message = Message.new(params[:message])
    @message.captcha_response = params["g-recaptcha-response"]

    @message.save
    @message.validate(params)
    @message.save

    unless @message.spam
      if Rails.env.production?
        secret_key = Rails.env.production? ? "6LfdAREUAAAAAFIqn4S2wBw_ow0BaFhk-0a9Yr-m" : "6LdbUhEUAAAAAMG1a8Cdlc5dnFXAu0o4N9s6TE3f"

        result = HTTParty.post "https://www.google.com/recaptcha/api/siteverify", :body => {
                               "secret" => secret_key,
                               "response" => @message.captcha_response
                                #,"remoteip" => request.remote_ip
        }

        Rails.logger.info result

        UserMailer.delay.private_message(@message.email, @message.name, @message.message, SettingUtility.settings["message_cc"])
      else
        UserMailer.private_message(@message.email, @message.name, @message.message, SettingUtility.settings["message_cc"]).deliver
      end

    else
      @message.mark_spam
      @message.save
    end

    respond_to do |format|
      format.html { redirect_to contact_path, notice: 'message was successfully created.' }
      format.json { render json: @message, status: :created, location: @message }
      format.js {
        render 'create'
      }
    end
  end

  # GET /messages
  # GET /messages.json
  def index
    @messages = Message.order('created_at desc')

    unless params["show_spam"] && params["show_spam"] == "1"
      @messages = @messages.where(spam: false)
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @messages }
    end
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
    @message = message.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @message }
    end
  end

  # GET /messages/new
  # GET /messages/new.json
  def new
    @message = Message.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @message }
    end
  end

  # GET /messages/1/edit
  def edit
    @message = message.find(params[:id])
  end


  # PUT /messages/1
  # PUT /messages/1.json
  def update
    @message = Message.find(params[:id])
    @message.published = true

    if params[:move]
      @message.position = @message.position + (params[:move] == 'up' ? -1 : 1)
      @message.save
    end

    respond_to do |format|
      if @message.update_attributes(params[:message])
        format.html { redirect_to about_path, notice: 'message was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    @message = Message.find(params[:id])
    @message.destroy

    respond_to do |format|
      format.html { redirect_to messages_url }
      format.json { head :no_content }
    end
  end
end
