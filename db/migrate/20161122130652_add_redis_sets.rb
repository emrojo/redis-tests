class AddRedisSets < ActiveRecord::Migration[5.0]
  def change
    create_table :redis_sets do |t|
      t.string :uuid
      t.string :name
      t.timestamps
    end  	
  end
end
