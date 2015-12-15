class Seller::UsersController < Seller::BaseController

  def show
    @current_menu = { menu: "menu_1", name: "控制台", sub_name: "" }
    @user = current_user
  end

end
