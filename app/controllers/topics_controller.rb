class TopicsController < ApplicationController
  def new
    @topic = Topic.new
  end
  
  def index
    # @topics = Topic.all
    @topics = Topic.all.includes(:favorite_users)
    # N+1問題、favorite_usersの検索を一度にまとめて行うメソッド「includes」
  end
  
  def create
    @topic = current_user.topics.new(topic_params)
  # Userモデルでhas_many :topicsを定義しているため、上記のようなtopicsメソッドを使える
  # ログインしているユーザーに紐づく画像データを生成
  
    if @topic.save
      redirect_to topics_path, success: '投稿に成功しました'
    else
      flash.now[:danger] = "投稿に失敗しました"
      render :new
    end
  end
  
  
  # def show
  #   @topic = Topic.find(params[:id])
  #   @comments = @topic.comments
  #   @comment = Comment.new
  # end  
    
  
  private
  def topic_params
    params.require(:topic).permit(:image, :description)
  end  
   
end
