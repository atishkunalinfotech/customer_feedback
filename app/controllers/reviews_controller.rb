class ReviewsController < ApplicationController
	before_filter :authenticate_user!, :only=>[:edit ,:update, :delete]
	before_filter :get_default_for_reviews, :except =>[:index, :show]
	before_action :default_action_tab

	def index
    @active_title ="My Reviews"
  	@sub_action = 'my_reviews'
		@reviews = current_user ? current_user.reviews.published : []
	end
	
	def search_reviews
    @action = "review"
    @active_tab = "review"
    @reviews = []
    if params[:town_id]
      town = Town.find(params[:town_id])
      @reviews = town.reviews if town 
    elsif params[:supplier_id]
      supplier = Supplier.find(params[:supplier_id])
      comments = supplier.comments
      @reviews = []
      comments.each do |comment|
        @reviews << comment.review  
      end
      # @reviews = supplier.reviews if supplier 
    elsif params[:location_id] 
      location = Location.find params[:location_id]
      @reviews = location.reviews.where("ispublished = ?", true) if location 
    elsif params[:company_id]
      company = Company.includes(:reviews).find(params[:company_id])
      @reviews = company.reviews.where("ispublished = ?", true).order("date DESC") if company
    elsif params[:review_type]
    	@reviews = @reviews.where("review_type=? AND ispublished = ?",params[:review_type],true)
    end
	end

	def new
    @active_title = params["review_type"]
    if current_user.try(:role) == "admin" ||  current_user.try(:role) == 'agent' || current_user.try(:role) == 'jagent' 
      redirect_to admin_index_path
    else
      #@page = Page.find_by_slug("how-to-write-good-review")
      @nature_of_reviews = Admin::NatureOfReview.where("review_type = ?",params[:review_type]) if params[:review_type].present?
      if params[:id].present?
       @review = Review.find(params[:id])
       @companies = Industry.find(@review.industry_id).companies.order(:title)
       @towns = Company.find(@review.company_id).towns.order(:title).uniq!
       @file = @review.file rescue nil
       addresses = Address.find_all_by_town_id_and_company_id(@review.town_id,@review.company_id)
       @locations = addresses.map {|a| a.location}
       @locations = @locations.sort_by { |k| k["title"] }
       @locations.uniq!
      else
  		 @review = Review.new
      end
    end
	end

	def show
    @active_title = "Review Details"
    @active_tab = "Detailed Review"
    @review = Review.find(params[:id])
    if @review.ispublished?
    else
      redirect_to reviews_path
    end
  end

  def chang_review_status
    if @review.change_date.nil?
      @review.change_date = DateTime.now
    else
      @review.change_date = nil
    end
  end

  def update
    # raise params[:review][:file].present?.inspect
    @review = Review.find(params[:id])
    if params[:review][:file].present?
      @review.file = params[:review][:file]
    end
    # raise @review.file.inspect
    unless params[:review][:guest] == "guest_user"
      if params[:sad]
        @review.review_type = "complaint"
      elsif params[:happy]
        @review.review_type = "compliment"
      end
      if @review.update_attributes(review_params)
          flash[:notice] = "Rating revised. Your revised rating has been successfully updated. Thank you for your contribution."
          redirect_to @review
      else
          render  :edit
      end
    else
      # if verify_recaptcha
        if @review.update_attributes(review_params)
          if current_user
            ReviewMailer.delay.user_mail(@review)
            ReviewMailer.delay.agent_mail(@review)
            user = User.find(current_user.id) rescue nil
            user.update_column(:guest_token, nil) rescue nil
            flash[:notice] = "Your review has been successfully submitted."
            redirect_to root_path
          else
            render :new
          end
        else
          render  :new
        end
      # else
      #   flash[:alert] = "There was an error with the recaptcha code below. Please re-enter the code."      
      #   flash.delete :recaptcha_error
      #   redirect_to :back
      # end
    end
  end 

	def create
    dt = Date.parse(params[:review][:date])
    hr = params["review"]["datetime(4i)"]
    min = params["review"]["datetime(5i)"]
    
    t = DateTime.new(dt.year, dt.month, dt.day, hr.to_i, min.to_i,0)
    nature = params[:nature] if params[:nature].present?
    kenyan_time = Time.now.utc + 3.hour
    industry = params[:other_type].to_s
    company  = params[:txt_review_company_id].to_s
    town     = params[:txt_review_town_id].to_s
    location = params[:txt_review_location_id].to_s

    @review ||= Review.new(review_params) 
    current_user.present? ? @review.user_id = current_user.id : @review.guest_token = generate_token

    if t > kenyan_time
      @nature = nature if params[:nature].present?
      @companies = Industry.find(@review.industry_id).companies.order(:title)
      @towns = Company.find(@review.company_id).towns.order(:title).uniq!
      addresses = Address.find_all_by_town_id_and_company_id(@review.town_id,@review.company_id)
      if location.present?
        @locations = addresses.map {|a| a.location}
        @locations = @locations.sort_by { |k| k["title"] }
        @locations.uniq!
      end
      @nature_of_reviews = NatureOfReview.where("review_type = ?",@review.review_type)
      flash[:notice] = "Please select past date"
      render :new
    else
      if params[:nature].present?
        nature_of_review = NatureOfReview.find_or_create_by(:title => nature)
        nature_of_review.review_type = @review.review_type
        nature_of_review.save
        @review.nature_of_review = nature_of_review.title
      end
      if (industry.present?)
        industry_db = Industry.find_or_create_by(:title => industry)
        @review.industry_id = industry_db.id
      end

      if (company.present?)
        company_db = Company.find_or_create_by(:title => company, :industry_id => @review.industry_id)
        @review.company_id = company_db.id
      end

      if (town.present?)
        town_db = Town.find_or_create_by(:title=>town)
        @review.town_id = town_db.id
      end

      if (location.present?)
        location_db = Location.find_or_create_by(:title=>location, :town_id=>@review.town_id)
        @review.location_id = location_db.id
      end

      Address.find_or_create_by(:town_id=>@review.town_id, :location_id=>@review.location_id, :company_id=>@review.company_id )
      if params["nature"].present?
          @review.nature_of_review = params["nature"]
      end
  	  #if verify_recaptcha
        if @review.save
          if current_user
            #ReviewMailer.delay.user_mail(@review)
            #ReviewMailer.delay.agent_mail(@review)
            flash[:notice] = "Review submitted. Your review has been successfully submitted and assigned a ticket number. However, it will only be published once it has been vetted by our team against our Terms and Conditions. You will receive an email confirming your ticket number."
            redirect_to root_path
          else
            flash[:notice] = "Please LOGIN or REGISTER to submit your review."
            redirect_to new_user_session_url(:guest_token => @review.guest_token)
          end
        else
          @nature_of_reviews = NatureOfReview.where("review_type = ?",@review.review_type)
          render :new
        end
      # else
      
      # @companies = Industry.find(@review.industry_id).companies.order(:title)
      # @towns = Company.find(@review.company_id).towns.order(:title).uniq!
      # addresses = Address.find_all_by_town_id_and_company_id(@review.town_id,@review.company_id)
      # if location.present?
      #   @locations = addresses.map {|a| a.location}
      #   @locations = @locations.sort_by { |k| k["title"] }
      #   @locations.uniq!
      # end
      #  @nature_of_reviews = NatureOfReview.where("review_type = ?",@review.review_type)
      #   flash.now[:alert] = "There was an error with the recaptcha code below. Please re-enter the code."      
      #   flash.delete :recaptcha_error
      #   render :new
      # end
    end
  end

  def companies_by_industry
    raise "hiiiiiii"
    if params[:id].present?
      @companies = Industry.find(params[:id]).companies.order(:title)
    else
      @companies = []
    end
    respond_to do |format|
      format.js
    end
  end

  def towns_by_company
    if params[:id].present?
      @towns = Company.find(params[:id]).towns.order(:title).uniq!
    else
      @towns = []
    end
    respond_to do |format|
      format.js
    end
  end 

  def locations_by_town_and_company
    if params[:id].present? and params[:company_id].present?
      addresses = Address.find_all_by_town_id_and_company_id(params[:id],params[:company_id])
      @locations = addresses.map {|a| a.location}
      @locations = @locations.sort_by { |k| k["title"] }
      @locations.uniq!
    else
      @locations = []
    end
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to admin_reviews_path
  end

	private

	def get_default_for_reviews
		@industries = Industry.all.order(:title)
		@companies = []
		@towns = []
		@locations = []
  end

	def review_params
      params.require(:review).permit(:title, :industry_id, :company_id, :date, :town_id,:datetime, 
                                     :location_id, :personal_responsible, :nature_of_review,:message,
                                     :account_details,:ticket_number,:user_id, :token_number,:review_type,
                                     :file,:nature,:desired_outcome,:file_cache)
  end

	def default_action_tab
	  	@action = "my_account"
	end

	def generate_token
		SecureRandom.urlsafe_base64
	end
end
