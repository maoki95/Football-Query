class InquiryMailer < ApplicationMailer

  default to: ENV['TOMAIL']    # 送信先アドレス
 
  def received_email(inquiry)
    @inquiry = inquiry
    mail(subject: 'お問い合わせを承りました')
  end
end
