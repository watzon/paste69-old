class Shared::Tracking < BaseComponent
  def render
    noscript do
      img src: "https://analytics.watzon.tech/ingress/645c9383-02f7-4619-b854-0ab5a4337e9c/pixel.gif"
    end
    script defer: true, src: "https://analytics.watzon.tech/ingress/645c9383-02f7-4619-b854-0ab5a4337e9c/script.js"
  end
end
