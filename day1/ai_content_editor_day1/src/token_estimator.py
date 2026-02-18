import tiktoken
import os

def estimate_tokens_and_cost(text: str, model_name: str = "gpt-4-turbo") -> tuple[int, float]:
    """
    Estimates the token count and cost for a given text using a specified OpenAI model's tokenizer.
    """
    try:
        encoding = tiktoken.encoding_for_model(model_name)
    except KeyError:
        print(f"Warning: Model '{model_name}' not found. Falling back to 'cl100k_base' encoding.", flush=True)
        encoding = tiktoken.get_encoding("cl100k_base")

    tokens = encoding.encode(text)
    token_count = len(tokens)

    # Hypothetical pricing for input tokens (as of late 2023/early 2024, subject to change)
    # GPT-4 Turbo input: $0.01 / 1K tokens
    # GPT-4 Turbo output: $0.03 / 1K tokens
    # For this exercise, we focus on input tokens for outlines.
    cost_per_1k_input_tokens = 0.01

    estimated_cost = (token_count / 1000) * cost_per_1k_input_tokens

    return token_count, estimated_cost

def main():
    print()
    print("="*60)
    print("        AI Content Editor: Tokenomics Deep Dive")
    print("="*60)
    print()

    # Load a long-form outline from a file
    outline_path = os.path.join(os.path.dirname(__file__), 'long_outline.txt')
    if not os.path.exists(outline_path):
        print(f"Error: Outline file not found at {outline_path}", flush=True)
        print("Please ensure 'long_outline.txt' exists in the 'src' directory.", flush=True)
        return

    with open(outline_path, 'r', encoding='utf-8') as f:
        long_outline_text = f.read()

    print("📝 Analyzing Long-Form Content Outline...", flush=True)
    print(flush=True)
    print("-" * 60, flush=True)
    print(f"Outline Character Count: {len(long_outline_text)} characters", flush=True)
    print(flush=True)

    model_to_test = "gpt-4-turbo"
    token_count, estimated_cost = estimate_tokens_and_cost(long_outline_text, model_to_test)

    print("-" * 60, flush=True)
    print(f"📊 Tokenomics Report for Model: {model_to_test}", flush=True)
    print(flush=True)
    print(f"  Total Tokens (Input): {token_count:,}", flush=True)
    print(f"  Estimated Cost (Input): ${estimated_cost:.6f} USD", flush=True)
    print(flush=True)
    print("💡 Insights:", flush=True)
    print(f"  - This estimate is for input tokens only. Output tokens would add to the cost.", flush=True)
    print(f"  - Different models have different tokenization and pricing.", flush=True)
    print(f"  - High token counts impact latency and context window limits.", flush=True)
    print()
    print("="*60)
    print("        Analysis Complete. Optimize for Token Density!")
    print("="*60)
    print()

if __name__ == "__main__":
    main()
