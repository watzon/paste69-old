class SerializedPaste
  include JSON::Serializable

  property contents : String
  property language : String?
  property extension : String?
  property fork_of : String?
end

@[LuckySwagger::Action(
  summary: "Create a new paste",
  request: Swagger::Request.new(
    description: "The paste to create. Optionally provide a language or file extension to set the language.",
    properties: [
      Swagger::Property.new(name: "contents", type: "string", required: true),
      Swagger::Property.new(name: "language", type: "string", default_value: nil),
      Swagger::Property.new(name: "extension", type: "string", default_value: nil),
      Swagger::Property.new(name: "fork_of", type: "string", default_value: nil),
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
    content_type = request.headers["Content-Type"]?
    if content_type == "text/plain"
      contents = params.body
      extension = params.get?(:extension)
      language = EXTENSION_TO_LANGUAGE[extension]? || params.get?(:language)
      language = language.nil? || language.empty? ? "plaintext" : language

      if !LANGUAGE_TO_EXTENSION.has_key?(language)
        return json ErrorSerializer.new(success: false, error: "Invalid language"), status: 422
      end

      SavePaste.create(contents: contents, language: language) do |op, paste|
        if paste
          json PasteSerializer.new(paste, true)
        else
          json ErrorSerializer.new(success: false, error: "Invalid parameters"), status: 422
        end
      end
    else
      serialized_paste = SerializedPaste.from_json(params.body)
      SavePasteJson.create(serialized_paste: serialized_paste) do |op, paste|
        if paste
          json PasteSerializer.new(paste, true)
        else
          json ErrorSerializer.new(success: false, error: "Invalid parameters"), status: 422
        end
      end
    end
  end
end
