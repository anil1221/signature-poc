class CreateDocuments < ActiveRecord::Migration[6.0]
  def change
    create_table :documents do |t|
      t.binary :signature
      t.datetime :signed_on
      t.timestamps
    end
  end
end
