
module BxBlockDashboard
  class BottleDepositDetailsController < ApplicationController
    def index
      bottle_deposit_details = @current_user.recycle_bottle.bottle_deposit_details
      if bottle_deposit_details.present?
        @records = {}
        if params["monthly"] == "true"
          details = bottle_deposit_details.find_by_sql("select  date_trunc('month', created_at) as date, sum(no_of_bottle) as total  from bottle_deposit_details   group by date ORDER BY date ASC").last 6
          details.each do |d|
            @records[d.date.strftime('%B')] = d.total
          end
        else
          start_date = bottle_deposit_details.where('created_at > ?', 28.days.ago).order(created_at: :asc).first.created_at
          end_date = start_date + 6.days
          total = bottle_deposit_details.where('created_at BETWEEN ? AND ?', start_date.beginning_of_day,  end_date.end_of_day).sum(:no_of_bottle)
          @records[start_date.strftime('%d-%B') +"-" +end_date.strftime('%d-%B')] = total

          start_date = end_date+ 1.days
          end_date = start_date + 6.days
          total = bottle_deposit_details.where('created_at BETWEEN ? AND ?', start_date.beginning_of_day,  end_date.end_of_day).sum(:no_of_bottle)
          @records[start_date.strftime('%d-%B') +"-" +end_date.strftime('%d-%B')] = total

          start_date = end_date+ 1.days
          end_date = start_date + 6.days
          total = bottle_deposit_details.where('created_at BETWEEN ? AND ?', start_date.beginning_of_day,  end_date.end_of_day).sum(:no_of_bottle)
          @records[start_date.strftime('%d-%B') +"-" +end_date.strftime('%d-%B')] = total

          start_date = end_date+ 1.days
          end_date = start_date + 6.days
          total = bottle_deposit_details.where('created_at BETWEEN ? AND ?', start_date.beginning_of_day,  end_date.end_of_day).sum(:no_of_bottle)
          @records[start_date.strftime('%d-%B') +"-" +end_date.strftime('%d-%B')] = total
        end
      else
        render json: { message: "bottle deposit details doesn't exists" }, status: :not_found
      end
    end
  end
end
