class SerializedPaste
  include JSON::Serializable

  property contents : String
  property language : String?
  property fork_of : String?
end

@[LuckySwagger::Action(
  summary: "Create a new paste",
  request: Swagger::Request.new(
    description: "The paste to create",
    properties: [
      Swagger::Property.new(name: "contents", type: "string", required: true),
      Swagger::Property.new(name: "language", type: "string"),
      Swagger::Property.new(name: "fork_of", type: "string"),
    ],
    content_type: "application/json",
  ),
  responses: [
    Swagger::Response.new(code: "200", description: "Paste created"),
    Swagger::Response.new(code: "422", description: "Invalid parameters"),
  ]
)]
class API::V1::Paste::Create < ApiAction
  post "/api/v1/paste" do
    serialized_paste = SerializedPaste.from_json(params.body)
    SavePasteJson.create(serialized_paste: serialized_paste) do |op, paste|
      if paste
        json PasteSerializer.new(paste)
      else
        json ErrorSerializer.new(success: false, error: "Invalid parameters"), status: 422
      end
    end
  end
end
