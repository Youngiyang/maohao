class Seller::BaseController < ApplicationController
  layout 'seller/application'
  include Seller::SessionsHelper
  before_action :authenticated!
  def settings
    @settings = {
      menus: [
        { name: "111",
          id: "menu_1",
          path: temp_index_path,
          icon: "tachometer",
          submenu: []
        },
        { name: "111",
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
        { name: "1111",
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
        { name: "111",
          id: "menu_4",
          path: '',
          icon: "gift",
          submenu: []
        }
      ]
    }
  end
end
