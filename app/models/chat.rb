class Chat < ApplicationRecord
    #modelフィールドにrelationを設定した場合はoptionalをつける
    belongs_to :user, optional: true
end
