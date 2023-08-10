defmodule Tiktoken do
  alias Tiktoken.Native

  @default_model "gpt-3.5-turbo"

  def get_chat_completion_max_tokens(messages, opts \\ []) do
    model = Keyword.get(opts, :model, @default_model)

    format(messages)
    |> Native.get_chat_completion_max_tokens(model)
  end

  def num_tokens_from_messages(messages, opts \\ []) do
    model = Keyword.get(opts, :model, @default_model)

    format(messages)
    |> Native.num_tokens_from_messages(model)
  end

  def encode_ordinary(text, opts \\ []) do
    model = Keyword.get(opts, :model, @default_model)
    Native.encode_ordinary(text, model)
  end

  def encode_with_special_tokens(text, opts \\ []) do
    model = Keyword.get(opts, :model, @default_model)
    Native.encode_with_special_tokens(text, model)
  end

  defp format(messages) do
    Enum.map(messages, fn message ->
      message
      |> Map.put_new(:name, nil)
      |> Map.put_new(:content, nil)
      |> Map.put_new(:function_call, nil)
    end)
  end

end
