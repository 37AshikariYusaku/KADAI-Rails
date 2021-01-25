class CommentsController < ApplicationController
	# def create
	# 	comment = Comment.new(comment_params)
	# 	comment.user_id = current_user.id
	# 	comment.topic_id = comment.user_id
		
	# 	topic = Topic.find_by(params[:user_id])
	# 	@comments = topic.comments.build
		
	# 	if comment.save
	# 		redirect_to topics_path success: 'コメントしました'
	# 	else
	# 		redirect_to topics_path danger: 'コメントに失敗しました'
	# 	end	
		
	# end
	
	def create
		@topic = Topic.find_by(params[:user_id])
		@comment = @topic.comments.build(comment_params)
		@comment.user_id = current_user.id
		@comment.topic_id = @comment.user_id
		
		if @comment.save
			redirect_to topics_path success: 'コメントしました'
		else
			@topic = Topic.find_by(params[:user_id])
			@comments = @topic.comments.includes(:user)
			flash.now[:danger] = 'コメントに失敗しました'
			render 'topics/show'
		end
	end	
	
	
	
		private 
		def comment_params
			params.require(:comment).permit(:content)
		end	
end
