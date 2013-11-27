class QuestionsController < ApplicationController
  # Impressionist
  impressionist :actions => [:show]

  before_action :set_question, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  # CanCan
  load_and_authorize_resource

  # GET /questions
  # GET /questions.json
  def index
    @questions = Question.all.order("created_at DESC")
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
    @question = Question.find(params[:id])
    impressionist(@question)
  end

  # GET /questions/new
  def new
    @question = current_user.questions.build
  end

  # GET /questions/1/edit
  def edit
  end

  # POST /questions
  # POST /questions.json
  def create
    @question = current_user.questions.build(question_params)

    respond_to do |format|
      if @question.save
        format.html { redirect_to @question, notice: 'Question was successfully created.' }
        format.json { render action: 'show', status: :created, location: @question }
      else
        format.html { render action: 'new' }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /questions/1
  # PATCH/PUT /questions/1.json
  def update
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to @question, notice: 'Question was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @question.destroy
    respond_to do |format|
      format.html { redirect_to questions_url }
      format.json { head :no_content }
    end
  end

  # Upvote Question
  def upvote
    @question = Question.find(params[:id])
    @question.upvote_from current_user
    increment_votes_count
    redirect_to @question
  end

  # Downvote Question
  def downvote
    @question = Question.find(params[:id])
    @question.downvote_from current_user
    decrement_votes_count
    redirect_to @question
  end

  def decrement_votes_count
    @question.decrement!(:votes_count)
    @question.save
  end

  def increment_votes_count
    @question.increment!(:votes_count)
    @question.save
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params.require(:question).permit(:title, :body, :slug, :answer)
    end
end
