# encoding: utf-8
class Users::RegistrationsController < Devise::RegistrationsController

  def is_uid_exist
    uid = params[:uid]
    user = User.find_by(uid: uid)

    respond_to do |format|
      if user.nil?
        format.json{ render json: { message: "用户名 #{uid} 可以使用" } }
      else
        format.json { render json: { message: "用户名 #{uid} 已经存在" }, status: 403}
      end
    end
  end

  protected
  # The path used after sign up. You need to overwrite this method
  # in your own RegistrationsController.
  def after_sign_up_path_for(resource)
    after_sign_in_path_for(resource)
  end

  def after_update_path_for(resource)
    case resource
    when :user, User
      resource.teacher? ? another_path : root_path
    else
      super
    end
  end

end