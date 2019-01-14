class FeedbacksController < ApplicationController
  before_action :set_feedback, only: [:show, :edit, :update, :destroy]
  before_action :user_admin_checker, only: [:index]

  def index
    @feedbacks = Feedback.all
  end

  def new
    @feedback = Feedback.new
  end

  def create
    @feedback = Feedback.new(feedback_params)
    @feedback.user = current_user unless current_user.nil?

    respond_to do |format|
      if @feedback.save
        format.html { redirect_to @feedback, notice: 'Feedback was successfully created.' }
        format.json { render :show, status: :created, location: @feedback }
      else
        format.html { render :new }
        format.json { render json: @feedback.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @feedback.update(feedback_params)
        format.html { redirect_to @feedback, notice: 'Feedback was successfully updated.' }
        format.json { render :show, status: :ok, location: @feedback }
      else
        format.html { render :edit }
        format.json { render json: @feedback.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @feedback.destroy
    respond_to do |format|
      format.html { redirect_to feedbacks_url, notice: 'Feedback was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_feedback
    @feedback = Feedback.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def feedback_params
    params.require(:feedback).permit(:name, :contact, :text)
  end
end
