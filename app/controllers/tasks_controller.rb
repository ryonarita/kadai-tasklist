class TasksController < ApplicationController
  before_action :set_task, only:[:show, :edit, :update, :destroy]
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]

 def index
  @tasks = Task.all
 end

 def create
   @task = Task.new(task_params)

    if @task.save
      flash[:success] = 'Task が正常に投稿されました'
      redirect_to @task
      # HTTPリクエストを発生させるためflash
    else
      flash.now[:danger] = 'Task が投稿されませんでした'
      render :new
      # HTTPリクエスト発生させないためflash.now
    end
 end

 def new
    @task = Task.new
   # @task = Task.new(cntent: 'sample')
   # contetカラムにあらかじめ値を代入しておく
   # デフォルトの値をフォームに入れておける。
 end

 def edit
#   @task = Task.find(params[:id])
 end

 def show
#   @task = Task.find(params[:id])
 end

 def update
#     @task = Task.find(params[:id])

    if @task.update(task_params)
      flash[:success] = 'Task は正常に更新されました'
      redirect_to @task
    else
      flash.now[:danger] = 'Task は更新されませんでした'
      render :edit
    end
 end

 def destroy
#    @task = Task.find(params[:id])
    @task.destroy

    flash[:success] = 'Task は正常に削除されました'
    redirect_to tasks_url
    # リダイレクトのときは_url
 end
 
 # 共通化
  def set_task
     @task = Task.find(params[:id])
  end
 
 # Strong Parameter
  def task_params
#    params.require(:task).permit(:content)
    params.require(:task).permit(:content, :status, :user_id)

  end


end
