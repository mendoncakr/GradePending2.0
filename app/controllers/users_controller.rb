class UsersController < ApplicationController
	def index
		@user = User.find(current_user.id)
		@favorites = @user.favorites
	end
end
