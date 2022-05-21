class LineFood < ApplicationRecord
  belongs_to :food
  belongs_to :restaurant
  belongs_to :order, optional: true    # optional: true・・・関連付けが存在しなくてもいいという意味

  validates :count, numericality: { greater_than: 0 }

  scope :active, ->{ where(active: true) }    #全てのLineFoodからwhere で active: true なもの一覧をActiveRecord_Reletion のかたちで返してくれる。
  scope :other_restaurant, -> (picked_restaurant_id) { where.not(restaurant_id: picked_restaurant_id)}
   #「他の店舗のLineFood」があるかどうか？をチェックする際にこのscopeを利用する。
   #もし「他の店舗のLineFood」があった場合、ここには１つ以上の関連するActiveRecord_Relationが入る。

  def total_amount
    food.price * count
    # line_foodインスタンスの合計価格を算出。コントローラーではなくモデルに記述することで様々な場所から呼び出すことができる。
  end
end
