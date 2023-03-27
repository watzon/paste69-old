class SerializedPaste
  include JSON::Serializable

  property contents : String
  property language : String?
  property fork_of : String?
end

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
