class TemplatesController < ApplicationController
  before_action :settings

  def index
    @current_menu = { menu: "menu_1", name: "控制台", sub_name: "" }
  end

  def manageuser
    @current_menu = { menu: "menu_2", name: "会员管理", sub_name: "会员审核" }
  end

  def manageshop
    @current_menu = { menu: "menu_3", name: "店铺管理", sub_name: "店铺审核" }
  end

  def login
    render layout: 'pages'
  end

  def forgetpasswd
    render layout: 'pages'
  end

  def admin_login
    render layout: 'pages'
  end
end
