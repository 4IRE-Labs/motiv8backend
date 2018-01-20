# coding: utf-8

class CheckMilestoneStartDate
  prepend SimpleCommand

  def initialize
  end

  def call
    milestones = Milestone.where(start_date: Date.today.midnight..Date.today.end_of_day).all
    milestones.each do |milestone|
      next unless milestone.contract.status == 'started'
      if milestone.sub_milestone
        if milestone.sub_milestone.past?
          milestone.status = :actual
        else
          milestone.update(start_date: 1.day.from_now)
        end
      else
        milestone.status = :actual
      end

      milestone.save!
    end
  rescue => exception
    errors.add(:invitation, exception.to_s)
  else
  end
end
