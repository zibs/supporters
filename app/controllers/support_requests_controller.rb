class SupportRequestsController < ApplicationController
  before_action :find_support_request, only: [:show, :edit, :update, :destroy]

  def index
    # @support_requests = SupportRequest.order("created_at ASC")
    @support_requests = SupportRequest.order("complete ASC").page(params[:page]).per(7)
#Write a SQL query that returns a sorted list of the departments and the number of support requests per each department
# ...not quite...
    # @sorted_requests = SupportRequest.order("department ASC").group(:department).count
  end

  def new
    @support_request = SupportRequest.new
  end

  def create
    @support_request = SupportRequest.new(support_request_params)
    if @support_request.save
      flash[:notice] = "Support Request Successfully Submitted"
      redirect_to support_request_path(@support_request)
    else
      flash[:alert] = "Support Request Unsuccessful "
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    # if @support_request.update_attribute(:complete, support_request_params[:complete])
        # redirect_to support_requests_path
    if @support_request.update(support_request_params)
      # redirect to index instead of individual page
      redirect_to support_requests_path, notice: "Updated!"
      # redirect_to support_request_path(@support_request)
    else
      flash[:alert] = "Support Request not updated -- Please check errors below"
      render :edit
    end
  end

  def destroy
    @support_request.destroy
    redirect_to root_path, alert: "Support Request Deleted"
  end

  def search
    if params[:search_term]
     @search_term = params[:search_term]
     @search_results = SupportRequest.search_requests(params[:search_term]).page(params[:page]).per(7)
    end
  end

        private

        def support_request_params
           params.require(:support_request).permit([:name, :email, :department, :message, :complete])
        end

        def find_support_request
          @support_request = SupportRequest.find(params[:id])
        end

end
