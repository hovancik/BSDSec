# Be sure to restart your server when you modify this file.

# Define an application-wide content security policy.
# See the Securing Rails Applications Guide for more information:
# https://guides.rubyonrails.org/security.html#content-security-policy-header

Rails.application.configure do
  config.content_security_policy do |policy|
    policy.default_src :self
    policy.font_src    :self, "https://fonts.googleapis.com", "https://fonts.gstatic.com"
    policy.img_src     :self, "https://img.shields.io", "https://motif.imgix.com", :data
    policy.object_src  :none
    policy.script_src  :none
    policy.style_src   :self, "https://fonts.googleapis.com"
    policy.frame_src   :none
    policy.frame_ancestors :none
    policy.form_action :self
    policy.base_uri    :self
    policy.connect_src :self
  end

  # Report violations without enforcing the policy.
  # Uncomment when first deploying, then remove after confirming no issues.
  # config.content_security_policy_report_only = true
end
