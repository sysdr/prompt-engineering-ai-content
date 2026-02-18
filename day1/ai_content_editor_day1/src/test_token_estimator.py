"""Tests for token_estimator module."""
import sys
import os
sys.path.insert(0, os.path.dirname(__file__))
from token_estimator import estimate_tokens_and_cost


def test_estimate_tokens_and_cost_returns_tuple():
    text = "Hello world"
    count, cost = estimate_tokens_and_cost(text)
    assert isinstance(count, int)
    assert isinstance(cost, (int, float))
    assert count >= 0
    assert cost >= 0


def test_estimate_tokens_and_cost_scales_with_text():
    short_count, _ = estimate_tokens_and_cost("Hi")
    long_count, _ = estimate_tokens_and_cost("Hello world " * 100)
    assert long_count > short_count


def test_estimate_tokens_and_cost_fallback_encoding():
    count, cost = estimate_tokens_and_cost("Test", model_name="gpt-4-turbo")
    assert count > 0
    assert cost >= 0
