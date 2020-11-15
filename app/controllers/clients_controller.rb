class ClientsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_client, only: [:show, :edit, :update, :destroy]
  def index 
    @clients = current_user.clients
  end

  def show 
    
  end

  def new 
    @client = Client.new
  end 

  def create 
    @client = current_user.clients.build(client_params)
    if @client.save 
      redirect_to client_path(@client)
    else 
      render :new
    end
  end 

  def edit 

  end 

  def update 
    if @client.update(client_params)
      redirect_to client_path(@client)
    else 
      render :edit
    end
  end 
  
  def destroy 
    @client.destroy 
    redirect_to clients_path
  end

  private 

  def set_client 
    @client = current_user.clients.find(params[:id])
  end

  def client_params
    params.require(:client).permit(:name)
  end
end
