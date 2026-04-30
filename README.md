# vLLM + TurboQuant Docker

Drop-in image di `vllm/vllm-openai` con `turboquant-vllm` installato.

```bash
docker build --platform linux/amd64 -t vllm-openai-turboquant .
```

Usala al posto dell'immagine originale nelle tue configurazioni vLLM.

Nota: per attivare TurboQuant il runtime vLLM deve usare `--attention-backend CUSTOM`.
