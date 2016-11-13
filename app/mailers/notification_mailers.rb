class NotificationMailers < ActionMailer::Base

  def send_new_product_registration_notification( product_id )
    @product = Product.where( id: product_id ).first
    @user = @product.creator

    admin_email_ids = AdminUser.all.map(&:email)
    return if admin_email_ids.blank?

    mail( to: admin_email_ids, from: 'reachus@ciosa.org.in', subject: "#{Date.today} New Product Registration Intimation")
  end

  def send_new_organization_registration_notification( organization_id )
    @organization = Organization.where( id: organization_id ).first

    admin_email_ids = AdminUser.all.map(&:email)
    return if admin_email_ids.blank?

    mail( to: admin_email_ids, from: 'reachus@ciosa.org.in', subject: "#{Date.today} New Organization Registration Intimation")
  end

  def send_buy_product_request_intimation( order_user_id, product_hash )
    @product_hash = product_hash
    @buyer_user = User.where( id: order_user_id ).first

    admin_email_ids = AdminUser.all.map(&:email)

    return if admin_email_ids.blank?

    mail( to: admin_email_ids, from: 'reachus@ciosa.org.in', subject: "#{Date.today} Buy Product request Intimation")
  end
end