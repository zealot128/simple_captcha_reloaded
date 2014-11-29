class CreateSimpleCaptchaReloadedSimpleCaptchaReloadedData < ActiveRecord::Migration
  def change
    create_table :simple_captcha_reloaded_simple_captcha_reloaded_data do |t|
      t.string :key
      t.string :value

      t.timestamps
    end
  end
end
