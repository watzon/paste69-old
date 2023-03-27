class CreatePastes::V20230324233635 < Avram::Migrator::Migration::V1
  def migrate
    # Learn about migrations at: https://luckyframework.org/guides/database/migrations
    create table_for(Paste) do
      primary_key id : Int64
      add contents : String
      add language : String
      add views : Int32, default: 0
      add deletion_token : String
      add_belongs_to fork_of : Paste?, on_delete: :nullify
      add_timestamps
    end
  end

  def rollback
    drop table_for(Paste)
  end
end
