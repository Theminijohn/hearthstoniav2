class AnswersController < ApplicationController
  before_action :set_answer, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  # CanCan
  load_and_authorize_resource

  # GET /answers
  # GET /answers.json
  def index
    @answers = Answer.all
  end

  # GET /answers/1
  # GET /answers/1.json
  def show
  end

  # GET /answers/new
  def new
    @answer = current_user.answers.build
  end

  # GET /answers/1/edit
  def edit
    @question = Question.find(params[:question_id])
    @answer = current_user.answers.find(params[:id])
  end

  # POST /answers
  # POST /answers.json
  def create
    @question = Question.find(params[:question_id])
    @answer = current_user.answers.build(answer_params)
    @answer.question_id = @question.id

    respond_to do |format|
      if @answer.save
        format.html { redirect_to @question, notice: 'Answer was successfully created.' }
        format.json { render action: 'show', status: :created, location: @answer }
      else
        format.html { render action: 'new' }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /answers/1
  # PATCH/PUT /answers/1.json
  def update
    respond_to do |format|
      if @answer.update(answer_params)
        format.html { redirect_to question_path(@answer.question), notice: 'You edited your answer Successfully.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /answers/1
  # DELETE /answers/1.json
  def destroy
    @answer.destroy
    respond_to do |format|
      format.html { redirect_to :back }
      format.json { head :no_content }
    end
  end

  # Upvote Question
  def upvote
    @answer = Answer.find(params[:id])
    @answer.upvote_from current_user
    increment_votes_count
    redirect_to :back
  end

  # Downvote Question
  def downvote
    @answer = Answer.find(params[:id])
    @answer.downvote_from current_user
    decrement_votes_count
    redirect_to :back
  end

  def decrement_votes_count
    @answer.decrement!(:votes_count)
    @answer.save
  end

  def increment_votes_count
    @answer.increment!(:votes_count)
    @answer.save
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_answer
      @answer = Answer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def answer_params
      params.require(:answer).permit(:question_id, :body)
    end
end
