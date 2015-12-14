class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include Seller::SessionsHelper
  include Admin::SessionsHelper
  before_action :authenticated!


  def settings
    @settings = {
      menus: [
        { name: "控制台",
          id: "menu_1",
          path: temp_index_path,
          icon: "tachometer",
          submenu: []
        },
        { name: "会员管理",
          id: "menu_2",
          path: '',
          icon: "users",
          submenu: [
            { name: "会员审核",
              path: temp_manageuser_path
            },
            { name: "会员迁移",
              path: temp_manageuser_path
            }
          ]
        },
        { name: "店铺管理",
          id: "menu_3",
          path: '',
          icon: "home",
          submenu: [
            { name: "店铺审核",
              path: temp_manageshop_path
            },
            { name: "店铺迁移",
              path: temp_manageshop_path
            }
          ]
        },
        { name: "营销促销",
          id: "menu_4",
          path: '',
          icon: "gift",
          submenu: []
        }
      ]
    }
  end
end
