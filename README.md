# Tiktoken

Why not [tiktoken](https://hex.pm/packages/tiktoken)?
1. I couldn't get it to compile.
2. This uses [rustler_precompiled](https://hex.pm/packages/rustler_precompiled), so you don't need the Rust tool chain installed.
3. This exposes some additional helpful functions, namely
   * `get_chat_completion_max_tokens`
   * `num_tokens_from_messages`

## Installation

This package is not available in [Hex](https://hex.pm/docs/publish), you must install via `git`.

```elixir
def deps do
  [
    {:tiktoken, "~> 0.1.0", git: "https://github.com/cjbottaro/tiktoken_ex"}
  ]
end
```

## Usage

The default model is `"gpt-3.5-turbo"`.

```elixir
iex> Tiktoken.encode_with_special_tokens("Hello, world!")
[9906, 11, 1917, 0]

iex> Tiktoken.encode_with_special_tokens("Hello, world!", model: "gpt-4")
[9906, 11, 1917, 0]

iex> Tiktoken.num_tokens_from_messages([%{role: "system", content: "You are a good bot."}])
14

iex> Tiktoken.num_tokens_from_messages([%{role: "system", content: "You are a good bot."}], model: "gpt-4")
13

iex> Tiktoken.get_chat_completion_max_tokens([%{role: "system", content: "You are a good bot."}])
4082

Tiktoken.get_chat_completion_max_tokens([%{role: "system", content: "You are a good bot."}], model: "gpt-4")
8179
```
