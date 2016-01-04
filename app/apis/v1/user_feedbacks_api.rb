module V1
  class UserFeedbacksAPI < Grape::API
    namespace 'user/feedbacks' do
      params do
        requires :content
      end
      post '' do
        authenticate_by_token!
        UserFeedback.create!(user_id: current_user.id, content: params[:content])
      end
    end
  end
end
