defmodule Tiktoken.Native do
  @moduledoc false

  source_url = Mix.Project.config()[:source_url]
  version = Mix.Project.config()[:version]

  use RustlerPrecompiled, otp_app: :tiktoken,
    base_url: "#{source_url}/releases/download/v#{version}",
    force_build: System.get_env("FORCE_TIKTOKEN_BUILD") not in [nil, ""],
    targets: RustlerPrecompiled.Config.default_targets() -- ["x86_64-pc-windows-gnu", "x86_64-pc-windows-msvc"],
    nif_versions: ["2.16", "2.15"],
    version: version

  def get_chat_completion_max_tokens(_messages, _model) do
    :erlang.nif_error(:nif_not_loaded)
  end

  def num_tokens_from_messages(_messages, _model) do
    :erlang.nif_error(:nif_not_loaded)
  end

  def encode_ordinary(_text, _model) do
    :erlang.nif_error(:nif_not_loaded)
  end

  def encode_with_special_tokens(_text, _model) do
    :erlang.nif_error(:nif_not_loaded)
  end
end
