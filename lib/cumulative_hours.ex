defmodule GenReport.CumulativeHours do
  alias GenReport.Parser

  def build(filename, list_of_workers) do
    list_of_workers = create_empty_report(list_of_workers)

    filename
    |>Parser.parser_file()
    |>Enum.reduce(list_of_workers, fn line, report -> sum_values(line, report) end)
  end

  defp sum_values([name, hours, _day, _month, _year], report) do
    # map put args
    # 1. where is it going, 2. the key, 3. the value
     Map.put(report, name, report[name] + hours)
  end

  def create_empty_report(list) do
    list
    |> Enum.into(%{}, &{&1, 0})
  end

end
