defmodule GenReport do
  alias GenReport.{CumulativeHours, HoursPerYear, HoursPerMonth}


  @workers_by_name [
    "Daniele",
    "Mayk",
    "Giuliano",
    "Cleiton",
    "Jakeliny",
    "Joseph",
    "Diego",
    "Rafael",
    "Danilo",
    "Vinicius"
  ]




  def build(filename) do
    all_worked_hours = filename
    |>CumulativeHours.build(@workers_by_name)

    hours_worked_per_year = filename
    |>HoursPerYear.build(@workers_by_name)

    hours_worked_per_month = filename
    |>HoursPerMonth.build(@workers_by_name)


    %{

      hours_per_month: hours_worked_per_month,
      all_hours: all_worked_hours,
      hours_per_year: hours_worked_per_year
    }

  end


  def hello do
    :world
  end
end
