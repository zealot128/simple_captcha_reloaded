class CreateSimpleCaptchaReloadedSimpleCaptchaReloadedData < ActiveRecord::Migration
  def change
    create_table :simple_captcha_reloaded_data do |t|
      t.string :key, limit: 128
      t.string :value, limit: 8
      t.timestamps
    end
  end
end
