@[LuckySwagger::Action(
  summary: "List available languages",
  responses: [
    Swagger::Response.new(code: "200", description: "Returns the list of languages"),
  ]
)]
class API::V1::Paste::Languages < ApiAction
  get "/api/v1/paste/languages" do
    json({
      success: true,
      data:    {
        languages: ENABLED_LAGUAGES,
      },
    })
  end
end
