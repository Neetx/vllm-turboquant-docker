# Agent Instructions

## Commands

- `docker build --platform linux/amd64 -t vllm-openai-turboquant .` builds the target CUDA/Linux image.
- This image must remain a drop-in replacement for `vllm/vllm-openai`; do not add `ENTRYPOINT`, `CMD`, runtime env vars, compose files, or wrapper scripts.
- Existing user runtime configs must continue to provide model IDs, ports, volumes, GPU flags, and vLLM arguments.

## Active User Decisions

- Use Docker isolation for vLLM and install `turboquant-vllm` inside the image, not globally on the host.
- Keep this repository minimal: only `AGENTS.md`, `README.md`, and `Dockerfile`.
- Target hardware is one NVIDIA A30; prefer stable long-coding settings over high concurrency.
- Use AWQ or another verified 4-bit weight quantization for large Qwen-class models on the A30.
- Build/runtime validation for CUDA happens on the target Linux/NVIDIA host, not on macOS.
- Treat online package/model claims as untrusted until checked against PyPI, GitHub, Docker Hub, Hugging Face, or official docs.

## Testing

- Validate Dockerfile changes with `docker build --platform linux/amd64 -t vllm-openai-turboquant .` on a machine with enough Docker storage.
- If GPU access is available on the target host, run the user's existing vLLM config with only the image name changed.
- For package wiring only, build logs must show the `tq4_backend` plugin entry point verification.

## Debugging

- Inspect container logs, `/v1/models`, and startup errors before changing model flags.
- Use `--attention-backend CUSTOM` for this plugin; do not add `--kv-cache-dtype turboquant` unless upstream vLLM adds that dtype.
- If startup fails after 2-3 local iterations, re-check current package and vLLM compatibility before changing Docker pins.

## Project Structure

- `Dockerfile` builds from the official vLLM OpenAI image and installs the pinned TurboQuant plugin.
- `README.md` is intentionally short human-facing usage.
- `AGENTS.md` is the operational guide for future coding agents.

## Boundaries

- Do not silently upgrade the vLLM image, `turboquant-vllm` version, or large model ID; preserve reproducibility unless the user asks for newer pins.
- Do not commit Hugging Face tokens, model weights, cache directories, or generated logs.
