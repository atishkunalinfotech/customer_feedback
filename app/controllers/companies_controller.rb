# class CompaniesController < ApplicationController
#   before_action :set_company, only: [:show, :edit, :update, :destroy]

#   # GET /companies
#   # GET /companies.json
#   def index
#     @companies = Company.all
#   end

#   # GET /companies/1
#   # GET /companies/1.json
#   def show
#   end

#   # GET /companies/new
#   def new
#     @company = Company.new
#   end

#   # GET /companies/1/edit
#   def edit
#   end

#   # POST /companies
#   # POST /companies.json
#   def create
#     @company = Company.new(company_params)

#     respond_to do |format|
#       if @company.save
#         format.html { redirect_to @company, notice: 'Company was successfully created.' }
#         format.json { render :show, status: :created, location: @company }
#       else
#         format.html { render :new }
#         format.json { render json: @company.errors, status: :unprocessable_entity }
#       end
#     end
#   end

#   # PATCH/PUT /companies/1
#   # PATCH/PUT /companies/1.json
#   def update
#     respond_to do |format|
#       if @company.update(company_params)
#         format.html { redirect_to @company, notice: 'Company was successfully updated.' }
#         format.json { render :show, status: :ok, location: @company }
#       else
#         format.html { render :edit }
#         format.json { render json: @company.errors, status: :unprocessable_entity }
#       end
#     end
#   end

#   # DELETE /companies/1
#   # DELETE /companies/1.json
#   def destroy
#     @company.destroy
#     respond_to do |format|
#       format.html { redirect_to companies_url, notice: 'Company was successfully destroyed.' }
#       format.json { head :no_content }
#     end
#   end

#   private
#     # Use callbacks to share common setup or constraints between actions.
#     def set_company
#       @company = Company.find(params[:id])
#     end

#     # Never trust parameters from the scary internet, only allow the white list through.
#     def company_params
#       params.require(:company).permit(:title, :user_id, :industry_id, :is_registered)
#     end
# end


class CompaniesController < ApplicationController
  before_filter :get_default_for_filter
  before_action :default_action_tab, :only=>[:conversions, :registered, :unregistered, :polls_bloopers]

  def default_action_tab
    @action = "my_account"
  end

  def user_review
    @nav_tab = "reviews"
    @active_tab = "reviews"
    @active_title = "Reviews"
    @reviews ||= Review.published.order("date")
    review = Review.new(review_params)
    @review_filter = review

    if review.review_type
      @reviews = @reviews.by_review_type review.review_type
    end
    
    if review.industry_id && review.industry_id !=0
      @reviews = @reviews.by_industry(review.industry_id)
    end

    if review.company_id && review.company_id !=0
      @reviews = @reviews.by_company(review.company_id)
    end
    
    if review.town_id && review.town_id !=0
      @reviews = @reviews.by_town(review.town_id)
    end
    
    if review.from_date && review.to_date

      @reviews = @reviews.within_range(review.from_date.to_date,review.to_date.to_date)
    end
  end

  def conversions
    @nav_tab = "reviews"
    @active_tab = "conversions"
    review = Review.new(review_params)
    @review_filter = review
    @rcompanies ||= Supplier.all

    if review.industry_id  && review.industry_id !=0
      @rcompanies = @rcompanies.by_industry(review.industry.title)
    end

    if review.company_id  && review.company_id !=0
      @rcompanies = @rcompanies.by_company(review.company.title)
    end
    
#    if review.town_id && review.town_id !=0
#     @rcompanies = @rcompanies.by_town(review.town_id)
#    end
    
    if review.from_date && review.to_date
      @rcompanies = @rcompanies.within_range(review.from_date.to_date,review.to_date.to_date)
    end
      
  end


  def registered
    @nav_tab = "reviews"
    @active_tab = "registered_companies"
    review = Review.new(review_params)
    @review_filter = review
    @rcompanies ||= Supplier.registered

    if review.industry_id  && review.industry_id !=0
      @rcompanies = @rcompanies.by_industry(review.industry.title)
    end
    
    if review.company_id && review.company_id !=0
      @rcompanies = @rcompanies.by_company(review.company.title)
    end
    
#    if review.town_id && review.town_id !=0
#     @rcompanies = @rcompanies.by_town(review.town_id)
#    end
    
    if review.from_date && review.to_date
      @rcompanies = @rcompanies.within_range(review.from_date.to_date,review.to_date.to_date)
    end
  end

  def unregistered
    @nav_tab = "reviews"
    @active_tab = "unregistered_companies"
    review = Review.new(review_params)
    @review_filter = review
    @rcompanies ||= Supplier.un_registered

    if review.industry_id && review.industry_id !=0
      @rcompanies = @rcompanies.by_industry(review.industry.title)
    end
    
    if review.company_id && review.company_id !=0
      @rcompanies = @rcompanies.by_company(review.company.title)
    end
    
#    if review.town_id && review.town_id !=0
#     @rcompanies = @rcompanies.by_town(review.town_id)
#     end
    
    if review.from_date && review.to_date
      @rcompanies = @rcompanies.within_range(review.from_date.to_date,review.to_date.to_date)
    end
  end

  def polls_bloopers
     @nav_tab = "reviews"
    @active_tab = "polls & bloopers"
    @section = 'polls-bloopers'
    @sub_action = 'polls-bloopers'
    @polls = Poll.all
    review = Review.new(review_params)
    if review.from_date && review.to_date
      @polls = Poll.where("Date(created_at) >= ? AND Date(created_at) <= ?",review.from_date.to_date,review.to_date.to_date)
    end
  end
  
  private

  def get_default_for_filter
    @industries = Industry.all.order(:title)
    @companies = []
    @towns = []
    @locations = []
  end

  def review_params
    if params[:review].present?
      params.require(:review).permit(:industry_id, :company_id, :review_type, :location_id, :town_id, :from_date, :to_date)
    end
  end
end

