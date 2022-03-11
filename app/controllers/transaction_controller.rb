class TransactionController < ApplicationController
  before_action :logged_in_user

	def create
      @transaction = Transaction.new(transactions_params)
      #@transaction.customer = current_user
      #redirect_to transactions_path
      if @transaction.save!
      render json: @transaction.to_json
      end	
	end

	def index
	  @transaction = Transaction.all		
	end

	def show
      @transaction = Transaction.find(params[:id])
	end

	private

	def transactions_params
	  params.require(:transaction).permit(:amount, :currency, :customer_id)	
	end

	def transaction_owner
	  @transaction = Transaction.find(params[:id])
	  redirect_to transactions_path unless current_user == current_customer
	end
end
