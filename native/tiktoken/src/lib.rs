use tiktoken_rs::{
    get_bpe_from_model,
    ChatCompletionRequestMessage,
};
use rustler::NifMap;

#[derive(NifMap, Debug)]
struct FunctionCall {
    name: String,
    arguments: String
}

#[derive(NifMap, Debug)]
struct ChatCompletionMessage {
    role: String,
    content: Option<String>,
    name: Option<String>,
    function_call: Option<FunctionCall>,
}

#[rustler::nif]
fn num_tokens_from_messages(messages: Vec<ChatCompletionMessage>, model: &str) -> usize {
    let messages = to_tiktoken_messages(&messages);
    tiktoken_rs::num_tokens_from_messages(model, &messages).unwrap()
}

#[rustler::nif]
fn get_chat_completion_max_tokens(messages: Vec<ChatCompletionMessage>, model: &str) -> usize {
    let messages = to_tiktoken_messages(&messages);
    tiktoken_rs::get_chat_completion_max_tokens(model, &messages).unwrap()
}

#[rustler::nif]
fn encode_ordinary(text: &str, model: &str) -> Vec<usize> {
    get_model(model).encode_ordinary(text)
}

#[rustler::nif]
fn encode_with_special_tokens(text: &str, model: &str) -> Vec<usize> {
    get_model(model).encode_with_special_tokens(text)
}

fn get_model(model: &str) -> tiktoken_rs::CoreBPE {
    match get_bpe_from_model(model) {
        Ok(bpe) => bpe,
        Err(_) => match model {
            "cl100k_base" => tiktoken_rs::cl100k_base().unwrap(),
            "p50k_base" => tiktoken_rs::p50k_base().unwrap(),
            "p50k_edit" => tiktoken_rs::p50k_edit().unwrap(),
            "r50k_base" => tiktoken_rs::r50k_base().unwrap(),
            _ => panic!("model {} not found", model)
        }
    }
}

fn to_tiktoken_messages(messages: &[ChatCompletionMessage]) -> Vec<ChatCompletionRequestMessage> {
    messages.iter().map(|message| {
        ChatCompletionRequestMessage {
            role: message.role.to_owned(),
            content: message.content.to_owned(),
            name: message.name.to_owned(),
            function_call: match &message.function_call {
                Some(function_call) => Some(tiktoken_rs::FunctionCall {
                    name: function_call.name.to_owned(),
                    arguments: function_call.arguments.to_owned()
                }),
                None => None
            }
            
        }
    }).collect()
}

rustler::init!("Elixir.Tiktoken.Native", [
    num_tokens_from_messages,
    get_chat_completion_max_tokens,
    encode_ordinary,
    encode_with_special_tokens
]);
