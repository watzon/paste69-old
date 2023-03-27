class SavePaste < Paste::SaveOperation
  permit_columns :contents, :language

  before_save do
    if self.language.value.nil? || self.language.value.try &.empty?
      self.language.value = "Plain Text"
    end

    self.deletion_token.value = Random.new.urlsafe_base64(16)
  end
end
