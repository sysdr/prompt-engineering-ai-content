#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

PROJECT_DIR="ai_content_editor_day1"
SRC_DIR="$PROJECT_DIR/src"
VENV_DIR="$PROJECT_DIR/.venv"
REQUIREMENTS_FILE="$SRC_DIR/requirements.txt"
MAIN_SCRIPT="$SRC_DIR/token_estimator.py"
OUTLINE_FILE="$SRC_DIR/long_outline.txt"
DOCKER_IMAGE_NAME="token-estimator-day1"
DOCKER_CONTAINER_NAME="token-estimator-instance"

echo "🚀 Starting Day 1: Decoding Tokenomics Project Setup..."

# 1. Create project directory and source directory
echo "📂 Creating project structure..."
mkdir -p "$SRC_DIR"

# 2. Create requirements.txt
echo "📝 Creating requirements.txt..."
cat << EOF > "$REQUIREMENTS_FILE"
tiktoken==0.7.0
EOF

# 3. Create the main Python script
echo "🐍 Creating token_estimator.py..."
cat << 'EOF' > "$MAIN_SCRIPT"
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
EOF

# 4. Create a sample long-form outline file
echo "📄 Creating sample long_outline.txt..."
cat << 'OUTLINE_EOF' > "$OUTLINE_FILE"
Title: The Industrialization of Prompt Engineering: From Experimentation to Scalable Infrastructure

I. Introduction
    A. The Shifting Landscape of AI (2023-2025)
        1. Early stages: Exploratory, manual prompt tuning
        2. Current state: Industrial-scale infrastructure, automated workflows
    B. Rationale for Industrialization
        1. Growing demand for AI-generated content
        2. Need for consistency, quality, and cost-efficiency
        3. Limitations of manual prompt engineering at scale
    C. Overview of the "Self-Governing Content Ecosystem"
        1. Definition and core principles
        2. How it addresses current challenges
        3. Roadmap for the course: practical system design through product implementation

II. Foundational Concepts: Tokenomics in Action
    A. What are Tokens?
        1. Beyond words: subword units and BPE (Byte Pair Encoding)
        2. Model-specific tokenizers (e.g., tiktoken for OpenAI)
        3. The critical difference from simple word counts
    B. The Economics of Tokens
        1. API pricing models (input vs. output tokens)
        2. Calculating cost: real-time estimation for large content blocks
        3. Budgeting and cost control in AI-driven systems
    C. Token Density and Context Windows
        1. Maximizing information per token: efficiency and conciseness
        2. Managing context window limits for long-form content
        3. Strategies for chunking, summarization, and retrieval-augmented generation (RAG)
    D. Impact on System Design
        1. Latency considerations for token processing
        2. Rate limiting and quota management
        3. Distributed token estimation services for high-throughput environments

III. Designing the Automated Content Editor (Conceptual Overview for the Course)
    A. Core Components
        1. Prompt Orchestration Engine: Dynamic prompt generation
        2. Content Generation Modules: Specialized LLM interactions
        3. Quality Assurance & Refinement: Automated feedback loops
        4. User Interface/API Layer: Integration points
    B. Data Flow and Control Flow
        1. User/System input -> Outline generation -> Content generation -> Review
        2. Integration of tokenomics checks at each stage
    C. Resilience and Scalability
        1. Handling LLM API failures and retries
        2. Horizontal scaling for concurrent content generation
        3. Monitoring and observability for performance and cost

IV. Practical Implementation: Day 1 Focus - Building the Token Estimator
    A. Setting up the environment (Python, virtualenv, tiktoken)
    B. Implementing the `estimate_tokens_and_cost` function
    C. Integrating with our sample long-form outline
    D. Interpreting the results: token count and estimated cost

V. Conclusion
    A. Recap of Tokenomics importance
    B. The path forward: building out the content ecosystem
    C. Next steps: assignment and preparation for future modules

OUTLINE_EOF

# 5. Setup Python virtual environment
echo "🐍 Setting up Python virtual environment..."
python3 -m venv "$VENV_DIR"
source "$VENV_DIR/bin/activate"

# 6. Install dependencies
echo "📦 Installing dependencies from $REQUIREMENTS_FILE..."
pip install -r "$REQUIREMENTS_FILE"

# 7. Run the Python script (without Docker)
echo "---"
echo "Running Token Estimator (without Docker):"
echo "---"
python3 "$MAIN_SCRIPT"

# 8. Deactivate virtual environment
deactivate
echo "Python virtual environment deactivated."

# 9. Build Docker image
echo "---"
echo "Building Docker image for Token Estimator..."
echo "---"
cat << EOF > "$PROJECT_DIR/Dockerfile"
# Use an official Python runtime as a parent image
FROM python:3.9-slim-buster

# Set the working directory in the container
WORKDIR /app

# Copy the requirements file into the container at /app
COPY src/requirements.txt ./

# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code into the container at /app
COPY src/ .

# Run the Python script when the container launches
CMD ["python", "token_estimator.py"]
EOF

docker build -t "$DOCKER_IMAGE_NAME" "$PROJECT_DIR"
echo "Docker image '$DOCKER_IMAGE_NAME' built successfully."

# 10. Run Docker container
echo "---"
echo "Running Token Estimator (with Docker):"
echo "---"
docker run --rm --name "$DOCKER_CONTAINER_NAME" "$DOCKER_IMAGE_NAME"

echo "---"
echo "✅ Day 1 Project Setup and Demo Complete!"
echo "To clean up, run: ./stop.sh"