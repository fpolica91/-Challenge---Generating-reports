defmodule GenReport do
  alias GenReport.Parser

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
    filename
    |> Parser.parser_file()
    |> Enum.reduce(create_empty_report(), fn line, report -> sum_values(line, report) end)
  end

  defp sum_values([name, hours, _day, _month, _year], report) do
     Map.put(report, name, report[name] + hours)
  end

  def create_empty_report() do
    Enum.into(@workers_by_name, %{}, &{&1, 0})
  end

  def hello do
    :world
  end
end
