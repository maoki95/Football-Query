class InquiriesController < ApplicationController
  skip_before_action :require_login, only: %i[index confirm thanks]

  def index
    # 入力画面を表示
    @inquiry = Inquiry.new
    render :index
  end
 
  def confirm
    # 入力値のチェック
    @inquiry = Inquiry.new(inquiry_params)
    if @inquiry.valid?
      # OK。確認画面を表示
      render :confirm
    else
      # NG。入力画面を再表示
      render :index
    end
  end
 
  def thanks
    # メール送信
    @inquiry = Inquiry.new(inquiry_params)
    InquiryMailer.received_email(@inquiry).deliver
 
    # 完了画面を表示
    render :thanks
  end

  def inquiry_params
    params.require(:inquiry).permit(:name, :email, :message)
  end
end
