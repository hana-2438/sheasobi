class Report < ApplicationRecord
  belongs_to :reporter, class_name: "Member"
  belongs_to :reported, class_name: "Member"

  validates :reason, presence:true

  # 通報ステータス（対応待ち、保留、対応中、対応済）
  enum report_status: { waiting: 0, keep: 1, in_progress: 2, finish: 3 }
end
