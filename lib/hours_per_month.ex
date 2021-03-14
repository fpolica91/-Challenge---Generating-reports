defmodule GenReport.HoursPerMonth do
  alias GenReport.Parser

  @month_index %{
    "1" => "Jan",
    "2" => "Feb",
    "3" => "March",
    "4" => "April",
    "5" => "May",
    "6" => "June",
    "7" => "July",
    "8" => "August",
    "9" => "September",
    "10" => "October",
    "11" => "November",
    "12" => "December"
  }

  def build(filename, list_of_workers) do
    list_months = generate_month_list(filename)
    list_of_workers = create_empty_list(list_of_workers, list_months)

    filename
    |>Parser.parser_file()
    |>Enum.reduce(list_of_workers, fn(entry, report) -> sum_values(entry, report) end)
    |>insert_months_name()

  end

  defp sum_values([name, hours, _day, month, _year], %{} = report) do
    list = Map.put(report[name], month, report[name][month] +  hours)
    %{report | name => list}
  end

  defp insert_months_name(list) do
    list
    |> Enum.reduce(%{}, fn {name, list_of_months}, completed_list ->
      list_with_names =
        list_of_months
        |> Enum.reduce(%{}, fn {k, v}, acc -> Map.put(acc, @month_index[k], v) end)

      Map.put(completed_list, name, list_with_names)
    end)
  end

  defp create_empty_list(list_workers, list_months) do
    list_workers
    |> Enum.into(%{}, fn(worker) ->
      {worker, make_map(list_months)}
    end)
  end


  defp make_map(list) do
    Enum.into(list, %{}, fn(item) -> {item, 0} end)
  end



  defp generate_month_list(file) do
    file
    |> Parser.parser_file()
    |> Enum.map(fn [_name, _hours, _days, months, _years] -> months end)
    |> Enum.uniq()
  end
end
