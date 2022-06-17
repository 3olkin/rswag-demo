class UsersController < ApplicationController
  def whoami
    render_json current_user
  end
end
