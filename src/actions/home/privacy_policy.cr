class Home::PrivacyPolicy < BrowserAction
  get "/privacy_policy" do
    html Home::PrivacyPolicyPage
  end
end
