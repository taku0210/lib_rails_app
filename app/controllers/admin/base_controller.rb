# app/controllers/admin/base_controller.rb
class Admin::BaseController < ApplicationController
  before_action :require_user
  before_action :require_admin

  layout 'admin' # 管理画面用のレイアウトを適用
end