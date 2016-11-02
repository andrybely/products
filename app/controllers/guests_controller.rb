class GuestsController < ApplicationController
  # before_action :set_current_guest, except: [:show]
  # before_action :authenticate_user!, except: [:show]


  # GET /guests/1
  def show
    @guest = Guest.find(params[:id])
  end

  # GET /guests/new
  def new
    @guest = Guest.new
  end

  # GET /guests/1/edit
  def edit
    @guest = Guest.find(params[:id])
  end

  # POST /guests
  def create
    @guest = Guest.new(guest_params)

    if @guest.save
      session[:user_id] = @guest.id
      redirect_to @guest, notice: 'Guest was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /guests/1
  def update
    if @guest.update(guest_params)
      redirect_to @guest, notice: 'Guest was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /guests/1
  def destroy
    @guest.destroy
    redirect_to products_path, notice: 'Guest was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_current_guest
      @guest = current_guest
    end

    # Only allow a trusted parameter "white list" through.
    def guest_params
      params.require(:guest).permit(:email, :password, :password_confirmation, :current_password)
    end
end
