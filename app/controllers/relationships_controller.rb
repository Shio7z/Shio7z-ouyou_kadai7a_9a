class RelationshipsController < ApplicationController
    def create
        #params idはフォローする相手 (一覧のuser id)
        current_user.follow(params[:user_id])
        redirect_to request.referer
      end
      
      def destroy
        current_user.unfollow(params[:user_id])
        redirect_to request.referer
      end
end
