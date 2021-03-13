defmodule GenReport.Parser do
  def parser_file(filename) do
    "reports/#{filename}"
    |>File.stream!()
    |>Stream.map(fn line -> parse_line(line) end)
  end

  defp parse_line(line) do
    line
    |>String.trim()
    |>String.split(",")
    |>List.update_at(1, &String.to_integer/1)
  end



end
# name ->    hours of work -> day -> month -> year
# "Giuliano,       1,          2,     4,      2020\n",
