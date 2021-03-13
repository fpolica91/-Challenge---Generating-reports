defmodule GenReport.Yearly do
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

  def build(file) do
    list = file
    |>generate_list_year()

    list_of_years = Enum.into(@workers_by_name, fn %{} -> create_rep(list) end)
    list_of_years

    # file
    # |>Parser.parser_file()
    # |>Enum.reduce(list_of_years, fn(line, report) -> line end)


  end

  defp sum_values([name, hours, _day, _month, year], %{} = report) do
    list = Map.put(report[name], year, report[name][year] + hours)
    %{report | name => list}
  end

  defp create_rep(list_years) do
    Enum.into(list_years, %{}, &{&1, 0})
  end


  defp generate_list_year(list) do
    list
    |>Parser.parser_file()
    |>Enum.map(fn[_name, _hours, _day, _month, year] -> year end)
    |>Enum.uniq()
  end

end
