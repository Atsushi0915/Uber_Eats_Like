class Restaurant < ApplicationRecord
  has_many :foods
  has_many :line_foods, through: :foods

  validates :name, :fee, :time_required, presence: true  #存在しないとエラー
  validates :name, length: {maximum: 30}                 #文字数制限（30文字以下）
  validates :fee, numericality: {greater_than: 0}        #0以上の数値であること。
  
end
