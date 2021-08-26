CSV.generate force_quotes: true do | csv |
  # csv << [schedule.destination]
  @month_array.each do |month|
    @company.employees.each do |employee|
      date = Date.parse("%04d%02d01"%[month[0], month[1]]).end_of_month
      monthly_total = employee.monthly_total(date.year, date.month)
      if monthly_total > 0
        line = [
          "2000",
          "",
          "",
          l( date ),
          "旅費交通費",
          "旅費精算書",
          "",
          "課対仕入込10%",
          monthly_total,
          "",
          "役員借入金",
          "藤岡",
          "",
          "対象外",
          monthly_total,
          "",
          "%s %d年%d月"%[employee.name, date.year, date.month],
          "",
          "",
          "0",
          "",
          "",
          "",
          "",
          "",
        ]
        csv << line
      end
    end
  end
end

