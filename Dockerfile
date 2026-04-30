ARG VLLM_IMAGE=vllm/vllm-openai:v0.19.1
FROM ${VLLM_IMAGE}

ARG TURBOQUANT_VERSION=1.5.0

RUN python3 -c "import importlib.metadata as m; pkgs=('vllm','torch','torchvision','transformers','triton'); print('\n'.join(f'{p}=={m.version(p)}' for p in pkgs))" > /tmp/base-constraints.txt \
    && python3 -m pip install --no-cache-dir -c /tmp/base-constraints.txt "turboquant-vllm[vllm]==${TURBOQUANT_VERSION}"
