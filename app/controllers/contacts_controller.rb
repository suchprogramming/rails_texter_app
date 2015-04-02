class ContactsController < ApplicationController

  before_filter :authenticate_user!

  def index
    @contacts = Contact.all
  end

  def new
    @contact = Contact.new
  end

  def show
    @contact = Contact.find(params[:id])
  end

  def create
    @contact = current_user.contacts.new(contact_params)
    if @contact.save
      flash[:success] = "Contact Added!"
      redirect_to contacts_path
    else
      render :new
    end
  end

  def edit
    @contact = Contact.find(params[:id])
  end

  def update
    @contact = Contact.find(params[:id])
    if current_user.id == @contact.user_id
      @contact.update(contact_params)
      flash[:success] = 'Contact Successfully Updated!'
      redirect_to contact_path
    else
      render :edit
    end
  end

  def destroy
    @contact = Contact.find(params[:id])
    if current_user.id == @contact.user_id
      @contact.destroy
      flash[:success] = 'Contact Successfully Deleted!'
      redirect_to contacts_path
    else
      flash[:danger] = "Not So Fast!"
      redirect_to contacts_path
    end
  end

  private
  def contact_params
    params.require(:contact).permit(:first_name, :last_name, :phone_number)
  end
end
