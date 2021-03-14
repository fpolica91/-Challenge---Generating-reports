defmodule GenReport.HoursPerYear do
  alias GenReport.Parser

  def build(filename, list_of_workers) do
    list_years = generate_year_list(filename)
    list_of_workers = create_empty_list(list_of_workers, list_years)

    filename
    |>Parser.parser_file()
    |>Enum.reduce(list_of_workers, fn(entry, report) -> sum_values(entry, report) end)

  end


  # first argument is entry
  # ["name", "hours", "blah blah"]

  # second argument is this map
  # "Vinicius" => %{
  #   "2016" => 0,
  #   "2017" => 0,
  #   "2018" => 0,
  #   "2019" => 0,
  #   "2020" => 0

  defp sum_values([name, hours, _day, _month, year], %{} = report) do
    list =  Map.put(report[name], year, report[name][year] +  hours)
    %{report | name => list}
  end



  # defp sum_values([name, hours, _day, _month, year], %{} = report) do
  #   list = Map.put(report[name], year, report[name][year] + hours)
  #   %{report | name => list}
  # end



  defp create_empty_list(list_workers, list_years) do
    list_workers
    |> Enum.into(%{}, fn(worker) ->
      {worker, make_map(list_years)}
    end)
  end


  defp make_map(list) do
    Enum.into(list, %{}, fn(item) -> {item, 0} end)
  end



  defp generate_year_list(file) do
    file
    |> Parser.parser_file()
    |> Enum.map(fn [_name, _hours, _days, _months, years] -> years end)
    |> Enum.uniq()
  end
end
