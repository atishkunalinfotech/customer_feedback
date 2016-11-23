class Admin::NatureOfReviewsController < ApplicationController
  before_action :set_admin_nature_of_review, only: [:show, :edit, :update, :destroy]

  # GET /admin/nature_of_reviews
  # GET /admin/nature_of_reviews.json
  def index
    @admin_nature_of_reviews = Admin::NatureOfReview.all
  end

  # GET /admin/nature_of_reviews/1
  # GET /admin/nature_of_reviews/1.json
  def show
  end

  # GET /admin/nature_of_reviews/new
  def new
    @admin_nature_of_review = Admin::NatureOfReview.new
  end

  # GET /admin/nature_of_reviews/1/edit
  def edit
  end

  # POST /admin/nature_of_reviews
  # POST /admin/nature_of_reviews.json
  def create
    @admin_nature_of_review = Admin::NatureOfReview.new(admin_nature_of_review_params)

    respond_to do |format|
      if @admin_nature_of_review.save
        format.html { redirect_to @admin_nature_of_review, notice: 'Nature of review was successfully created.' }
        format.json { render :show, status: :created, location: @admin_nature_of_review }
      else
        format.html { render :new }
        format.json { render json: @admin_nature_of_review.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/nature_of_reviews/1
  # PATCH/PUT /admin/nature_of_reviews/1.json
  def update
    respond_to do |format|
      if @admin_nature_of_review.update(admin_nature_of_review_params)
        format.html { redirect_to @admin_nature_of_review, notice: 'Nature of review was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin_nature_of_review }
      else
        format.html { render :edit }
        format.json { render json: @admin_nature_of_review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/nature_of_reviews/1
  # DELETE /admin/nature_of_reviews/1.json
  def destroy
    @admin_nature_of_review.destroy
    respond_to do |format|
      format.html { redirect_to admin_nature_of_reviews_url, notice: 'Nature of review was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_nature_of_review
      @admin_nature_of_review = Admin::NatureOfReview.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_nature_of_review_params
      params.require(:admin_nature_of_review).permit(:title, :user_id, :review_type)
    end
end
