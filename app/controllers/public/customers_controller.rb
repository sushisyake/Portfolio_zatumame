class Public::CustomersController < ApplicationController
  before_action :is_matching_login_customer, only: [:edit, :update]
   before_action :ensure_guest_customer, only: [:edit]

  def show
    @customer = Customer.find(params[:id])
    @articles = @customer.articles
    @article = Article.new
  end

  def index
    @customers = Customer.all
    @article = Article.new

  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    @customer.update(customer_params)
    # if @customer.save
    #   flash[:notice] = "You have updated customer successfully."
    #   redirect_to customer_path(@customer)
    # else
    #   render :edit
    # end
  end

  private

  def customer_params
    params.require(:customer).permit(:nickname, :introduction)
  end

  def is_matching_login_customer
    customer_id = params[:id].to_i
   login_customer_id = current_customer.id
    if(customer_id != login_customer_id)
      redirect_to customer_path(current_customer)
    end
  end

  def ensure_guest_customer
    @customer = Customer.find(params[:id])
    if @customer.nickname == "guestcustomer"
      redirect_to customer_path(current_customer) , notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
  end

end