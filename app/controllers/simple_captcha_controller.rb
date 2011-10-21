class SimpleCaptchaController < ActionController::Base
  include Rails.version.to_f <= 3.0 ? ActionController::Streaming : ActionController::DataStreaming

  # GET /simple_captcha
  def show
    unless params[:id].blank?
      begin
        send_file(
          generate_simple_captcha_image(params[:id]),
          :type => 'image/jpeg',
          :disposition => 'inline',
          :filename => 'simple_captcha.jpg')
      rescue SimpleCaptchaError => e
        self.response_body = [404, {"Content-Type" => "text/html"}, ["Not Found"]]
      end
    else
      self.response_body = [404, {"Content-Type" => "text/html"}, ["Not Found"]]
    end
  end
end
