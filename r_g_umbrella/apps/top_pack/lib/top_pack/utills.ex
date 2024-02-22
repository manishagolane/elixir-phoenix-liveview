defmodule TopPack.Utills do
  alias NimbleCSV.RFC4180, as: CSV

  @spec parse_csv(
          binary()
          | maybe_improper_list(
              binary() | maybe_improper_list(any(), binary() | []) | char(),
              binary() | []
            )
        ) :: list()
  def parse_csv(local_path) do
    {:ok, file} = File.read(local_path)
    CSV.parse_string(file)
  end

end
