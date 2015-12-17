class Admin::AdminsController < Admin::BaseController
  def show
    @current_menu = { menu: "menu_1", name: "控制台", sub_name: "" }
    @admin = current_admin
  end
end
