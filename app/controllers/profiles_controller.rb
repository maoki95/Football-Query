class ProfilesController < ApplicationController
  before_action :set_user, only: %i[edit update]

   def edit; end
 
   def update
     if @user.update(user_params)
       redirect_to profile_path, success: 'ユーザー情報を変更しました'
     else
       flash.now['danger'] = t('defaults.message.not_updated', item: User.model_name.human)
       render :edit
     end
   end
 
   def show
    @questions = current_user.questions.all.order(created_at: :desc)
   end
 
   private
 
   def set_user
     @user = User.find(current_user.id)
   end
 
   def user_params
     params.require(:user).permit(:email, :name, :avatar, :introduce)
   end
end
