@[LuckySwagger::Action(
  summary: "Delete a paste",
  responses: [
    Swagger::Response.new(code: "200", description: "Paste deleted"),
    Swagger::Response.new(code: "422", description: "Invalid deletion token")
  ]
)]
class API::V1::Paste::Delete < ApiAction
  param deletion_token : String = "Hello World"

  delete "/api/v1/paste/:hashed_id" do
    id = Hashids.instance.decode(hashed_id).first
    paste = PasteQuery.find(id)
    if paste.deletion_token == deletion_token
      DeletePaste.delete!(paste)
      json({ success: true })
    else
      json ErrorSerializer.new(success: false, error: "Invalid deletion token", param: "deletion_token")
    end
  end
end
